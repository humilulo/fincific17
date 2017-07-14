using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Fincific17
{
    public static partial class Extensions
    {

        public static IHtmlString ToHtmlString(this string value)
        {
            return new HtmlString(value);
        }

        public static System.Web.Mvc.SelectList ToSelectList<TEnum>(this TEnum enumObj)
            where TEnum : struct, IComparable, IFormattable, IConvertible
        {
            var values = from TEnum e in Enum.GetValues(typeof(TEnum))
                         select new { Id = e, Name = e.ToString() };
            return new System.Web.Mvc.SelectList(values, "Id", "Name", enumObj);
        }


    }
}