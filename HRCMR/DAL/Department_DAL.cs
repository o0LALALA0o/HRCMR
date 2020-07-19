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
    public class Department_DAL
    {
        #region 查询部门
        /// <summary>
        /// 查询部门
        /// </summary>
        /// <returns></returns>
        public List<Department> selectDepartment(string DepartmentName, int pageSize, int offset, out string count)
        {
            string where = "";
            if (!string.IsNullOrEmpty(DepartmentName))
            {
                where = " and DepartmentName like '%" + DepartmentName + "%' ";
            }
            string sql = "select * from (select ROW_NUMBER() over(order by DepartmentId) rowindex,* from Department where 1 = 1 and isDel != '0' " + where + " ) c where rowindex between " + (offset + 1) + " and " + (pageSize + offset) + " ";

            DataTable dt = DBHelper.GetSelect(sql);
            List<Department> list = new List<Department>();
            if (dt.Rows.Count != 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    Department department = new Department();
                    department.DepartmentID = dt.Rows[i]["DepartmentID"].ToString();
                    department.DepartmentName = dt.Rows[i]["DepartmentName"].ToString();
                    department.DepartmentRemarks = dt.Rows[i]["DepartmentRemarks"].ToString();

                    list.Add(department);
                }
            }


            #region 查询条数
            string sqlCount = "select COUNT(DepartmentID) from Department where  1 = 1 and isDel != '0' ";
            if (!string.IsNullOrEmpty(DepartmentName))
            {
                sqlCount = sqlCount + " and DepartmentName like '%" + DepartmentName + "%'";
            }
            DataTable dtcount = DBHelper.GetSelect(sqlCount);

            count = dtcount.Rows[0][0].ToString();

            #endregion

            //Department department = new Department();
            //department.DepartmentID = dt.Rows[0]["DepartmentID"].ToString();
            //department.DepartmentName = dt.Rows[0]["DepartmentName"].ToString();
            //department.DepartmentRemarks = dt.Rows[0]["DepartmentRemarks"].ToString();

            return list;
        }

        /// <summary>
        /// 查询是否有重复数据
        /// </summary>
        /// <param name="DepartmentName"></param>
        /// <returns></returns>
        public bool selectRepeatDepartment(string DepartmentName)
        {
            string sql = "select * from Department where DepartmentName =@DepartmentName ";
            SqlParameter[] sqlpar = {
                new SqlParameter("DepartmentName",DepartmentName)                
            };
            
            DataTable dt = DBHelper.GetSelect(sql, sqlpar);
            if (dt.Rows.Count > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        public bool selectRepeatDepartment(string DepartmentName,string DepartmentID)
        {
            string sql = "select * from Department where DepartmentName =@DepartmentName and DepartmentID!=@DepartmentID";
            SqlParameter[] sqlpar = {
                new SqlParameter("DepartmentName",DepartmentName),
                new SqlParameter("DepartmentID",DepartmentID)
            };

            DataTable dt = DBHelper.GetSelect(sql, sqlpar);
            if (dt.Rows.Count > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        /// <summary>
        /// 下拉框数据
        /// </summary>
        /// <returns></returns>
        public List<Department> selectDepartment()
        {
            string sql = "select distinct DepartmentID,DepartmentName from Department ";
            DataTable dt = DBHelper.GetSelect(sql);

            List<Department> list = new List<Department>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                Department department = new Department();
                department.DepartmentID = dt.Rows[i]["DepartmentID"].ToString();
                department.DepartmentName = dt.Rows[i]["DepartmentName"].ToString();
                list.Add(department);
            }

            return list;
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
            string sql = "insert into Department(DepartmentName,isDel) values(@DepartmentName ,'1')";
            SqlParameter[] sqlpar = {
                new SqlParameter("DepartmentName",department.DepartmentName)
            };
            return DBHelper.GetExu(sql,sqlpar);
        }

        #endregion

        #region 删除部门
        /// <summary>
        /// 批量删除部门
        /// </summary>
        /// <param name="departmentsId"></param>
        /// <returns></returns>
        public bool DelDepartment(string [] departmentsId)
        {
            string where = "";
            for (int i = 0; i < departmentsId.Length; i++)
            {
                if (i== departmentsId.Length-1)
                {
                    where += departmentsId[i];
                }
                else
                {
                    where += departmentsId[i] + ",";

                }
            }
            string sql = "update Department set isDel = '0' where DepartmentID in ("+ where + ")";
            string sql2 = "update UserInfo set DepartmentID = '70' where DepartmentID in (" + where + ")";

            List<string> list = new List<string>();
            list.Add(sql);
            list.Add(sql2);

            return DBHelper.ExcuteMoreMethod(list);
        }

        /// <summary>
        /// 删除部门
        /// </summary>
        /// <param name="departmentsId"></param>
        /// <returns></returns>
        public bool DelDepartment(string departmentsId)
        {
            
            string sql = "update Department set isDel = '0' where DepartmentID =  '"+ departmentsId + "'";

            string sql2 = "update UserInfo set DepartmentID = '70' where DepartmentID = '"+ departmentsId + "'";
            List<string> list = new List<string>();
            list.Add(sql);
            list.Add(sql2);

            return DBHelper.ExcuteMoreMethod(list);
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
            string sql = "update Department set DepartmentRemarks = @DepartmentRemarks,DepartmentName=@DepartmentName where DepartmentID = @DepartmentID";

            SqlParameter[] sqlPar = {
                new SqlParameter("DepartmentID",department.DepartmentID),
                new SqlParameter("DepartmentName",department.DepartmentName),
                new SqlParameter("DepartmentRemarks",department.DepartmentRemarks)
            };

            return DBHelper.GetExu(sql, sqlPar);
        }

        #endregion

    }
}
