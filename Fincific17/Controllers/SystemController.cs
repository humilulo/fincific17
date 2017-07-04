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
    public class SystemController : Controller
    {
        SystemService _systemService;

        public SystemController()
        {
            _systemService = new SystemService();
        }

        #region Utilities
        public PeriodConversionListModel PreparePeriodConversionListModel(int filterYear)
        {
            PeriodConversionListModel model = new PeriodConversionListModel()
            {
                AvailableYears = _systemService.GetAvailableYears(),
                FilterYear = filterYear,
                PeriodConversionList = _systemService.GetPeriodConversionByYear(filterYear).Select(PreparePeriodConversionModel).ToList(),
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

        // GET: System
        public ActionResult PeriodConversionByYear(int fiscalYear)
        {
            PeriodConversionListModel model = PreparePeriodConversionListModel(fiscalYear);
            return View(model);
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
