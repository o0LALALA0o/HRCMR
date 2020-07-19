using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MODEL
{
    public class Leave
    {
        /// <summary>
        /// 请假编号(主键)
        /// </summary>
        public string LeaveID { get; set; }

        /// <summary>
        /// 用户编号
        /// </summary>
        public string UserID { get; set; }

        /// <summary>
        /// 审批状态
        /// </summary>
        public string LeaveState { get; set; }

        /// <summary>
        /// 请假时间
        /// </summary>
        public string LeaveTime { get; set; }

        /// <summary>
        /// 请假起始时间
        /// </summary>
        public string LeaveStartTime { get; set; }

        /// <summary>
        /// 结束时间
        /// </summary>
        public string LeaveEndTime { get; set; }

        /// <summary>
        /// 时间段（上午或下午）
        /// </summary>
        public string LeaveHalfDay { get; set; }

        /// <summary>
        /// 请假天数
        /// </summary>
        public string LeaveDays { get; set; }

        /// <summary>
        /// 请假原因
        /// </summary>
        public string LeaveReason { get; set; }

        /// <summary>
        /// 审批编号
        /// </summary>
        public string ApproverID { get; set; }

        /// <summary>
        /// 审批时间
        /// </summary>
        public string ApprovalTime { get; set; }

        /// <summary>
        /// 审批备注
        /// </summary>
        public string ApproverReason { get; set; }
        
    }
}
