using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MODEL
{
    public class OvertineCheck
    {
        /// <summary>
        /// 审批ID
        /// </summary>
        public string ApproverID { get; set; }

        /// <summary>
        /// 申请类别
        /// </summary>
        public string ApproverType { get; set; }

        /// <summary>
        /// 请假表ID
        /// </summary>
        public string LeaveID { get; set; }
        
        /// <summary>
        /// 用户ID
        /// </summary>
        public string userID { get; set; }

        /// <summary>
        /// 总经理审核状态
        /// </summary>
        public string ManagerAudit { get; set; }

        /// <summary>
        /// 总经理意见
        /// </summary>
        public string ManagerAuditRemarks { get; set; }

        /// <summary>
        /// 人事经理审核状态
        /// </summary>
        public string GeneralManagerAudit { get; set; }

        /// <summary>
        /// 人事经理意见
        /// </summary>
        public string GeneralManagerAuditRemarks { get; set; }

        /// <summary>
        /// 部门经理审核状态
        /// </summary>
        public string DepartmentalAudit { get; set; }

        /// <summary>
        /// 部门经理意见
        /// </summary>
        public string DepartmentalAuditRemarks { get; set; }

    }
}
