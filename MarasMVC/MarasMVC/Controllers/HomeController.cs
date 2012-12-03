using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.Mvc;
using MarasMVC.Models;


namespace MarasMVC.Controllers
{
    [HandleError]
    public class HomeController : Controller
    {


            static Expression<Func<TElement, bool>> BuildContainsExpression<TElement, TValue>(

            Expression<Func<TElement, TValue>> valueSelector, IEnumerable<TValue> values)
            {

            if (null == valueSelector) { throw new ArgumentNullException("valueSelector"); }

            if (null == values) { throw new ArgumentNullException("values"); }

            ParameterExpression p = valueSelector.Parameters.Single();

            

            if (!values.Any())
            {

                return e => false;

            }

            var equals = values.Select(value => (Expression)Expression.Equal(valueSelector.Body, Expression.Constant(value, typeof(TValue))));

            var body = equals.Aggregate<Expression>((accumulate, equal) => Expression.Or(accumulate, equal));

            return Expression.Lambda<Func<TElement, bool>>(body, p);

        }



        private sklepEntities _db = new sklepEntities();



        public static string Label(string target, string text)
        {
            String ret = "";
       //     if (User.Identity.IsAuthenticated)
                ret = " <p><%= Html.ActionLink(\"Create New\", \"Create\") %></p>";
            return ret;
        }

        public string Rend()
        {
            bool i = User.Identity.IsAuthenticated;
            string ret = "";
            if (i) ret = "zalogowany";
            return ret;

        }


        public ActionResult Index()
        {
            ViewData["Message"] = "Welcome to ASP.NET MVC!";

            return View();
        }


        public ActionResult Products()
        {
            //bool sale = User.Identity.IsAuthenticated;
            bool sale = User.IsInRole("Sprzedawca");
            if (sale)
                ViewData["Msg"] = " - zarządzanie katalogiem";
            else
                ViewData["Msg"] = " - katalog";
            return View(_db.Produkt.ToList());

        }


        [Authorize]
        public ActionResult MyCart()
        {
            /*
            string klient_name = this.User.Identity.Name;

            
            var nr_klienta = (from c in _db.Klinet 
                                  where c.Login == klient_name
                                  select c.NrKlienta).First();
        
            
            List<decimal> products_ids = (from m in _db.RejestrZamowien
                              where m.NrKlienta == nr_klienta
                              select m.NrProduktu).ToList();


            List<Produkt> cart_products = new List<Produkt>();
            foreach (var list in products_ids)
            {
                cart_products.Add((from n in _db.Produkt
                                  where n.NrProduktu == list
                                  select n).First());

            }
            */




            //*************************
            //ciasteczka

            var cook = HttpContext.Request.Cookies.Get(User.Identity.Name + "myCookieCart");
            

            
            // cookie
          //  string HTTP_USER_AGENT = "none";
          //  string myCookie = "jeden";
           // ViewData["HTTP_USER_AGENT"] = HTTP_USER_AGENT;
            if(cook!=null)
            ViewData["myCookie"] = cook.Value;

            //eof cookie

            return View();
        }



        //listowanie kategori
        public ActionResult Category()
        {
            List<string> cat =  (from p in _db.Produkt
                                 select p.TypProduktu).Distinct().ToList();


            ViewData["categories"] = cat;
            return View();
        }
        
          
        
        public ActionResult ProductsCat(string id)
        {
            
            List<Produkt> prod = (from p in _db.Produkt
                                  where p.TypProduktu.Equals(id)
                                  select p).ToList();

            if (prod.Count == 0)
                ViewData["Message"] = "Brak porduktów w podanej kategorii.";
            else
                ViewData["Message"] = "Produkty z kategori " + id;

            return View(prod);
        }

        //dla kategori z menu lewego
        /*
        public ActionResult Category(string what)
        {

            List<Produkt> pro = (from p in _db.Produkt
                                 where p.TypProduktu == what
                                 select p).ToList();


            return View(pro);
        }
        */

        // wywołanie np.  GET: /Home/Edit/5
        // edycja produktu


        //[Authorize]
//        [Authorize(Roles = "Administrator")]
        [Authorize(Roles = "Sprzedawca")]
        public ActionResult Edit(int id)
        {
            var productToEdit = (from m in _db.Produkt

                               where m.NrProduktu == id

                               select m).First();

            return View(productToEdit);

        } 


