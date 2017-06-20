using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Fincific17.Domain
{
	public class GlAccount
	{
		public int Id { get; set; }
		public string Number { get; set; }
		public string Description { get; set; }
		public AccountType AccountType { get; set; }
		public BalanceType BalanceType { get; set; }
		public GlAccount ConsolToAccount { get; set; }

	}
}