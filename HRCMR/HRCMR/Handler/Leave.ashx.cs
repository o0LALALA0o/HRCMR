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
    /// Leave 的摘要说明
    /// </summary>
    public class Leave : IHttpHandler, IRequiresSessionState //实现 IRequiresSessionState 接口.
    {

        public void ProcessRequest(HttpContext context)
        {
            //context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");

            BLL.Leave_BLL Leave_bll = new BLL.Leave_BLL();

            string state = context.Request["state"];

            MODEL.UserInfo user = HttpContext.Current.Session["user"] as MODEL.UserInfo;

            if (state == "select")
            {
                int offset = Convert.ToInt32(context.Request["offset"]);
                int pageSize = Convert.ToInt32(context.Request["pageSize"]);
                string count;

                DataTable dt = Leave_bll.selectLeave(offset, pageSize, "", "", user, out count);
                var j = new { total = count, rows = dt };
                context.Response.Write(JsonConvert.SerializeObject(j));
            }
            else if (state == "selectLoc")
            {
                int offset = Convert.ToInt32(context.Request["offset"]);
                int pageSize = Convert.ToInt32(context.Request["pageSize"]);
                MODEL.UserInfo u = new MODEL.UserInfo();

                string count;

                DataTable dt = Leave_bll.selectLeaveLoc(offset, pageSize, "", "", u, out count);
                var j = new { total = count, rows = dt };
                context.Response.Write(JsonConvert.SerializeObject(j));
            }
            else if (state == "Application")
            {
                string a = context.Request["Leave"];
                MODEL.Leave leave = JsonConvert.DeserializeObject<MODEL.Leave>(context.Request["Leave"]);
                leave.UserID = user.UserID;
                if (Leave_bll.ApplicationLeave(leave, user))
                {
                    context.Response.Write("1");
                }

            }
            else if (state == "delete")
            {
                string where = context.Request["leaveid"];
                if (Leave_bll.delLeave(where))
                {
                    context.Response.Write("1");
                }
            }
            else if (state == "selectAudit")
            {
                int offset = Convert.ToInt32(context.Request["offset"]);
                int pageSize = Convert.ToInt32(context.Request["pageSize"]);
                string count;

                DataTable dt = Leave_bll.selectAuditLeave(offset, pageSize, "", "", user, out count);
                var j = new { total = count, rows = dt };
                context.Response.Write(JsonConvert.SerializeObject(j));
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