using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using BLL;
using MODEL;
using System.Data;
using Newtonsoft.Json;

namespace HRCMR.Handler
{
    /// <summary>
    /// Department 的摘要说明
    /// </summary>
    public class Department : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            //context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");

            Department_BLL dep = new Department_BLL();
            Role_BLL role = new Role_BLL();
            string state = context.Request["state"];

            if (state == "select")
            {
                string DepartmentName = context.Request["DepartmentName"];
                int offset = Convert.ToInt32(context.Request["offset"]);
                int pageSize = Convert.ToInt32(context.Request["pageSize"]);

                string count;

                List<MODEL.Department> list = new List<MODEL.Department>();
                  list = dep.selectDepartment(DepartmentName, pageSize, offset,out count);
                var rs = new { total = count, rows = list };
                string r = JsonConvert.SerializeObject(rs);
                context.Response.Write(r);
            }
            else if (state == "add")
            {
                string DepartmentName = context.Request["DepartmentName"];
                MODEL.Department department = new MODEL.Department();
                department.DepartmentName = DepartmentName;

                if (dep.selectRepeatDepartment(DepartmentName))
                {
                    context.Response.Write('0');
                    return;
                }

                if (dep.AddDepartment(department))
                {
                    context.Response.Write('1');
                }


            }
            else if (state == "del")
            {
                
                string jsonStr = context.Request["jsonStr"];
                string [] departmentsId = JsonConvert.DeserializeObject<string[]>(jsonStr);
                if (dep.DelDepartment(departmentsId))
                {
                    context.Response.Write("1");
                }
                else
                {
                    context.Response.Write("0");
                }

            }
            else if(state == "delO")
            {
                string departmentsId = context.Request["DepartmentID"];
                if (dep.DelDepartment(departmentsId))
                {
                    context.Response.Write("1");
                }
                else
                {
                    context.Response.Write("0");
                }
            }
            else if (state == "updata")
            {
                string jsonStr = context.Request["jsonStr"];
                MODEL.Department department = JsonConvert.DeserializeObject<MODEL.Department>(jsonStr);

                if (dep.selectRepeatDepartment(department.DepartmentName, department.DepartmentID))
                {
                    context.Response.Write('0');
                    return;
                }

                if (dep.updataDepartment(department))
                {
                    context.Response.Write("1");
                }


            }
            else if (state == "sel")
            {
                var rs = new { Department= dep.selectDepartment(),Role = role.selectRole() };
                string jsonStr = JsonConvert.SerializeObject(rs);
                context.Response.Write(jsonStr);
            }

            
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}