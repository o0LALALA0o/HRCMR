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
    /// AttendanceSheet 的摘要说明
    /// </summary>
    public class AttendanceSheet : IHttpHandler, IRequiresSessionState //实现 IRequiresSessionState 接口.
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
                string UserID = user.UserID;
                string d1= context.Request["d1"];
                string d2 = context.Request["d2"];
                DataTable dt = attendanceSheet_BLL.selectRecord(UserID, d1, d2);
                string j = JsonConvert.SerializeObject(dt);
                context.Response.Write(j);

            }
            else if (state == "selectIs")
            {
                string AttendanceStartTime = context.Request["AttendanceStartTime"];
                string UserID = user.UserID;

                if (attendanceSheet_BLL.selectIs(AttendanceStartTime, UserID))
                {
                    context.Response.Write('0');
                }
                else
                {
                    context.Response.Write('1');
                }
            }
            else if (state == "add1")
            {
                string UserID = user.UserID;
                string AttendanceType = context.Request["AttendanceType"];
                if (attendanceSheet_BLL.add1(UserID,AttendanceType))
                {
                    context.Response.Write('0');
                }
            }
            else if (state == "add2")
            {
                string UserID = user.UserID;
                string AttendanceStartTime = context.Request["AttendanceStartTime"];
                string AttendanceType = context.Request["AttendanceType"];
                if (attendanceSheet_BLL.add2(UserID, AttendanceStartTime, AttendanceType))
                {
                    context.Response.Write('0');
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