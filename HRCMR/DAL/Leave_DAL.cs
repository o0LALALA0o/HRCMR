using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data;
using System.Data.SqlClient;

namespace DAL
{
    public class Leave_DAL
    {
        #region 查询
        /// <summary>
        /// 查询请假申请
        /// </summary>
        /// <returns></returns>
        public DataTable selectLeave(int offset,int pageSize,string LeaveStartTime, string LeaveEndTime, MODEL.UserInfo user, out string count)
        {
            string where = "";
            where += " and Leave.UserID = " + user.UserID;
            //if (user.RoleID == "1" || user.RoleID == "3")
            //{
                
            //}
            //else if(user.RoleID == "2")
            //{
            //    where += " and DepartmentID = " + user.DepartmentID;
            //}
            string sql = "select * from ( select ROW_NUMBER() over(order by LeaveID desc) rowindex ,* from (select Leave.*,UserInfo.UserName,UserInfo.UserTel from Leave inner join UserInfo on Leave.UserID = UserInfo.UserID where 1=1 " + where + ") a inner join (select * from CategoryItems where C_Category ='LeaveState') b on a.LeaveState = b.CI_ID) c inner join OvertineCheck on c.LeaveID = OvertineCheck.LeaveID where  rowindex between " + (offset + 1) + " and " + (pageSize + offset) + " order by c.LeaveID desc";

            #region 查询行数

            string sql2 = " select COUNT(LeaveID) from Leave inner join UserInfo on Leave.UserID = UserInfo.UserID where 1=1 " + where;
            count = (DBHelper.GetSelect(sql2)).Rows[0][0].ToString();

            #endregion

            return DBHelper.GetSelect(sql);

        }

        /// <summary>
        /// 查询请假记录
        /// </summary>
        /// <returns></returns>
        public DataTable selectLeaveLoc(int offset, int pageSize, string LeaveStartTime, string LeaveEndTime, MODEL.UserInfo user, out string count)
        {
            string where = "";
            if (!string.IsNullOrEmpty(user.UserName))
            {
                where += " and UserName like '%" + user.UserName + "%' ";
            }
            if (!string.IsNullOrEmpty(user.DepartmentID))
            {
                where += " and UserInfo.DepartmentID = " + user.DepartmentID;
            }
            string sql = "select * from (select ROW_NUMBER() over(order by Leave.LeaveTime desc) rowindex,Leave.*,UserInfo.UserName,UserInfo.UserTel,Department.DepartmentName from Leave inner join UserInfo on Leave.UserID = UserInfo.UserID inner join Department on UserInfo.DepartmentID=Department.DepartmentID where 1 = 1 " + where + " ) a where  rowindex between " + (offset + 1) + " and " + (pageSize + offset) + " order by LeaveID desc";

            #region 查询行数

            string sql2 = " select COUNT(LeaveID) from Leave inner join UserInfo on Leave.UserID = UserInfo.UserID where LeaveState = 1 " + where;
            count = (DBHelper.GetSelect(sql2)).Rows[0][0].ToString();

            #endregion

            return DBHelper.GetSelect(sql);
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
            string where = "";
            if (user.RoleID == "2")
            {
                where += " and DepartmentalAudit = 3 and UserInfo.DepartmentID = " + user.DepartmentID;
            }
            else if (user.RoleID == "4")
            {
                where += " and (DepartmentalAudit = 1 or DepartmentalAudit = 0) and GeneralManagerAudit = 3 and RoleID != " + user.RoleID;
            }
            else if (user.RoleID == "5")
            {
                where += " and ManagerAudit =3 and (GeneralManagerAudit = 1 or GeneralManagerAudit =0) ";
            }
            string sql = "select * from (select ROW_NUMBER() over(order by Leave.LeaveTime desc) rowindex,Leave.*,UserInfo.UserName,UserInfo.UserTel,Department.DepartmentName from Leave inner join UserInfo on Leave.UserID = UserInfo.UserID inner join Department on UserInfo.DepartmentID=Department.DepartmentID inner join OvertineCheck on Leave.LeaveID = OvertineCheck.LeaveID where 1 = 1 " + where + ") a where rowindex between " + (offset + 1) + " and " + (pageSize + offset) + " order by LeaveTime desc";

            #region 查询行数

            string sql2 = " select COUNT(Leave.LeaveID) from Leave inner join UserInfo on Leave.UserID = UserInfo.UserID inner join OvertineCheck on Leave.LeaveID = OvertineCheck.LeaveID  where 1=1 " + where;
            count = (DBHelper.GetSelect(sql2)).Rows[0][0].ToString();

            #endregion

            return DBHelper.GetSelect(sql);

        }

