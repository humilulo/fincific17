using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Fincific17.Services
{
	public class SystemService
	{
		private Data.SmPeriodConversion ConvertToDataPeriodConversion(Domain.PeriodConversion domn)
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

		private Domain.PeriodConversion ConvertToDomainPeriodConversion(Data.SmPeriodConversion data)
		{
			if (data == null) { return null; }
			return new Domain.PeriodConversion()
			{
                Id = data.Id,
                FiscalYear = data.FiscalYear ?? 0,
                FiscalPeriod = data.FiscalPeriod ?? 0,
                FromDate = data.FromDate ?? DateTime.Parse("1900-1-1"),
                ThruDate = data.ThruDate ?? DateTime.Parse("1900-1-1"),
                ApClosed = data.ApClosed ?? true,
                ArClosed = data.ArClosed ?? true,
                GlClosed = data.GlClosed ?? true,
            };
		}

		public List<Domain.PeriodConversion> GetAll()
		{
			using (Data.FinancificDataContext dc = new Data.FinancificDataContext())
			{
				return dc.SmPeriodConversions.Select(ConvertToDomainPeriodConversion).ToList();
			}
		}

		public Domain.PeriodConversion GetPeriodConversionById(int id)
		{
			if (id == 0) { return null; }
			using (Data.FinancificDataContext dc = new Data.FinancificDataContext())
			{
				return ConvertToDomainPeriodConversion(dc.SmPeriodConversions.Where(w => w.Id == id).FirstOrDefault());
			}
		}

		public int Add(Domain.PeriodConversion newEntity)
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

		public void Update(Domain.PeriodConversion entity)
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
