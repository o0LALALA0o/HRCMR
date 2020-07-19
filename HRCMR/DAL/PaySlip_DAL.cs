using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data.SqlClient;
using System.Data;

namespace DAL
{
    public class PaySlip_DAL
    {

        public static List<MODEL.PaySlip> selectPaySlip(string UserId)
        {
            int LateMoney = 0;
            int AdvanceMoney = 0;
            int Sa_TotalSalary = 5000;
            DataTable dt = DBHelper.GetSelect("select * from AttendanceSheet where (AttendanceType = 1 or AttendanceType = 2 ) and UserId ="+UserId);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (dt.Rows[i]["AttendanceType"].ToString()=="1")
                {
                    LateMoney++;
                    Sa_TotalSalary = Sa_TotalSalary - 500;
                }
                else
                {
                    AdvanceMoney++;
                    Sa_TotalSalary = Sa_TotalSalary - 500;
                }
            }
            MODEL.PaySlip paySlip = new MODEL.PaySlip();
            paySlip.LateMoney = LateMoney.ToString();
            paySlip.AdvanceMoney = AdvanceMoney.ToString();
            paySlip.TotalSalary = Sa_TotalSalary.ToString();

            List<MODEL.PaySlip> list = new List<MODEL.PaySlip>();
            list.Add(paySlip);
            return list;
        }

    }
}
