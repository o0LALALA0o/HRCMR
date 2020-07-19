using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MODEL
{
    public class PaySlip
    {
        /// <summary>
        /// 工资编号(主键)
        /// </summary>
        public string PaySlipID { get; set; }

        /// <summary>
        /// 员工编号
        /// </summary>
        public string UserID { get; set; }

        /// <summary>
        /// 全勤奖金
        /// </summary>
        public string Prize { get; set; }

        /// <summary>
        /// 请假扣钱
        /// </summary>
        public string LeaveMoney { get; set; }

        /// <summary>
        /// 加班奖金
        /// </summary>
        public string OvertimeMoney { get; set; }

        /// <summary>
        /// 迟到
        /// </summary>
        public string LateMoney { get; set; }

        /// <summary>
        /// 早退
        /// </summary>
        public string AdvanceMoney { get; set; }

        /// <summary>
        /// 缺勤
        /// </summary>
        public string Absence { get; set; }

        /// <summary>
        /// 业绩奖金
        /// </summary>
        public string Sa_Bonus { get; set; }

        /// <summary>
        /// 工资结算时间
        /// </summary>
        public string Sa_Time { get; set; }

        /// <summary>
        /// 合计工资
        /// </summary>
        public string TotalSalary { get; set; }
    }
}
