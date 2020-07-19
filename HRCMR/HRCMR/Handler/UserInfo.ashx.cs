using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Web.Security;
using System.Data;
//在平常的页面上很容易就的到request,response对像，从而对其进行一些操作，但在ashx(一般处理程序)中却是有一点的不同，如果要在ashx中使用session，需要引用   using System.Web.SessionState;  并且实现 IRequiresSessionState 接口.
using System.Web.SessionState;
using Newtonsoft.Json;

namespace HRCMR.Handler
{
    /// <summary>
    /// UserInfo 的摘要说明
    /// </summary>
    public class UserInfo : IHttpHandler, IRequiresSessionState //实现 IRequiresSessionState 接口.
    {
       
            

        public void ProcessRequest(HttpContext context)
        {
            BLL.UserInfo_BLL userinfo_Bll = new BLL.UserInfo_BLL();

            //context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
            string state = context.Request["state"];

            if (state == "login")
            {
                MODEL.UserInfo userinfo = new MODEL.UserInfo();
                userinfo.LoginName = context.Request.Form["LoginName"];
                userinfo.LoginPwd = context.Request.Form["LoginPwd"];

                DataTable dt = userinfo_Bll.Login(userinfo);

                if (dt.Rows.Count > 0)
                {
                    MODEL.UserInfo user = new MODEL.UserInfo();
                    user.UserID = dt.Rows[0]["UserID"].ToString();
                    user.DepartmentID = dt.Rows[0]["DepartmentID"].ToString();
                    user.RoleID = dt.Rows[0]["RoleID"].ToString();
                    user.UserNumber = dt.Rows[0]["UserNumber"].ToString();
                    user.LoginName = dt.Rows[0]["LoginName"].ToString();
                    user.LoginPwd = dt.Rows[0]["LoginPwd"].ToString();
                    user.UserName = dt.Rows[0]["UserName"].ToString();
                    user.UserAge = dt.Rows[0]["UserAge"].ToString();
                    user.UserSex = dt.Rows[0]["UserSex"].ToString();
                    user.UserTel = dt.Rows[0]["UserTel"].ToString();
                    user.UserAddress = dt.Rows[0]["UserAddress"].ToString();
                    user.UserIphone = dt.Rows[0]["UserIphone"].ToString();
                    user.UserRemarks = dt.Rows[0]["UserRemarks"].ToString();
                    user.UserStatr = dt.Rows[0]["UserStatr"].ToString();
                    user.EntryTime = dt.Rows[0]["EntryTime"].ToString();
                    user.DimissionTime = dt.Rows[0]["DimissionTime"].ToString();
                    user.BasePay = dt.Rows[0]["BasePay"].ToString();

                    HttpContext.Current.Session["user"] = user;
                    ////创建身份票据
                    //FormsAuthentication.SetAuthCookie(dt.Rows[0]["LoginName"].ToString(),false);
                    context.Response.Write("1");
                }
                else
                {
                    context.Response.Write("0");
                }
            }
            else if (state == "select")
            {

                string UserName = context.Request["UserNameTxt"];
                string DepartmentID = context.Request["DepartmentID"];
                int offset = Convert.ToInt32(context.Request["offset"]);
                int pageSize = Convert.ToInt32(context.Request["pageSize"]);

                string count;

                DataTable dt = userinfo_Bll.selectUserInfo(UserName, DepartmentID, offset, pageSize, out count);
                var rs = new { total = count, rows = dt };
                string r = JsonConvert.SerializeObject(rs);
                context.Response.Write(r);
            }
            else if (state == "AddUpdate")
            {
                string jsonStr = context.Request["user"];
                MODEL.UserInfo userInfo = JsonConvert.DeserializeObject<MODEL.UserInfo>(jsonStr);
                if (userInfo.UserID != "0")
                {
                    if (userinfo_Bll.UpdataUserInfo(userInfo))
                    {
                        context.Response.Write("2");
                    }
                }
                else
                {
                    if (userinfo_Bll.AddUserInfo(userInfo))
                    {
                        context.Response.Write("1");
                    }

                }
            }
            else if (state == "del")
            {
                if (userinfo_Bll.DelUserInfo(context.Request["userid"]))
                {
                    context.Response.Write("1");
                }
            }
            else if (state == "batchdel")
            {
                if (userinfo_Bll.batchDelUserInfo(context.Request["userid"]))
                {
                    context.Response.Write("1");
                }
            }
            else if (state == "updataPwd")
            {
                //string a = context.Request["lLoginPwd"];
                //var rs = new { valid = false};
                //context.Response.Write(JsonConvert.SerializeObject(rs));
                string lLoginPwd = context.Request["lLoginPwd"];
                string newLoginPwd = context.Request["newLoginPwd"];
                string cLoginPwd = context.Request["cLoginPwd"];

                MODEL.UserInfo user = HttpContext.Current.Session["user"] as MODEL.UserInfo;

                if (lLoginPwd != user.LoginPwd)
                {
                    context.Response.Write("0");
                }
                else
                {
                    if (userinfo_Bll.updataPwd(user.UserID, newLoginPwd))
                    {
                        context.Response.Write("1");
                    }
                }

            }
            else if (state == "selMy")
            {
                MODEL.UserInfo user = HttpContext.Current.Session["user"] as MODEL.UserInfo;
                context.Response.Write(JsonConvert.SerializeObject(user));
            }
            else if (state == "updataMy")
            {
                MODEL.UserInfo user = JsonConvert.DeserializeObject<MODEL.UserInfo>(context.Request["User"]);
                if (userinfo_Bll.UpdataMyUserInfo(user))
                {
                    HttpContext.Current.Session["user"] = user;
                    context.Response.Write("1");
                }
            }
            else if (state == "selectColleague")
            {
                string UserName = context.Request["UserNameTxt"];
                string DepartmentID = (HttpContext.Current.Session["user"] as MODEL.UserInfo).DepartmentID;
                int offset = Convert.ToInt32(context.Request["offset"]);
                int pageSize = Convert.ToInt32(context.Request["pageSize"]);

                string count;

                DataTable dt = userinfo_Bll.selectUserInfo(UserName, DepartmentID, offset, pageSize, out count);
                var rs = new { total = count, rows = dt };
                string r = JsonConvert.SerializeObject(rs);
                context.Response.Write(r);
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