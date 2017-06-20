using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Fincific17.Models
{
	public class GlAccountListModel
	{
		public string SearchGlAccount { get; set; }

		public List<GlAccountModel> GlAccountList { get; set; }
	}
}