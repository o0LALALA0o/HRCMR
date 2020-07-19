using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data;

namespace BLL
{
    public class AttendanceSheet_BLL
    {
        DAL.AttendanceSheet_DAL AttendanceSheet_DAL = new DAL.AttendanceSheet_DAL();

        #region 查询

        /// <summary>
        /// 查询考勤记录
        /// </summary>
        /// <returns></returns>
        public DataTable selectRecord(string UserID, string d1, string d2)
        {
            return AttendanceSheet_DAL.selectRecord( UserID,  d1,  d2);
        }

        /// <summary>
        /// 查询今天是否打卡
        /// </summary>
        /// <param name="AttendanceStartTime"></param>
        /// <param name="UserID"></param>
        /// <returns></returns>
        public bool selectIs(string AttendanceStartTime, string UserID)
        {
            return AttendanceSheet_DAL.selectIs(AttendanceStartTime, UserID);
        }

        #endregion

        #region 添加

        /// <summary>
        /// 第一次打卡
        /// </summary>
        /// <param name="UserID"></param>
        /// <returns></returns>
        public bool add1(string UserID, string AttendanceType)
        {
            return AttendanceSheet_DAL.add1(UserID, AttendanceType);
        }

        #endregion

        #region 修改

        /// <summary>
        /// 第二次打卡
        /// </summary>
        /// <param name="UserID"></param>
        /// <returns></returns>
        public bool add2(string UserID, string AttendanceStartTime, string AttendanceType)
        {
            return AttendanceSheet_DAL.add2(UserID, AttendanceStartTime, AttendanceType);
        }

        #endregion

    }
}
