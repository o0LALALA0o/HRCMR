using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using Newtonsoft.Json;

namespace HRCMR.Handler
{
    /// <summary>
    /// CategoryItems 的摘要说明
    /// </summary>
    public class CategoryItems : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            //context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");

            string state = context.Request["state"];
            BLL.CategoryItems_BLL categoryItems_bll = new BLL.CategoryItems_BLL();

            if (state == "select")
            {
                string C_Category = context.Request["C_Category"];
                context.Response.Write(JsonConvert.SerializeObject(categoryItems_bll.selectCategoryItems(C_Category)));
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