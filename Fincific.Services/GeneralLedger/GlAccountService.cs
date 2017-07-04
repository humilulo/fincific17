using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Data=Fincific.Data;
using Domain = Fincific.Core.Domain;


namespace Fincific.Services.GeneralLedger
{
	public class GlAccountService
	{
		/// <summary>
		/// 
		/// </summary>
		/// <param name="domn">domn = DOMaiN</param>
		/// <returns></returns>
		private Data.GlAccount ConvertToDataGlAccount(Domain.GeneralLedger.GlAccount domn)
		{
			if (domn == null) { return null; }
			return new Data.GlAccount()
			{
				Id = domn.Id,
				Number = domn.Number,
				Description = domn.Description,
				AccountTypeId = (int)domn.AccountType,
				BalanceTypeId = (int)domn.BalanceType,
				ConsolidateToAccountId = (domn.ConsolToAccount == null) ? 0 : domn.ConsolToAccount.Id
				// TODO: Is this the same?		= domn.ConsolToAccount?.Id
			};
		}

		private Domain.GeneralLedger.GlAccount ConvertToDomainGlAccount(Data.GlAccount data)
		{
			if (data == null) { return null; }
			return new Domain.GeneralLedger.GlAccount()
			{
				Id = data.Id,
				Number = data.Number,
				Description = data.Description,
				AccountType = (Domain.GeneralLedger.AccountType)data.AccountTypeId,
				BalanceType = (Domain.GeneralLedger.BalanceType)data.BalanceTypeId,
				ConsolToAccount = GetGlAccountById(data.ConsolidateToAccountId ?? 0),
			};
		}

		public List<Domain.GeneralLedger.GlAccount> GetAll()
		{
			using (Data.FinancificDataContext dc = new Data.FinancificDataContext())
			{
				return dc.GlAccounts.Select(ConvertToDomainGlAccount).ToList();
			}
		}

		public Domain.GeneralLedger.GlAccount GetGlAccountById(int id)
		{
			if (id == 0) { return null; }
			using (Data.FinancificDataContext dc = new Data.FinancificDataContext())
			{
				return ConvertToDomainGlAccount(dc.GlAccounts.Where(w => w.Id == id).FirstOrDefault());
			}
		}

		public int Add(Domain.GeneralLedger.GlAccount newEntity)
		{
			Data.GlAccount newData = ConvertToDataGlAccount(newEntity);
			int newDataId = 0;
			using (var dc = new Data.FinancificDataContext())
			{
				dc.GlAccounts.InsertOnSubmit(newData);
				dc.SubmitChanges();
				newDataId = newData.Id;
			}
			return newDataId;
		}

		public void Update(Domain.GeneralLedger.GlAccount entity)
		{
			if (entity.Id == 0) { Add(entity); return; }

			using (var dc = new Data.FinancificDataContext())
			{
				Data.GlAccount u = dc.GlAccounts.Where(w => w.Id == entity.Id).FirstOrDefault();
				u.Number = entity.Number;
				u.Description = entity.Description;
				u.AccountTypeId = (int)entity.AccountType;
				u.BalanceTypeId = (int)entity.BalanceType;
				u.ConsolidateToAccountId =
					(entity.ConsolToAccount != null) ? (int?)entity.ConsolToAccount.Id : null;
				dc.SubmitChanges();
			}
		}

	} // public class GlAccountService

} // namespace Fincific17.Services
