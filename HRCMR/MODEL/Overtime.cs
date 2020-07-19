using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MODEL
{
    public class Overtime
    {
        /// <summary>
        /// 加班编号(主键)
        /// </summary>
        public string OvertimeID { get; set; }

        /// <summary>
        /// 加班起始时间
        /// </summary>
        public string OvertimeStateTime { get; set; }

        /// <summary>
        /// 加班结束时间
        /// </summary>
        public string OvertimeEndTime { get; set; }

        /// <summary>
        /// 申请状态
        /// </summary>
        public string OvertimeDuration { get; set; }

        /// <summary>
        /// 用户编号
        /// </summary>
        public string UserID { get; set; }

        /// <summary>
        /// 审批时间
        /// </summary>
        public string ApplyTime { get; set; }

        /// <summary>
        /// 审批进度
        /// </summary>
        public string OvertimeState { get; set; }

        /// <summary>
        /// 审批内容
        /// </summary>
        public string ApproverReason { get; set; }

    }
}
