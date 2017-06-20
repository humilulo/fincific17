using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Fincific17.Models
{
	public class GlAccountModel
	{
		public int Id { get; set; }
		public string Number { get; set; }
		public string Description { get; set; }
		public AccountTypeModel AccountType { get; set; }
		public BalanceTypeModel BalanceType { get; set; }
		public GlAccountModel ConsolToAccount { get; set; }

		public enum AccountTypeModel
		{
			Asset = 1,
			Liability = 2,
			OwnerEquity = 3,
			Revenue = 4,
			Expense = 5
		}

		public enum BalanceTypeModel
		{
			Debit = -1,
			Memo = 0,
			Credit = 1
		}
	}

}