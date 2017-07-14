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
		public GlAccountTypeModel AccountType { get; set; }
		public BalanceTypeModel BalanceType { get; set; }
		public GlAccountModel ConsolToAccount { get; set; }

        
	}

    public class GlAccountTypeModel
    {
        public int Id { get; set; }
        public string Descr { get; set; }

        public GlAccountClassModel GlAccountClass { get; set; }

        public BalanceTypeModel BalanceType { get; set; }
    }

    public class GlAccountClassModel
    {
        public int Id { get; set; }
        public string Descr { get; set; }
    }

    public enum BalanceTypeModel
    {
        Debit = -1,
        Memo = 0,
        Credit = 1
    }

}