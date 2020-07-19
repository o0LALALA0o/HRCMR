using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Newtonsoft.Json;
using System.Web.SessionState;

namespace HRCMR.Handler
{
    /// <summary>
    /// OvertineCheck 的摘要说明
    /// </summary>
    public class OvertineCheck : IHttpHandler, IRequiresSessionState //实现 IRequiresSessionState 接口.
    {

        public void ProcessRequest(HttpContext context)
        {
            string state = context.Request["state"];
            BLL.OvertineCheck_BLL overtineCheck_BLL = new BLL.OvertineCheck_BLL();
            BLL.Leave_BLL leave_BLL = new BLL.Leave_BLL();

            MODEL.UserInfo user = HttpContext.Current.Session["user"] as MODEL.UserInfo;

            //context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");

            if (state == "audit")
            {
                string Audit = context.Request["Audit"];
                string AuditRemarks = context.Request["AuditRemarks"];
                MODEL.OvertineCheck overtineCheck = new MODEL.OvertineCheck();
                overtineCheck.LeaveID = context.Request["LeaveID"];

                if (user.RoleID == "2")//部门经理
                {
                    overtineCheck.DepartmentalAudit = Audit;
                    overtineCheck.DepartmentalAuditRemarks = AuditRemarks;
                }
                else if (user.RoleID == "4")//人事经理
                {
                    overtineCheck.GeneralManagerAudit = Audit;
                    overtineCheck.GeneralManagerAuditRemarks = AuditRemarks;
                }
                else if (user.RoleID == "5")//总经理
                {
                    overtineCheck.ManagerAudit = Audit;
                    overtineCheck.ManagerAuditRemarks = AuditRemarks;
                }

                if (overtineCheck_BLL.AuditOvertineCheck(overtineCheck))
                {
                    leave_BLL.updateAuditLeave(overtineCheck.LeaveID);
                    context.Response.Write("1");
                }
                
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