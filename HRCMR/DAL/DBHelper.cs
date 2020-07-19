using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace DAL
{
     class DBHelper
    {
        //连接字符串
        public static string connstr = ConfigurationManager.ConnectionStrings["Test"].ConnectionString;
        /// <summary>
        /// 查询
        /// </summary>
        /// <param name="sql"></param>
        /// <param name="para"></param>
        /// <returns></returns>
        public static DataTable GetSelect(string sql, params SqlParameter[] para)
        {
            try
            {
                SqlDataAdapter dap = new SqlDataAdapter(sql, connstr);
                if (para != null)
                {
                    dap.SelectCommand.Parameters.AddRange(para);

                }
                DataTable dt = new DataTable();
                dap.Fill(dt);
                return dt;

            }
            catch (Exception)
            {

                throw;
            }
        }

        /// <summary>
        /// 增删改
        /// </summary>
        /// <param name="sql"></param>
        /// <param name="para"></param>
        /// <returns></returns>
        public static bool GetExu(string sql, params SqlParameter[] para)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connstr))
                {
                    if (conn.State == ConnectionState.Closed)
                    {
                        conn.Open();
                    }
                    SqlCommand cm = new SqlCommand(sql, conn);
                    if (para != null)
                    {
                        cm.Parameters.AddRange(para);

                    }
                    int i = cm.ExecuteNonQuery();
                    return i > 0;
                }
            }
            catch (Exception)
            {

                throw;
            }
        }

        //执行多个操作异常时事务回滚
        public static bool ExcuteMoreMethod(List<string> listSql)
        {
            SqlConnection connetion = new SqlConnection(connstr);
            connetion.Open();
            using (SqlTransaction tran = connetion.BeginTransaction())
            {
                try
                {
                    foreach (string sql in listSql)
                    {
                        SqlCommand command = new SqlCommand(sql,connetion);
                        command.Transaction = tran;
                        command.ExecuteNonQuery();
                    }
                    tran.Commit();
                    return true;
                }
                catch
                {

                    tran.Rollback();
                    return false;
                }
                finally
                {
                    connetion.Close();
                }        
            }
        }

    }
}
