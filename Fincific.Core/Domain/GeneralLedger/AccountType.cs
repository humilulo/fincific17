namespace Fincific.Core.Domain.GeneralLedger
{
    public class GlAccountType : BaseEntity
    {
        public string Descr { get; set; }
        public GlAccountClass GlAccountClass {get;set;}
        public BalanceType BalanceType { get; set; }
	}
}