using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data;
using MODEL;

namespace BLL
{
    public class UserInfo_BLL
    {
        DAL.UserInfo_DAL userinfo_DAL = new DAL.UserInfo_DAL();

        #region 登录
        /// <summary>
        /// 登录
        /// </summary>
        /// <param name="userInfo"></param>
        /// <returns></returns>
        public DataTable Login(UserInfo userInfo)
        {
            return userinfo_DAL.Login(userInfo);
        }
        #endregion

        #region 查询员工信息
        /// <summary>
        /// 查询员工信息
        /// </summary>
        /// <returns></returns>
        public DataTable selectUserInfo(string UserName, string DepartmentID, int offset, int pageSize, out string count)
        {
            return userinfo_DAL.selectUserInfo(UserName, DepartmentID, offset, pageSize, out count);
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
            return userinfo_DAL.AddUserInfo(userInfo);
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
            return userinfo_DAL.UpdataUserInfo(userInfo);
        }

        /// <summary>
        /// 修改个人信息
        /// </summary>
        /// <param name="userInfo"></param>
        /// <returns></returns>
        public bool UpdataMyUserInfo(UserInfo userInfo)
        {
            return userinfo_DAL.UpdataMyUserInfo(userInfo);
        }


        /// <summary>
        /// 修改密码
        /// </summary>
        /// <param name="UserID"></param>
        /// <param name="cLoginPwd"></param>
        /// <returns></returns>
        public bool updataPwd(string UserID, string newLoginPwd)
        {
            return userinfo_DAL.updataPwd(UserID, newLoginPwd);
        }

        #endregion

        #region 删除员工
        /// <summary>
        /// 删除员工
        /// </summary>
        /// <returns></returns>
        public bool DelUserInfo(string UserID)
        {
            return userinfo_DAL.DelUserInfo(UserID);
        }

        /// <summary>
        /// 批量删除
        /// </summary>
        /// <param name="UserID"></param>
        /// <returns></returns>
        public bool batchDelUserInfo(string UserID)
        {
            return userinfo_DAL.batchDelUserInfo(UserID);
        }

        #endregion
    }
}
