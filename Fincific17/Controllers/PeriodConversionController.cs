using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using Domain = Fincific.Core.Domain;
using Fincific.Services.SystemManager;

using Fincific17.Models;

namespace Fincific17.Controllers
{
    public class PeriodConversionController : Controller
    {
        PeriodConversionService _periodConversionService;

        public PeriodConversionController()
        {
            _periodConversionService = new PeriodConversionService();
        }

        #region Utilities
        public PeriodConversionListModel PreparePeriodConversionListModel(int filterYear)
        {
            PeriodConversionListModel model = new PeriodConversionListModel()
            {
                AvailableYears = _periodConversionService.GetAvailableYears(),
                FilterYear = filterYear,
                PeriodConversionList = _periodConversionService.GetPeriodConversionsByYear(filterYear).Select(PreparePeriodConversionModel).ToList(),
            };
            return model;
        }

        public PeriodConversionModel PreparePeriodConversionModel(Domain.SystemManager.PeriodConversion periodConversion)
        {
            PeriodConversionModel model = new PeriodConversionModel()
            {
                Id=periodConversion.Id,
                FiscalYear = periodConversion.FiscalYear,
                FiscalPeriod = periodConversion.FiscalPeriod,
                FromDate = periodConversion.FromDate,
                ThruDate = periodConversion.ThruDate,
                ApClosed = periodConversion.ApClosed,
                ArClosed = periodConversion.ArClosed,
                GlClosed = periodConversion.GlClosed,
            };
            return model;
        }

        #endregion

        public ActionResult Index()
        {
            return RedirectToAction("ByYear", new { fiscalYear = DateTime.Now.Year });
        }

        // GET: Peried conversion records by year
        public ActionResult ByYear(int fiscalYear)
        {
            PeriodConversionListModel model = PreparePeriodConversionListModel(fiscalYear);
            return View("SystemManager.PeriodConversion.ByYear",model);
        }

        // GET: System/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: System/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: System/Create
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

        // GET: System/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: System/Edit/5
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

        // GET: System/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: System/Delete/5
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
