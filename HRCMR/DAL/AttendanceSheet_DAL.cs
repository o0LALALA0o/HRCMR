using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data;
using System.Data.SqlClient;

namespace DAL
{
    public class AttendanceSheet_DAL
    {
        #region 查询

        /// <summary>
        /// 查询考勤记录
        /// </summary>
        /// <returns></returns>
        public DataTable selectRecord(string UserID,string d1,string d2)
        {
            string sql = "select * from AttendanceSheet where AttendanceStartTime between '"+d1+"' and '"+d2+"' and UserID =" + UserID;
            return DBHelper.GetSelect(sql);
        }

        /// <summary>
        /// 查询今天是否打卡
        /// </summary>
        /// <param name="AttendanceStartTime"></param>
        /// <param name="UserID"></param>
        /// <returns></returns>
        public bool selectIs(string AttendanceStartTime, string UserID)
        {
            string sql = "select * from AttendanceSheet where AttendanceStartTime between '"+ AttendanceStartTime + "' and '"+ AttendanceStartTime + " 23:59:59' and UserID = '" + UserID + "'";
            DataTable dt = DBHelper.GetSelect(sql);

            if (dt.Rows.Count > 0)
            {
                return false;
            }
            else
            {
                return true;
            }
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
            string sql = "insert into AttendanceSheet(AttendanceStartTime,UserID,ClockTime,ClockOutTime,AttendanceType) values(GETDATE()," + UserID + ",GETDATE(),''," + AttendanceType + ")";
            return DBHelper.GetExu(sql);
        }

        #endregion

        #region 修改

        /// <summary>
        /// 第二次打卡
        /// </summary>
        /// <param name="UserID"></param>
        /// <returns></returns>
        public bool add2(string UserID,string AttendanceStartTime, string AttendanceType)
        {
            string sql = "update AttendanceSheet set ClockOutTime =GETDATE(),AttendanceType="+ AttendanceType + " where AttendanceStartTime between '" + AttendanceStartTime + "' and '" + AttendanceStartTime + " 23:59:59' and UserID=" + UserID;
            return DBHelper.GetExu(sql);
        }

        #endregion

    }
}
