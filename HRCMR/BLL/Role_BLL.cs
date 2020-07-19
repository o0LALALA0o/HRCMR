using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using MODEL;

namespace BLL
{
    public class Role_BLL
    {
        DAL.Role_DAL role = new DAL.Role_DAL();

        #region 查询角色
        /// <summary>
        /// 查询角色
        /// </summary>
        /// <returns></returns>
        public List<Role> selectRole()
        {
            return role.selectRole();
        }

        #endregion
    }
}
