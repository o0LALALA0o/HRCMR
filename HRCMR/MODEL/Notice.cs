using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MODEL
{
    public class Notice
    {
        /// <summary>
        /// 公告编号(主键)
        /// </summary>
        public string NoticeID { get; set; }

        /// <summary>
        /// 公告类型
        /// </summary>
        public string NoticeType { get; set; }

        /// <summary>
        /// 公告标题
        /// </summary>
        public string NoticeTitle { get; set; }

        /// <summary>
        /// 公告内容
        /// </summary>
        public string NoticeContent { get; set; }

        /// <summary>
        /// 发布人
        /// </summary>
        public string UserID { get; set; }

        /// <summary>
        /// 通知起始时间
        /// </summary>
        public string NoticeStateTime { get; set; }

        /// <summary>
        /// 结束时间
        /// </summary>
        public string NoticeEndTime { get; set; }

        /// <summary>
        /// 通知紧急状态（可参考字典表）
        /// </summary>
        public string NoticeState { get; set; }
        
    }
}
