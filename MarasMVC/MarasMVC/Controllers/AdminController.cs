﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MarasMVC.Models;


namespace MarasMVC.Controllers
{
    [HandleError]
    [Authorize(Roles = "Administrator")]
    public class AdminController : Controller
    {
        private sklepEntities _db = new sklepEntities();


        //*************************************
        //tylko dla admina

        public ActionResult stats()
        {
            return View();
        }

        public ActionResult users()
        {
            return View(_db.Klinet.ToList());
        }

        public ActionResult sales()
        {
            return View(_db.Sprzedawca.ToList());
        }



        

        //*************************************
        //tylko dla admina




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




              public ActionResult Edits(int id)
        {
            var spToEdit = (from m in _db.Sprzedawca

                                 where m.NrPracownika == id

                                 select m).First();

            return View(spToEdit);

        }


        // POST: /Home/Edit/5 

        [AcceptVerbs(HttpVerbs.Post)]
        [Authorize]
        //[Authorize(Roles = "Administrator")]
              public ActionResult Edits(Sprzedawca spToEdit)
        {

            try
            {

                var orgSp = (from m in _db.Sprzedawca
                                      where m.NrPracownika == spToEdit.NrPracownika
                                      select m).First();

                if (!ModelState.IsValid)
                    return View(orgSp);

                _db.ApplyPropertyChanges(orgSp.EntityKey.EntitySetName, spToEdit);
                _db.SaveChanges();

                return RedirectToAction("sales");

            }

            catch
            {

                return View();

            }
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
            var klienci = (from m in _db.Klinet
                                 where m.NrKlienta == id
                                 select m).First();

            return View(klienci);
        }


        public ActionResult Detailss(int id)
        {
            var sp = (from m in _db.Sprzedawca
                                 where m.NrPracownika == id
                                 select m).First();

            return View(sp);
        }

    }
}