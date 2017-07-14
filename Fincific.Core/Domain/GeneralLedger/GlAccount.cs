using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Fincific.Core.Domain.GeneralLedger
{
	public partial class GlAccount : BaseEntity
	{
		public string Number { get; set; }
		public string Description { get; set; }
		public GlAccountType AccountType { get; set; }
		public BalanceType BalanceType { get; set; }
		public GlAccount ConsolToAccount { get; set; }

	}
}