              // POST: /Home/Edit/5 

        [AcceptVerbs(HttpVerbs.Post)]
        [Authorize]
        //[Authorize(Roles = "Administrator")]
        public ActionResult Edit(Produkt productToEdit)
        {

            try
            {

                var orginalProduct = (from m in _db.Produkt
                                      where m.NrProduktu == productToEdit.NrProduktu
                                      select m).First();

                if (!ModelState.IsValid)
                    return View(orginalProduct);

                _db.ApplyPropertyChanges(orginalProduct.EntityKey.EntitySetName, productToEdit);
                _db.SaveChanges();

                return RedirectToAction("Products");

            }

            catch
            {

                return View();

            }
        }



        // GET: /Home/Create 

        public ActionResult Create()
        {

            return View();

        }



        // POST: /Home/Create 

        [AcceptVerbs(HttpVerbs.Post)]

        public ActionResult Create([Bind(Exclude = "NrProduktu")] Produkt productToCreate)
        {

            try
            {

                if (!ModelState.IsValid)

                    return View();

                _db.AddToProdukt(productToCreate);

                _db.SaveChanges();

                return RedirectToAction("Products");

            }

            catch
            {

                return View();

            }

        }




        public ActionResult Delete(int id)
        {

            var productToDel = (from m in _db.Produkt
                              where m.NrProduktu == id
                              select m).First();

            return View(productToDel);

        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Delete(Produkt productToDel)
        {

            try
            {
                var orginalProduct = (from m in _db.Produkt
                                    where m.NrProduktu == 
                                    productToDel.NrProduktu
                                    select m).First();

                _db.DeleteObject(orginalProduct);
                _db.SaveChanges();

            }
            catch
            {
                return RedirectToAction("Index");
            }

            return RedirectToAction("Products");


        }


        public ActionResult Details(int id)
        {
            var productToView = (from m in _db.Produkt
                                where m.NrProduktu == id
                                select m).First();

            return View(productToView);
        }




        //cookie cart
        [Authorize]
        public ActionResult Buy(int id)
        {

            //sprawdzenie stanu magazynowego
            Produkt pr = (from p in _db.Produkt
                       where p.NrProduktu == id
                       select p).First();

            int ile = int.Parse(pr.Ilosc);
            if (ile > 0)
            {



                //cookie part
                string oldvalue = "";
                var cook = HttpContext.Request.Cookies.Get(User.Identity.Name + "myCookieCart");
                if (cook != null)
                {
                    oldvalue = cook.Value;
                }

                string cookieValue = id.ToString();
                var newCookie = new HttpCookie(User.Identity.Name + "myCookieCart", oldvalue + "." + cookieValue);
                newCookie.Expires = DateTime.Now.AddDays(1);
                Response.AppendCookie(newCookie);

                //zmiana ilosci produktu
                try
                {

                    Produkt prtoedit = pr;
                    prtoedit.Ilosc = (--ile).ToString();

                    if (!ModelState.IsValid)
                        return RedirectToAction("Products");

                    _db.ApplyPropertyChanges(pr.EntityKey.EntitySetName, prtoedit);
                    _db.SaveChanges();

                    

                }

                catch
                {

                    return View();

                }

                ViewData["Msg"] = "Produkt " + pr.NazwaProduktu + " został dodany do twojego koszyka.";
                return View();
                //return RedirectToAction("Products");
                // tutaj ew. moze być redirect do koszyka odrazu.
            }


            else
            {
                //nie ma wystarczającej ilości tego produktu
                ViewData["Msg"] = "Produkt " + pr.NazwaProduktu + " jest obecnie niedostępny w magazynie.";
                return View();

            }
        }


        public ActionResult UnBuy(int id)
        {

            string delme = id.ToString();
            string oldvalue = "";
            string newvalue = "";
            bool deleted = false;
            var cook = HttpContext.Request.Cookies.Get(User.Identity.Name + "myCookieCart");
            if (cook != null)
            {
                oldvalue = cook.Value;
            }
            string[] words = oldvalue.Split('.');
            foreach (var s in words)
            {
                if(!deleted && s.Equals(delme))
                    deleted = true;
                else newvalue = newvalue + "." + s;

            }

            var newCookie = new HttpCookie(User.Identity.Name + "myCookieCart", newvalue);
            newCookie.Expires = DateTime.Now.AddDays(1);
            Response.AppendCookie(newCookie);


            //
            Produkt pr = (from p in _db.Produkt
                          where p.NrProduktu == id
                          select p).First();

            int ile = int.Parse(pr.Ilosc);

            try
            {

                Produkt prtoedit = pr;
                prtoedit.Ilosc = (++ile).ToString();

                if (!ModelState.IsValid)
                    return RedirectToAction("Products");

                _db.ApplyPropertyChanges(pr.EntityKey.EntitySetName, prtoedit);
                _db.SaveChanges();



            }

            catch
            {

                return View();

            }

            return RedirectToAction("CheckOut");
        }



        [Authorize]
        public ActionResult CheckOut()
        {
//            User.Identity.Name
            //zabezpieczyć przed nullami
            char cut = '.';
            var cook = HttpContext.Request.Cookies.Get(User.Identity.Name+"myCookieCart");
            string what = cook.Value;
            string[] words = what.Split(cut);

            List<Produkt> cart_products = new List<Produkt>();
            foreach (var word in words)
            {
                //try parse?
                if (word != "")
                {
                    int i = Int32.Parse(word);
                    cart_products.Add((from n in _db.Produkt
                                       where n.NrProduktu == i
                                       select n).First());

                }
            }



            return View(cart_products);
        }


        /* wpisanie zamówienia do bd */
        public ActionResult CheckOut2(IEnumerable<Produkt> ct)
        {
            int x = ct.Count();
            //ct zawsze  puste
            // docelowo z ct pobieranie listy produktów

            //zabezpieczyć przed nullami
            char cut = '.';
            var cook = HttpContext.Request.Cookies.Get(User.Identity.Name+"myCookieCart");
            string what = cook.Value;
            string[] words = what.Split(cut);

            List<Produkt> cart_products = new List<Produkt>();
            foreach (var word in words)
            {
                //try parse?
                if (word != "")
                {
                    int i = Int32.Parse(word);
                    cart_products.Add((from n in _db.Produkt
                                       where n.NrProduktu == i
                                       select n).First());

                }
            }

            if (cart_products.Count > 0)
            {


                RejestrZamowien zam = new RejestrZamowien();



                //dodanie do bazy.

                string klient_name = this.User.Identity.Name;

                //pobranie nr klienta.
                var nr_klienta = (from c in _db.Klinet
                                  where c.Login == klient_name
                                  select c.NrKlienta).First();

                //obliczanie wartości zamówienia
                decimal money = 0;
                foreach (Produkt prod in cart_products)
                {
                    money += (from w in _db.Produkt
                              where w.NrProduktu == prod.NrProduktu
                              select w.CenaJednostkowa).First();
                }


                zam.NrKlienta = nr_klienta;
                zam.RodzajTranzakcji = "fv";
                zam.WartoscZamowienia = money;
                zam.Data = DateTime.Now;

                _db.AddToRejestrZamowien(zam);
                _db.SaveChanges();


                //nr zamówienia - b. niebezpieczne!! last... nie ma nic innego distinctowanego!
                /*
                var nr_zam = (from z in _db.RejestrZamowien
                              orderby z.NrZamowienia descending 
                              where z.NrKlienta == nr_klienta
                              select z.NrZamowienia).First();
                */


                var nr_zam =
                    zam.NrZamowienia;
                //dla każdego produktu dodanie pozycji zamówienia
                Pozycja_Zamowienia pz;

                foreach (Produkt prod in cart_products)
                {
                    pz = new Pozycja_Zamowienia();
                    pz.NrZamowienia = nr_zam;
                    pz.NrProduktu = prod.NrProduktu;
                    _db.AddToPozycja_Zamowienia(pz);


                }

                _db.SaveChanges();

                ViewData["1"] = "Twoje zamówienie zostało przyjęte do realizacji.";
                ViewData["2"] = "Możesz kontrolować stan Twojego zamówienia w zakładce Zamówienia.";


                //kasowanie ciasteczka - nie działało
                /*
                HttpCookie objCookie = new HttpCookie(User.Identity.Name + "myCookieCart");
                Response.Cookies.Clear();
                Response.Cookies.Add(objCookie);
                objCookie.Values.Add(User.Identity.Name + "myCookieCart", ".");
                DateTime dtExpiry = DateTime.Now.AddDays(1);
                Response.Cookies[User.Identity.Name + "myCookieCart"].Expires = dtExpiry;
                */
                var newCookie = new HttpCookie(User.Identity.Name + "myCookieCart", ".");
                newCookie.Expires = DateTime.Now.AddDays(1);
                Response.AppendCookie(newCookie);

                return View();

            }
            else
            {
                ViewData["1"] = "Nie można zrealizować pustego zamówienia.";
                ViewData["2"] = "Najpierw dodaj produkty do koszyka.";
                return View();
            }
        }



        [Authorize]
        public ActionResult Orders()
        {
            string klient_name = this.User.Identity.Name;

            
            var nr_klienta = (from c in _db.Klinet
                              where c.Login == klient_name
                              select c.NrKlienta).First();

            List<RejestrZamowien> zamowienia = (from z in _db.RejestrZamowien
                                                orderby z.NrZamowienia ascending 
                                                where z.NrKlienta == nr_klienta &&
                                                      z.NrPracownika == null
                                                select z).ToList();
            ;


            /*
            List<decimal> zamowienia = (from z in _db.RejestrZamowien
                              where z.NrKlienta == nr_klienta  &&
                              z.NrPracownika == null

                                   select z.NrZamowienia).ToList();
            */
            //dla każdego niezrealizowanego zamówienia .. wygeneruj produkty

            /*
            foreach (decimal list in zamowienia)
            {
                
            }
            */
            /*
            List<decimal> products_ids = (from m in _db.RejestrZamowien
                                          where m.NrKlienta == nr_klienta
                                          select m.NrProduktu).ToList();


            List<Produkt> cart_products = new List<Produkt>();
            foreach (var list in products_ids)
            {
                cart_products.Add((from n in _db.Produkt
                                   where n.NrProduktu == list
                                   select n).First());

            }
            */

            //zrealizowane zamowienia przekazane przez view data
            //ViewData["Zam2"] = zamowienia;

            List<RejestrZamowien> zamowienia2 = (from z in _db.RejestrZamowien
                                                orderby z.NrZamowienia ascending
                                                where z.NrKlienta == nr_klienta &&
                                                      z.NrPracownika != null
                                                select z).ToList();

            ViewData["Zam2"] = zamowienia2;


            return View(zamowienia);
        }

        
        public ActionResult Orderdet(int id)
        {
            
            RejestrZamowien rj = (from data in _db.RejestrZamowien 
                                  where data.NrZamowienia == id
                                  select data
                                 ).First();

            
            ViewData["Zamowienie"] = "Szczegóły zamówienia nr:"+ rj.NrZamowienia + " o wartości:"+
            rj.WartoscZamowienia;

            List<decimal> nrprod = (from pz in _db.Pozycja_Zamowienia
                                    where pz.NrZamowienia == id
                                    select pz.NrProduktu).ToList();
            ;


            /* LINQ to SQL... :/ not entities
            List<Produkt> prod = (from p in _db.Produkt
                                  where nrprod.Contains(p.NrProduktu)
                                  select p).ToList();
            */ 

            
            //List<Produkt> prod 

            var pprod   = _db.Produkt.Where( BuildContainsExpression<Produkt, decimal>(e => e.NrProduktu, nrprod));
            return View(pprod);
        }




        public ActionResult About()
        {
            return View();
        }

        public ActionResult Conditions()
        {
            return View();
        }



        public ActionResult Rules()
        {
            return View();
        }

        
        public ActionResult Status()
        {
            return View();
        }

        
        public ActionResult Shipment()
        {
            return View();
        }

        
        public ActionResult Personally()
        {
            return View();
        }

          
        
        
        public ActionResult Discount()
        {
            return View();
        }

        //genera te it

        public ActionResult help()
        {
            return View();
        }


        public ActionResult contact()
        {
            return View();
        }

        public ActionResult online()
        {
            return View();
        }

        
        public ActionResult promo()
        {
            List<Produkt> prod = (from p in _db.Produkt
                                  select p).Take(4).ToList();


                //return _db.Produkt.ToList()
            return View(prod);
        }



    }
}
