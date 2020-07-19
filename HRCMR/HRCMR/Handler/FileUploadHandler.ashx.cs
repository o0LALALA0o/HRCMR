using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Newtonsoft.Json;

namespace HRCMR.Handler
{
    /// <summary>
    /// FileUploadHandler 的摘要说明
    /// </summary>
    public class FileUploadHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            //context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");

            HttpPostedFile file = context.Request.Files[0];
            string re = string.Empty;

            
            Random rnd = new Random();

            string fname = rnd.Next(1, 10000) + file.FileName;
            

            string path = context.Server.MapPath("~/img/FileUpload/") + fname;
            if (file.FileName.EndsWith(".jpg")|| file.FileName.EndsWith(".gif")|| file.FileName.EndsWith(".png"))
            {
                file.SaveAs(path);
                string rs = string.Empty;
                re = JsonConvert.SerializeObject(fname);
                context.Response.Write(re);
            }
            else
            {
                context.Response.Write("0");
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