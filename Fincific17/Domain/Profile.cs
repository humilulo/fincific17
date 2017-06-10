using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Fincific17.Domain
{
	public class Profile
	{
		public int Id { get; set; }
		public string AspNetUserId { get; set; }
		public string FirstName { get; set; }
		public string NickName { get; set; }
		public string LastName { get; set; }
	}
}