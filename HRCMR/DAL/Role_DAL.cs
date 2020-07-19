using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data.SqlClient;
using System.Data;
using MODEL;

namespace DAL
{
    public class Role_DAL
    {
        #region 查询角色
        /// <summary>
        /// 查询角色
        /// </summary>
        /// <returns></returns>
        public List<Role> selectRole()
        {
            string sql = "select * from Role";
            DataTable dt = DBHelper.GetSelect(sql);

            List<Role> list = new List<Role>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                Role role = new Role();
                role.RoleID = dt.Rows[i]["RoleID"].ToString();
                role.RoleName = dt.Rows[i]["RoleName"].ToString();

                list.Add(role);
            }

            return list;
        }

        #endregion

    }
}