        #endregion

        #region 添加

        /// <summary>
        /// 请假申请
        /// </summary>
        /// <param name="leave"></param>
        /// <returns></returns>
        public string ApplicationLeave(MODEL.Leave leave)
        {
            string sql = "insert into Leave(UserID,LeaveTime,LeaveStartTime,LeaveEndTime,LeaveHalfDay,LeaveDays,LeaveReason,LeaveState) values(@UserID,GETDATE(),@LeaveStartTime,@LeaveEndTime,@LeaveHalfDay,@LeaveDays,@LeaveReason,3);select @@identity;";
            SqlParameter[] sqlpar = {
                new SqlParameter("UserID",leave.UserID),
                new SqlParameter("LeaveStartTime",leave.LeaveStartTime),
                new SqlParameter("LeaveEndTime",leave.LeaveEndTime),
                new SqlParameter("LeaveHalfDay",leave.LeaveHalfDay),
                new SqlParameter("LeaveDays",leave.LeaveDays),
                new SqlParameter("LeaveReason",leave.LeaveReason),
            };

            DataTable dt = DBHelper.GetSelect(sql, sqlpar);

            return dt.Rows[0][0].ToString();
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
            string sql1 = "delete from Leave where 1=1 and LeaveID in (" + where + ")";
            string sql2 = "delete from OvertineCheck where 1=1 and LeaveID in (" + where + ")";

            List<string> list = new List<string>();
            list.Add(sql1);
            list.Add(sql2);

            return DBHelper.ExcuteMoreMethod(list);

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
            DataTable dt = DBHelper.GetSelect("select * from OvertineCheck inner join UserInfo on OvertineCheck.UserID = UserInfo.UserID where LeaveID =" + LeaveID);

            string ManagerAudit = dt.Rows[0]["ManagerAudit"].ToString();    //总经理审批结果
            string GeneralManagerAudit = dt.Rows[0]["GeneralManagerAudit"].ToString();  //人事经理审批结果
            string DepartmentalAudit = dt.Rows[0]["DepartmentalAudit"].ToString();  //部门经理审批结果
            string RoleID= dt.Rows[0]["RoleID"].ToString();
            string DepartmentID = dt.Rows[0]["DepartmentID"].ToString();

            string Audit = "3";

            if (RoleID == "1" && DepartmentID != "10")    //非人事部普通员工
            {
                if ((DepartmentalAudit == "1" && GeneralManagerAudit == "1" && ManagerAudit == "1") || (DepartmentalAudit == "1" && GeneralManagerAudit == "1" && ManagerAudit == "0") || (DepartmentalAudit == "1" && GeneralManagerAudit == "0" && ManagerAudit == "0"))
                {
                    Audit = "1";
                }
                else if (DepartmentalAudit == "2" || GeneralManagerAudit == "2" || ManagerAudit == "2")
                {
                    Audit = "2";
                }
            }
            else if ((RoleID == "1" && DepartmentID == "10") || RoleID == "3" || RoleID == "2")  //人事部普通员工部门经理
            {
                if ((DepartmentalAudit == "0" && GeneralManagerAudit == "1" && ManagerAudit == "1") || (DepartmentalAudit == "0" && GeneralManagerAudit == "1" && ManagerAudit == "0"))
                {
                    Audit = "1";
                }
                else if (DepartmentalAudit == "2" || GeneralManagerAudit == "2" || ManagerAudit == "2")
                {
                    Audit = "2";
                }
            }
            else if (RoleID == "4")    //人事经理
            {
                if (DepartmentalAudit == "0" && GeneralManagerAudit == "0" && ManagerAudit == "1")
                {
                    Audit = "1";
                }
                else if (DepartmentalAudit == "2" || GeneralManagerAudit == "2" || ManagerAudit == "2")
                {
                    Audit = "2";
                }
            }

            if (Audit != "3")
            {
                updateAudit(LeaveID, Audit);
            }
            

        }

        public static void updateAudit(string LeaveID,string Audit)
        {
            string sql = "update Leave set LeaveState = "+Audit + " where LeaveID="+LeaveID;
            DBHelper.GetExu(sql);
        }

        #endregion
    }
}
