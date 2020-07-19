using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data;

namespace BLL
{
    public class PaySlip_BLL
    {
        public static List<MODEL.PaySlip> selectPaySlip(string UserId)
        {
            return DAL.PaySlip_DAL.selectPaySlip(UserId);
        }
    }
}
