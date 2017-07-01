using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Fincific17.Models
{
    public class PeriodConversionModel
    {
        public int Id { get; set; }
        public int FiscalYear { get; set; }
        public int FiscalPeriod { get; set; }
        public DateTime FromDate { get; set; }
        public DateTime ThruDate { get; set; }
        public bool GlClosed { get; set; }
        public bool ApClosed { get; set; }
        public bool ArClosed { get; set; }
    }
}