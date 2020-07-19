using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data;
using System.Data.SqlClient;

namespace DAL
{
    public class OvertineCheck_DAL
    {

        #region 添加

        public bool AddOvertineCheck(MODEL.OvertineCheck overtineCheck)
        {
            string sql = string.Format("insert into OvertineCheck(ApproverType,userID,ManagerAudit,ManagerAuditRemarks,GeneralManagerAudit,GeneralManagerAuditRemarks,DepartmentalAudit,DepartmentalAuditRemarks,LeaveID) values('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}')", overtineCheck.ApproverType, overtineCheck.userID, overtineCheck.ManagerAudit, overtineCheck.ManagerAuditRemarks, overtineCheck.GeneralManagerAudit, overtineCheck.GeneralManagerAuditRemarks, overtineCheck.DepartmentalAudit, overtineCheck.DepartmentalAuditRemarks, overtineCheck.LeaveID);

            return DBHelper.GetExu(sql);

        }

        #endregion

        #region 修改

        /// <summary>
        /// 审批
        /// </summary>
        /// <returns></returns>
        public bool AuditOvertineCheck(MODEL.OvertineCheck overtineCheck)
        {
            string sql = "update OvertineCheck set ";

            if (overtineCheck.DepartmentalAudit != null)
            {
                sql += "DepartmentalAudit = '"+overtineCheck.DepartmentalAudit+ "',DepartmentalAuditRemarks ='"+overtineCheck.DepartmentalAuditRemarks+"' ";
            }
            else if (overtineCheck.GeneralManagerAudit != null)
            {
                sql += "GeneralManagerAudit = '" + overtineCheck.GeneralManagerAudit + "',GeneralManagerAuditRemarks ='" + overtineCheck.GeneralManagerAuditRemarks + "' ";
            } else if (overtineCheck.ManagerAudit != null)
            {
                sql += "ManagerAudit = '" + overtineCheck.ManagerAudit + "',ManagerAuditRemarks ='" + overtineCheck.ManagerAuditRemarks + "' ";
            }

            if (overtineCheck.LeaveID != null)
            {
                sql += "where LeaveID = " + overtineCheck.LeaveID;
            }

            return DBHelper.GetExu(sql);
        }

        #endregion

    }
}
