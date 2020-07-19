using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MODEL
{
    public class SystemLog
    {
        /// <summary>
        /// 登陆编号(主键)
        /// </summary>
        public string LogID { get; set; }

        /// <summary>
        /// 用户编号
        /// </summary>
        public string userID { get; set; }

        /// <summary>
        /// 登陆时间
        /// </summary>
        public string LogTime { get; set; }

        /// <summary>
        /// 操作内容
        /// </summary>
        public string LogOperation { get; set; }
    }
}
