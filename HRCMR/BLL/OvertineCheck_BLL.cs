using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data;

namespace BLL
{
    public class OvertineCheck_BLL
    {
        DAL.OvertineCheck_DAL OvertineCheck_dal = new DAL.OvertineCheck_DAL();

        #region 修改

        /// <summary>
        /// 审批
        /// </summary>
        /// <returns></returns>
        public bool AuditOvertineCheck(MODEL.OvertineCheck overtineCheck)
        {
            return OvertineCheck_dal.AuditOvertineCheck(overtineCheck);
        }

        #endregion

    }
}
