using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Fincific17.Models
{
    public class PeriodConversionListModel
    {
        public List<int> AvailableYears { get; set; }
        public int FilterYear { get; set; }

        public List<PeriodConversionModel>  PeriodConversionList { get; set; }
    }
}