using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Fincific17
{
    public class GlAccountController : Controller
    {
        // GET: GlAccount
        public ActionResult Index()
        {
            return View();
        }

        // GET: GlAccount/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: GlAccount/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: GlAccount/Create
        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            try
            {
                // TODO: Add insert logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: GlAccount/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: GlAccount/Edit/5
        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: GlAccount/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: GlAccount/Delete/5
        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
