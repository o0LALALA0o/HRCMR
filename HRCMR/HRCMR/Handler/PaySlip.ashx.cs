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
    /// PaySlip 的摘要说明
    /// </summary>
    public class PaySlip : IHttpHandler, IRequiresSessionState //实现 IRequiresSessionState 接口.
    {

        public void ProcessRequest(HttpContext context)
        {
            //context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");

            string state = context.Request["state"];
            BLL.AttendanceSheet_BLL attendanceSheet_BLL = new BLL.AttendanceSheet_BLL();
            MODEL.UserInfo user = HttpContext.Current.Session["user"] as MODEL.UserInfo;

            if (state == "select")
            {
                string j = JsonConvert.SerializeObject(BLL.PaySlip_BLL.selectPaySlip(user.UserID));
                context.Response.Write(j);
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