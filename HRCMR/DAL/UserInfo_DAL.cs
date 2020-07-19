using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data;
using System.Data.SqlClient;
using MODEL;

namespace DAL
{
    public class UserInfo_DAL
    {

        #region 登录
        /// <summary>
        /// 登录
        /// </summary>
        /// <param name="userInfo"></param>
        /// <returns></returns>
        public DataTable Login(UserInfo userInfo)
        {
            String sql = "select * from UserInfo where LoginName=@LoginName and LoginPwd=@LoginPwd";
            SqlParameter[] sqlPar = {
                new SqlParameter("LoginName",userInfo.LoginName),
                new SqlParameter("LoginPwd",userInfo.LoginPwd)
            };
            
            return DBHelper.GetSelect(sql, sqlPar);
        }
        #endregion

        #region 查询员工信息
        /// <summary>
        /// 查询员工信息
        /// </summary>
        /// <returns></returns>
        public DataTable selectUserInfo(string UserName, string DepartmentID, int offset, int pageSize, out string count)
        {
            string where = string.Empty;

            if (!string.IsNullOrEmpty(UserName))
            {
                where += " and UserName like '%" + UserName + "%' ";
            }
            if (DepartmentID != "0")
            {
                where += "and UserInfo.DepartmentID = " + DepartmentID;
            }

            string sql = "select * from (select ROW_NUMBER() over(order by UserID) rowindex,UserInfo.* , Department.DepartmentName from UserInfo inner join Department on UserInfo.DepartmentID=Department.DepartmentID  where 1 = 1 " + where + ") c where rowindex between " + (offset + 1) + " and " + (pageSize + offset);
            DataTable dt = DBHelper.GetSelect(sql);

            #region 查询条数
            string sqlCount = "select count(UserID) from UserInfo where 1=1 " + where;
            count = DBHelper.GetSelect(sqlCount).Rows[0][0].ToString();
            #endregion

       

            return dt;
        }
        #endregion

        #region 添加员工
        /// <summary>
        /// 添加员工
        /// </summary>
        /// <param name="userInfo"></param>
        /// <returns></returns>
        public bool AddUserInfo(UserInfo userInfo)
        {
            string sql = "insert into UserInfo(UserName,DepartmentID,RoleID,UserAge,UserSex,UserTel,UserAddress,DimissionTime,UserIphone) values(@UserName,@DepartmentID,@RoleID,@UserAge,@UserSex,@UserTel,@UserAddress,GETDATE(),@UserIphone)";
            SqlParameter[] sqlpar = {
                new SqlParameter("UserName",userInfo.UserName),
                new SqlParameter("DepartmentID",userInfo.DepartmentID),
                new SqlParameter("RoleID",userInfo.RoleID),
                new SqlParameter("UserAge",userInfo.UserAge),
                new SqlParameter("UserSex",userInfo.UserSex),
                new SqlParameter("UserTel",userInfo.UserTel),
                new SqlParameter("UserAddress",userInfo.UserAddress),
                new SqlParameter("UserIphone",userInfo.UserIphone),
            };

            return DBHelper.GetExu(sql,sqlpar);
        }

        #endregion

        #region 修改员工
        /// <summary>
        /// 添加员工
        /// </summary>
        /// <param name="userInfo"></param>
        /// <returns></returns>
        public bool UpdataUserInfo(UserInfo userInfo)
        {
            string sql = "update UserInfo set UserName=@UserName,UserIphone=@UserIphone,DepartmentID=@DepartmentID,RoleID=@RoleID,UserAge=@UserAge,UserSex=@UserSex,UserTel=@UserTel,UserAddress=@UserAddress where UserID = @UserID";
            SqlParameter[] sqlpar = {
                new SqlParameter("UserID",userInfo.UserID),
                new SqlParameter("UserName",userInfo.UserName),
                new SqlParameter("DepartmentID",userInfo.DepartmentID),
                new SqlParameter("RoleID",userInfo.RoleID),
                new SqlParameter("UserAge",userInfo.UserAge),
                new SqlParameter("UserSex",userInfo.UserSex),
                new SqlParameter("UserTel",userInfo.UserTel),
                new SqlParameter("UserAddress",userInfo.UserAddress),
                new SqlParameter("UserIphone",userInfo.UserIphone),
            };

            return DBHelper.GetExu(sql, sqlpar);
        }

        /// <summary>
        /// 修改个人信息
        /// </summary>
        /// <param name="userInfo"></param>
        /// <returns></returns>
        public bool UpdataMyUserInfo(UserInfo userInfo)
        {
            string sql = "update UserInfo set UserName=@UserName,UserAge=@UserAge,UserSex=@UserSex,UserTel=@UserTel,UserAddress=@UserAddress,UserRemarks=@UserRemarks where UserID = @UserID";
            SqlParameter[] sqlpar = {

                new SqlParameter("UserID", userInfo.UserID),
                new SqlParameter("UserName", userInfo.UserName),
                new SqlParameter("UserAge",userInfo.UserAge),
                new SqlParameter("UserSex",userInfo.UserSex),
                new SqlParameter("UserTel",userInfo.UserTel),
                new SqlParameter("UserAddress",userInfo.UserAddress),
                new SqlParameter("UserRemarks", userInfo.UserRemarks),
            };

            return DBHelper.GetExu(sql, sqlpar);
        }

        /// <summary>
        /// 修改密码
        /// </summary>
        /// <param name="UserID"></param>
        /// <param name="cLoginPwd"></param>
        /// <returns></returns>
        public bool updataPwd(string UserID, string newLoginPwd)
        {
            string sql = "update UserInfo set LoginPwd=@newLoginPwd where UserID = @UserID";
            SqlParameter[] sqlpar = {
                new SqlParameter("UserID",UserID),
                new SqlParameter("newLoginPwd",newLoginPwd),
            };

            return DBHelper.GetExu(sql, sqlpar);
        }

        #endregion

        #region 删除员工
        /// <summary>
        /// 删除员工
        /// </summary>
        /// <returns></returns>
        public bool DelUserInfo(string UserID)
        {
            string sql = "delete from UserInfo where UserID=@UserID";
            SqlParameter[] sqlpar = {
                new SqlParameter("UserID",UserID)
            };

            return DBHelper.GetExu(sql, sqlpar);
        }

        /// <summary>
        /// 批量删除
        /// </summary>
        /// <param name="UserID"></param>
        /// <returns></returns>
        public bool batchDelUserInfo(string UserID)
        {
            string sql = "delete from UserInfo where UserID in ("+UserID+")";

            return DBHelper.GetExu(sql);
        }

        #endregion

    }
}
