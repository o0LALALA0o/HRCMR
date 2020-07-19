using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MODEL
{
    public class Department
    {
        /// <summary>
        /// 部门编号(主键)
        /// </summary>
        public string DepartmentID { get; set; }

        /// <summary>
        /// 部门名称
        /// </summary>
        public string DepartmentName { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        public string DepartmentRemarks { get; set; }

        /// <summary>
        /// 是否启用
        /// </summary>
        public string isDel { get; set; }
    }
}
