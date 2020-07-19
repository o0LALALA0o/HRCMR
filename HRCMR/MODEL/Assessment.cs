using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MODEL
{
    public class Assessment
    {
        /// <summary>
        /// 业绩评定编号(主键)
        /// </summary>
        public string AssessmentID { get; set; }

        /// <summary>
        /// 考评日期
        /// </summary>
        public string PerformanceTime { get; set; }

        /// <summary>
        /// 评定人
        /// </summary>
        public string UserID { get; set; }

        /// <summary>
        /// 总结
        /// </summary>
        public string WorkSummary { get; set; }

        /// <summary>
        /// 完成度
        /// </summary>
        public string UpperGoal { get; set; }

        /// <summary>
        /// 互评分数
        /// </summary>
        public string CompletionDegree { get; set; }

        /// <summary>
        /// 下阶段目标
        /// </summary>
        public string ExaminationItems { get; set; }

        /// <summary>
        /// 上阶段目标
        /// </summary>
        public string NextStageObjectives { get; set; }

        /// <summary>
        /// 最终总分
        /// </summary>
        public string PerformanceScore { get; set; }

        /// <summary>
        /// 主管评论
        /// </summary>
        public string comments { get; set; }

        /// <summary>
        /// 审核状态
        /// </summary>
        public string perstate { get; set; }
    }
}
