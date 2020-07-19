using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MODEL
{
    public class UserInfo
    {
        /// <summary>
        ///序号(主键) 
        /// </summary>
        public string UserID { get; set; }

        /// <summary>
        ///部门编号
        /// </summary>
        public string DepartmentID { get; set; }

        /// <summary>
        ///角色编号（1.总经理 2.人事经理 3.人事助理 4.部门经理 5.员工）
        /// </summary>
        public string RoleID { get; set; }

        /// <summary>
        ///用户编号 
        /// </summary>
        public string UserNumber { get; set; }

        /// <summary>
        ///登陆名
        /// </summary>
        public string LoginName { get; set; }

        /// <summary>
        ///密码
        /// </summary>
        public string LoginPwd { get; set; }

        /// <summary>
        ///真实姓名
        /// </summary>
        public string UserName { get; set; }

        /// <summary>
        ///年龄
        /// </summary>
        public string UserAge { get; set; }

        /// <summary>
        ///性别 （1.男  0.女）
        /// </summary>
        public string UserSex { get; set; }

        /// <summary>
        ///电话
        /// </summary>
        public string UserTel { get; set; }

        /// <summary>
        ///家庭地址
        /// </summary>
        public string UserAddress { get; set; }

        /// <summary>
        ///手机
        /// </summary>
        public string UserIphone { get; set; }

        /// <summary>
        ///备注
        /// </summary>
        public string UserRemarks { get; set; }

        /// <summary>
        ///是否可用（0.不可登陆 1.可登陆）
        /// </summary>
        public string UserStatr { get; set; }

        /// <summary>
        ///最后登陆时间
        /// </summary>
        public string EntryTime { get; set; }

        /// <summary>
        ///入职时间
        /// </summary>
        public string DimissionTime { get; set; }

        /// <summary>
        ///薪资
        /// </summary>
        public string BasePay { get; set; }

    }
}
