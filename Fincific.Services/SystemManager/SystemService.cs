using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Data = Fincific.Data;
using Domain = Fincific.Core.Domain;

namespace Fincific.Services.SystemManager
{
	public class SystemService
	{
		private Data.SmPeriodConversion ConvertToDataPeriodConversion(Domain.SystemManager.PeriodConversion domn)
		{
			if (domn == null) { return null; }
			return new Data.SmPeriodConversion()
			{
				Id = domn.Id,
				FiscalYear = domn.FiscalYear,
				FiscalPeriod = domn.FiscalPeriod,
                FromDate = domn.FromDate,
                ThruDate = domn.ThruDate,
                ApClosed = domn.ApClosed,
                ArClosed = domn.ArClosed,
                GlClosed = domn.GlClosed,
			};
		}

		private Domain.SystemManager.PeriodConversion ConvertToDomainPeriodConversion(Data.SmPeriodConversion data)
		{
			if (data == null) { return null; }
			return new Domain.SystemManager.PeriodConversion()
			{
                Id = data.Id,
                FiscalYear = data.FiscalYear ?? 0,
                FiscalPeriod = data.FiscalPeriod ?? 0,
                FromDate = data.FromDate ?? (new DateTime(1900, 1, 1)),
                ThruDate = data.ThruDate ?? (new DateTime(1900, 1, 1)),
                ApClosed = data.ApClosed ?? true,
                ArClosed = data.ArClosed ?? true,
                GlClosed = data.GlClosed ?? true,
            };
		}

		public List<Domain.SystemManager.PeriodConversion> GetAll()
		{
			using (Data.FinancificDataContext dc = new Data.FinancificDataContext())
			{
				return dc.SmPeriodConversions.Select(ConvertToDomainPeriodConversion).ToList();
			}
		}

        public List<int> GetAvailableYears()
        {
            using (Data.FinancificDataContext dc = new Data.FinancificDataContext())
            {
                return dc.SmPeriodConversions.Select(s=>s.FiscalYear ?? 0).Distinct().ToList();
            }
        }

        public IEnumerable<Domain.SystemManager.PeriodConversion> GetPeriodConversionByYear(int fiscalYear)
        {
            using (Data.FinancificDataContext dc = new Data.FinancificDataContext())
            {
                return dc.SmPeriodConversions.Where(w => w.FiscalYear == fiscalYear).Select(ConvertToDomainPeriodConversion);
          }
        }


        public Domain.SystemManager.PeriodConversion GetPeriodConversionById(int id)
		{
			if (id == 0) { return null; }
			using (Data.FinancificDataContext dc = new Data.FinancificDataContext())
			{
				return ConvertToDomainPeriodConversion(dc.SmPeriodConversions.Where(w => w.Id == id).FirstOrDefault());
			}
		}

		public int Add(Domain.SystemManager.PeriodConversion newEntity)
		{
			Data.SmPeriodConversion newData = ConvertToDataPeriodConversion(newEntity);
			int newDataId = 0;
			using (var dc = new Data.FinancificDataContext())
			{
				dc.SmPeriodConversions.InsertOnSubmit(newData);
				dc.SubmitChanges();
				newDataId = newData.Id;
			}
			return newDataId;
		}

		public void Update(Domain.SystemManager.PeriodConversion entity)
		{
			if (entity.Id == 0) { Add(entity); return; }

			using (var dc = new Data.FinancificDataContext())
			{
				Data.SmPeriodConversion u = dc.SmPeriodConversions.Where(w => w.Id == entity.Id).FirstOrDefault();
				u.FiscalYear = entity.FiscalYear;
				u.FiscalPeriod = entity.FiscalPeriod;
                u.FromDate = entity.FromDate;
                u.ThruDate = entity.ThruDate;
                u.ApClosed = entity.ApClosed;
                u.ArClosed = entity.ArClosed;
                u.GlClosed = entity.GlClosed;
                dc.SubmitChanges();
			}
		}

	} // public class GlAccountService

} // namespace Fincific17.Services
