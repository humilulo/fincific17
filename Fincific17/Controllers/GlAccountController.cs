﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using Fincific17.Models;
using Fincific17.Services;

namespace Fincific17.Controllers
{
    public class GlAccountController : Controller
    {
		private GlAccountService _glAccountService;

		public GlAccountController()
		{
			_glAccountService = new GlAccountService();
		}

		#region Utility

		private GlAccountListModel PrepareGlAccountListModel(List<Domain.GlAccount> models)
		{
			if (models == null) { return null; }
			return new GlAccountListModel()
			{
				GlAccountList = models.Select(PrepareGlAccountModel).ToList()
			};
		}

		private GlAccountModel PrepareGlAccountModel(Domain.GlAccount glAccount)
		{
			if (glAccount == null) { return null; }
			return new GlAccountModel()
			{
				Id = glAccount.Id,
				Number = glAccount.Number,
				Description = glAccount.Description,
				AccountType = (GlAccountModel.AccountTypeModel)glAccount.AccountType,
				BalanceType = (GlAccountModel.BalanceTypeModel)glAccount.BalanceType,
				ConsolToAccount = PrepareGlAccountModel(glAccount.ConsolToAccount),
			};
		}
		#endregion

		// GET: GlAccount
		public ActionResult Index()
        {
			GlAccountListModel model = PrepareGlAccountListModel(_glAccountService.GetAll());
            return View(model);
        }

        // GET: GlAccount/Details/5
        public ActionResult Details(int id)
        {
			//Detail page
            return View();
        }

        // GET: GlAccount/Create
        public ActionResult Create()
        {
			var model = new GlAccountModel();
            return View(model);
        }

        // POST: GlAccount/Create
        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            try
            {
				var glAccount = new Domain.GlAccount()
				{
					Id = 0,
					Number = collection["Number"],
					Description = collection["Description"]
				};

				int accountTypeId;
				if (int.TryParse(collection["AccountType"], out accountTypeId))
				{
					glAccount.AccountType = (Domain.AccountType)accountTypeId;
				}

				int balanceTypeId;
				if (int.TryParse(collection["BalanceType"], out balanceTypeId))
				{
					glAccount.BalanceType = (Domain.BalanceType)balanceTypeId;
				}

				_glAccountService.Add(glAccount);

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