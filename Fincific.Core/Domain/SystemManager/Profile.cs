using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Fincific.Core.Domain.SystemManager
{
	public partial class Profile : BaseEntity
	{
		public string AspNetUserId { get; set; }
		public string FirstName { get; set; }
		public string NickName { get; set; }
		public string LastName { get; set; }
	}
}