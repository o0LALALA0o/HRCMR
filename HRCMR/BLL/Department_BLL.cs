using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using MODEL;
using DAL;
using System.Data;

namespace BLL
{
    public class Department_BLL
    {
        Department_DAL dep = new Department_DAL();

        #region 查询部门
        /// <summary>
        /// 查询部门
        /// </summary>
        /// <returns></returns>
        public List<Department> selectDepartment(string DepartmentName, int pageSize, int offset, out string count)
        {
            return dep.selectDepartment(DepartmentName, pageSize, offset,out count);
        }

        /// <summary>
        /// 查询是否有重复数据
        /// </summary>
        /// <param name="DepartmentName"></param>
        /// <returns></returns>
        public bool selectRepeatDepartment(string DepartmentName)
        {
            return dep.selectRepeatDepartment(DepartmentName);
        }
        public bool selectRepeatDepartment(string DepartmentName,string DepartmentID)
        {
            return dep.selectRepeatDepartment(DepartmentName, DepartmentID);
        }

        /// <summary>
        /// 下拉框数据
        /// </summary>
        /// <returns></returns>
        public List<Department> selectDepartment()
        {
            return dep.selectDepartment();
        }

        #endregion

        #region 添加部门
        /// <summary>
        /// 添加部门
        /// </summary>
        /// <param name="department"></param>
        /// <returns></returns>
        public bool AddDepartment(Department department)
        {
            return dep.AddDepartment(department);
        }

        #endregion

        #region 删除部门
        /// <summary>
        /// 删除部门
        /// </summary>
        /// <param name="departmentsId"></param>
        /// <returns></returns>
        public bool DelDepartment(string[] departmentsId)
        {
            return dep.DelDepartment(departmentsId);
        }

        /// <summary>
        /// 删除部门
        /// </summary>
        /// <param name="departmentsId"></param>
        /// <returns></returns>
        public bool DelDepartment(string departmentsId)
        {
            return dep.DelDepartment(departmentsId);
        }


        #endregion

        #region 修改部门
        /// <summary>
        /// 修改部门
        /// </summary>
        /// <param name="department"></param>
        /// <returns></returns>
        public bool updataDepartment(Department department)
        {
            return dep.updataDepartment(department);
        }

        #endregion

    }
}
