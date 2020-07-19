using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MODEL
{
    public class Role
    {
        /// <summary>
        /// 角色编号(主键)
        /// </summary>
        public string RoleID { get; set; }

        /// <summary>
        /// 角色名称
        /// </summary>
        public string RoleName { get; set; }

        /// <summary>
        /// 角色权限百分比
        /// </summary>
        public string RoleNumber { get; set; }

    }
}
