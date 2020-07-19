using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRCMR
{
    public partial class Main : System.Web.UI.Page
    {
        public MODEL.UserInfo user = new MODEL.UserInfo();

        protected void Page_Load(object sender, EventArgs e)
        {            
            if (Session["user"] != null)
            {
                user = Session["user"] as MODEL.UserInfo;
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
           
        }
    }
}