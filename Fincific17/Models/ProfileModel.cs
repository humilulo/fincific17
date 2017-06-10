using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using Fincific17.Data;
using System.ComponentModel.DataAnnotations;

namespace Fincific17.Models
{
	public class ProfileModel
	{
		public int Id				{ get; set; }
		public string AspNetUserId	{ get; set; }
		[Display(Name = "First Name")]
		public string FirstName		{ get; set; }
		[Display(Name = "Nick Name")]
		public string NickName { get; set; }
		[Display(Name = "Last Name")]
		public string LastName		{ get; set; }

	}
}
