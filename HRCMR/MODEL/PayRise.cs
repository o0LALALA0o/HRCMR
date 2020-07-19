using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MODEL
{
    public class PayRise
    {
        /// <summary>
        /// 工资增长编号(主键)
        /// </summary>
        public string PayRiseID { get; set; }

        /// <summary>
        /// 用户编号
        /// </summary>
        public string UserID { get; set; }

        /// <summary>
        /// 工资收入
        /// </summary>
        public string PayRiseMoney { get; set; }

        /// <summary>
        /// 原因
        /// </summary>
        public string Reason { get; set; }

        /// <summary>
        /// 申请时间
        /// </summary>
        public string ApplicationTime { get; set; }

        /// <summary>
        /// 批准内容
        /// </summary>
        public string ApprovalContent { get; set; }

        /// <summary>
        /// 批准状态
        /// </summary>
        public string ApprovalState { get; set; }

        /// <summary>
        /// 批准时间
        /// </summary>
        public string ApprovalTime { get; set; }
        
    }
}
