using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data;
using DAL;

namespace BLL
{
    public class Leave_BLL
    {
        Leave_DAL Leave_dal = new Leave_DAL();
        OvertineCheck_DAL OvertineCheck_dal = new OvertineCheck_DAL();

        #region 查询
        /// <summary>
        /// 查询
        /// </summary>
        /// <returns></returns>
        public DataTable selectLeave(int offset, int pageSize, string LeaveStartTime, string LeaveEndTime, MODEL.UserInfo user, out string count)
        {
            return Leave_dal.selectLeave(offset, pageSize, LeaveStartTime, LeaveEndTime, user, out count);

        }

        /// <summary>
        /// 查询请假记录
        /// </summary>
        /// <returns></returns>
        public DataTable selectLeaveLoc(int offset, int pageSize, string LeaveStartTime, string LeaveEndTime, MODEL.UserInfo user, out string count)
        {
            return Leave_dal.selectLeaveLoc(offset, pageSize, LeaveStartTime, LeaveEndTime, user, out count);
        }

        /// <summary>
        /// 查询审批列表
        /// </summary>
        /// <param name="offset"></param>
        /// <param name="pageSize"></param>
        /// <param name="LeaveStartTime"></param>
        /// <param name="LeaveEndTime"></param>
        /// <param name="user"></param>
        /// <param name="count"></param>
        /// <returns></returns>
        public DataTable selectAuditLeave(int offset, int pageSize, string LeaveStartTime, string LeaveEndTime, MODEL.UserInfo user, out string count)
        {
            return Leave_dal.selectAuditLeave(offset, pageSize, LeaveStartTime, LeaveEndTime, user, out count);

        }

        #endregion

        #region 添加

        /// <summary>
        /// 请假申请
        /// </summary>
        /// <param name="leave"></param>
        /// <returns></returns>
        public bool ApplicationLeave(MODEL.Leave leave, MODEL.UserInfo user)
        {
            MODEL.OvertineCheck overtineCheck = new MODEL.OvertineCheck();

            overtineCheck.LeaveID = Leave_dal.ApplicationLeave(leave);
            overtineCheck.userID = user.UserID;
            overtineCheck.ApproverType = "2";

            if (user.RoleID == "1" && user.DepartmentID != "10") //普通员工
            {
                if (Convert.ToInt32(leave.LeaveDays) < 3)
                {
                    //只需要部门经理审核
                    overtineCheck.DepartmentalAudit = "3";
                }
                else if (Convert.ToInt32(leave.LeaveDays) >= 3 && Convert.ToInt32(leave.LeaveDays) <= 5)
                {
                    //需要部门经理和人事经理审核
                    overtineCheck.DepartmentalAudit = "3";
                    overtineCheck.GeneralManagerAudit = "3";
                }
                else
                {
                    //需要总经理,部门经理,人事经理审核
                    overtineCheck.DepartmentalAudit = "3";
                    overtineCheck.GeneralManagerAudit = "3";
                    overtineCheck.ManagerAudit = "3";
                }
            }
            else if (user.DepartmentID == "10" && user.RoleID != "4")    //人事部员工
            {
                //需要人事经理审核
                if (Convert.ToInt32(leave.LeaveDays) < 3)
                {
                    overtineCheck.GeneralManagerAudit = "3";
                }
                else
                {
                    overtineCheck.GeneralManagerAudit = "3";
                    overtineCheck.ManagerAudit = "3";
                }
            }
            else if (user.RoleID == "2")  //部门经理
            {
                if (Convert.ToInt32(leave.LeaveDays) < 3)
                {
                    //只需要人事经理审核
                    overtineCheck.GeneralManagerAudit = "3";
                }
                else
                {
                    overtineCheck.GeneralManagerAudit = "3";
                    overtineCheck.ManagerAudit = "3";
                }
            }
            else if (user.RoleID == "4") //人事经理
            {
                overtineCheck.ManagerAudit = "3";
            }

            return OvertineCheck_dal.AddOvertineCheck(overtineCheck);
        }

        #endregion

        #region 删除

        /// <summary>
        /// 删除记录
        /// </summary>
        /// <param name="UserID"></param>
        /// <param name="LeaveID"></param>
        /// <returns></returns>
        public bool delLeave(string where)
        {
            return Leave_dal.delLeave(where);

        }

        #endregion

        #region 修改

        /// <summary>
        /// 修改审核状态
        /// </summary>
        /// <param name="LeaveID"></param>
        /// <returns></returns>
        public void updateAuditLeave(string LeaveID)
        {
            Leave_dal.updateAuditLeave(LeaveID);
        }

        #endregion
    }
}
