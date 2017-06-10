using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Fincific17.Models;

using Fincific17.Data;
using Microsoft.AspNet.Identity;
using Fincific17.Services;

namespace Fincific17.Controllers
{
	public class ProfileController : Controller
	{
		private ApplicationDbContext db = new ApplicationDbContext();
		private ProfileService _profileService;

		public ProfileController()
		{
			_profileService = new ProfileService();
		}

		#region Utility

		private ProfileModel PrepareProfileModel(Domain.Profile p)
		{
			return new ProfileModel()
			{
				Id = p.Id,
				AspNetUserId = p.AspNetUserId,
				FirstName = p.FirstName,
				NickName = p.NickName,
				LastName = p.LastName,
			};
		}

		#endregion

		// GET: Profile
		public ActionResult Index() { return RedirectToAction("Edit"); }

		// GET: Profile/Edit
		public ActionResult Edit()
		{
			string aspNetUserId = User.Identity.GetUserId(); // resembles "33615f44-eb44-459e-9999-b52e7b1bcefc"
			ProfileModel model = PrepareProfileModel(_profileService.GetProfileByAspNetUserId(aspNetUserId));
			if (model == null) { return HttpNotFound(); }
			return View(model);
		}

		// POST: Profile/Edit
		// To protect from overposting attacks, please enable the specific properties you want to bind to, for 
		// more details see http://go.microsoft.com/fwlink/?LinkId=317598.
		[HttpPost]
		[ValidateAntiForgeryToken]
		public ActionResult Edit([Bind(Include = "FirstName,NickName,LastName")] ProfileModel model)
		{
			if (ModelState.IsValid)
			{
				string aspNetUserId = aspNetUserId = User.Identity.GetUserId();
				Domain.Profile p = _profileService.GetProfileByAspNetUserId(aspNetUserId);
				p.FirstName = model.FirstName;
				p.NickName  = model.NickName;
				p.LastName  = model.LastName;
				_profileService.UpdateProfile(p);

				return RedirectToAction("Index", "Manage");
			}
			return View(model);
		}

		protected override void Dispose(bool disposing)
		{
			if (disposing)
			{
				db.Dispose();
			}
			base.Dispose(disposing);
		}
	}
}
