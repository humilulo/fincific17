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
        public AccountType AccountType { get; set; }
        public BalanceType BalanceType { get; set; }
        public GlAccountModel ConsolidateToAccount { get; set; }
    }

    public enum AccountType
    {
        Asset = 1,
        Liability = 2,
        OwnerEquity = 3
    }

    public enum BalanceType
    {
        Credit = 1,
        Debit = -1,
        Memo = 0
    }
}