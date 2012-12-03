using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.Mvc;
using MarasMVC.Models;


namespace MarasMVC.Controllers
{
    [Authorize(Roles = "Sprzedawca")]
    [HandleError]
    public class SalesController : Controller
    {
        private sklepEntities _db = new sklepEntities();

        //****************************
        //tylko dotyczące sprzedawcy


        public ActionResult Products()
        {
            //bool sale = User.Identity.IsAuthenticated;
            bool sale = User.IsInRole("Sprzedawca");
            if (sale)
                ViewData["Msg"] = " - zarządzanie katalogiem";
            else
                ViewData["Msg"] = " - katalog";
            // ta sytuacja nie wystąpi
            return View(_db.Produkt.ToList());

        }



        public ActionResult customers()
        {

            return View(_db.Klinet.ToList());
        }



        public ActionResult orders()
        {
            List<RejestrZamowien> zam = (from z in _db.RejestrZamowien
                                                 orderby z.Data ascending
                                                 where z.NrPracownika == null
                                                 select z).ToList();


            return View(zam);
        }



        public ActionResult Oldorders()
        {
            List<RejestrZamowien> zam = (from z in _db.RejestrZamowien
                                         orderby z.Data ascending
                                         where z.NrPracownika != null
                                         select z).ToList();

            return View(zam);
        }

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




        public ActionResult Orderdet(int id)
        {

            RejestrZamowien rj = (from data in _db.RejestrZamowien
                                  where data.NrZamowienia == id
                                  select data
                                 ).First();


            ViewData["Msg"] = "Szczegóły zamówienia nr:" + rj.NrZamowienia + " o wartości:" +
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

            var pprod = _db.Produkt.Where(BuildContainsExpression<Produkt, decimal>(e => e.NrProduktu, nrprod));
            return View(pprod);
        }



        public ActionResult Realize(int id)
        {
            var zamToEdit = (from z in _db.RejestrZamowien

                                 where z.NrZamowienia == id

                                 select z).First();


            return View(zamToEdit);

           
        }


        
        public ActionResult Realize2(int id)
        {

            var zamToEdit = (from z in _db.RejestrZamowien

                             where z.NrZamowienia == id

                             select z).First();

            var spname = User.Identity.Name;

            var nrPrac = (from s in _db.Sprzedawca
                          where s.Login == spname
                          select s.NrPracownika).First();


            zamToEdit.NrPracownika = nrPrac;


            try
            {

                var orginalZam = (from m in _db.RejestrZamowien
                                      where m.NrZamowienia == zamToEdit.NrZamowienia
                                      select m).First();

                if (!ModelState.IsValid)
                    return View(orginalZam);

                _db.ApplyPropertyChanges(orginalZam.EntityKey.EntitySetName, zamToEdit);
                _db.SaveChanges();


                var klient = (from k in _db.Klinet
                              where k.NrKlienta == zamToEdit.NrKlienta
                              select k).First();
                ViewData["Msg"] = "Zamówienie nr:" + zamToEdit.NrZamowienia + "na kwotę:" + zamToEdit.WartoscZamowienia
                                  + "dla klienta: " + klient.Imie + " " + klient.Nazwisko;
                

            }

            catch
            {
                return RedirectToAction("Products");
                

            }

            return View();
        }
        //****************************
        //tylko dotyczące sprzedawcy

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


        



    

        //listowanie kategori
        public ActionResult Category()
        {
            List<string> cat =  (from p in _db.Produkt
                                 select p.TypProduktu).Distinct().ToList();


            ViewData["categories"] = cat;
            return View();
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


        public ActionResult Detailsu(int id)
        {
            var klient = (from k in _db.Klinet
                                where k.NrKlienta == id
                                select k).First();

            return View(klient);
        }







        //else's

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


        // WHERE sth IN - for LINQ to Entities
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

        //end LINQ for Entities


    }
}
