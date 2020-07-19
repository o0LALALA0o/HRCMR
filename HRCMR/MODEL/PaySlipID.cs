using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MODEL
{
    public class PaySlipID
    {
        /// <summary>
        /// 编号(主键)
        /// </summary>
        public string id { get; set; }

        /// <summary>
        /// 用户编号
        /// </summary>
        public string UserID { get; set; }

        /// <summary>
        /// 基本工资
        /// </summary>
        public string BasicSalary { get; set; }

        /// <summary>
        /// 考勤奖金
        /// </summary>
        public string AttendanceBonus { get; set; }

        /// <summary>
        /// 罚款
        /// </summary>
        public string Fine { get; set; }

        /// <summary>
        /// 发工资时间
        /// </summary>
        public string SalaryTime { get; set; }

        /// <summary>
        /// 最后工资
        /// </summary>
        public string SalarySum { get; set; }
    }
}
