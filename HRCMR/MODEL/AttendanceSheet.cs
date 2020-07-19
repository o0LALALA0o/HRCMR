using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MODEL
{
    public class AttendanceSheet
    {
        /// <summary>
        /// 考勤编号(主键)
        /// </summary>
        public string AttendanceID { get; set; }

        /// <summary>
        /// 考勤时间
        /// </summary>
        public string AttendanceStartTime { get; set; }

        /// <summary>
        /// 考勤状态
        /// </summary>
        public string AttendanceType { get; set; }

        /// <summary>
        /// 用户编号
        /// </summary>
        public string UserID { get; set; }

        /// <summary>
        /// 第一次打卡
        /// </summary>
        public string ClockTime { get; set; }

        /// <summary>
        /// 第二次打卡
        /// </summary>
        public string ClockOutTime { get; set; }

        /// <summary>
        /// 工作小时
        /// </summary>
        public string Workinghours { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        public string remake { get; set; }

        /// <summary>
        /// 迟到次数
        /// </summary>
        public string Late { get; set; }

        /// <summary>
        /// 考勤次数
        /// </summary>
        public string Absenteeism { get; set; }

    }
}
