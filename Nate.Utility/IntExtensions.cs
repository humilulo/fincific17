using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Nate.Utility
{
    public static class IntExtensions
    {
        public static string FormatToString(this int[] array, string spacer)
        {
            string encloseChar;
            if (spacer.Length > 2 && spacer.Left(1) == spacer.Right(1))
                encloseChar = spacer.Left(1);
            else
                encloseChar = "";

            StringBuilder sb = new StringBuilder();
            sb.Append(encloseChar);
            for (int i = 0; i < array.Count() - 1; i++)
            {
                sb.Append(array[i].ToString());
                sb.Append(spacer);
            }
            if (array.Count() > 0)
            {
                sb.Append(array[array.Count() - 1]);
            }
            sb.Append(encloseChar);
            return sb.ToString();
        }

        #region ToRange()

        public static string ToRangeString(this IEnumerable<int> numList, string separator = ", ")
        {
            return string.Join(separator, ToRangeArray(numList));
        }

        public static string[] ToRangeArray(this IEnumerable<int> numList)
        {
            return numListToPossiblyDegenerateRanges(numList).Select(s => PrettyRange(s)).ToArray();
        }


        /// <summary>
        /// e.g. 1,3,5,6,7,8,9,10,12
        /// becomes
        /// (1,1),(3,3),(5,10),(12,12)
        /// </summary>
        private static IEnumerable<Tuple<int, int>> numListToPossiblyDegenerateRanges(IEnumerable<int> numList)
        {
            Tuple<int, int> currentRange = null;
            foreach (var num in numList)
            {
                if (currentRange == null)
                {
                    currentRange = Tuple.Create(num, num);
                }
                else if (currentRange.Item2 == num - 1)
                {
                    currentRange = Tuple.Create(currentRange.Item1, num);
                }
                else
                {
                    yield return currentRange;
                    currentRange = Tuple.Create(num, num);
                }
            }
            if (currentRange != null)
            {
                yield return currentRange;
            }
        }

        /// <summary>
        /// e.g. (1,1) becomes "1"
        /// (1,3) becomes "1-3"
        /// </summary>
        /// <param name="range"></param>
        /// <returns></returns>
        private static string PrettyRange(Tuple<int, int> range)
        {
            if (range.Item1 == range.Item2)
            {
                return range.Item1.ToString();
            }
            return string.Format("{0}-{1}", range.Item1, range.Item2);
        }

        #endregion
    }
}
