using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data;
using System.Data.SqlClient;

namespace DAL
{
    public class CategoryItems_DAL
    {

        #region 查询
        
        /// <summary>
        ///查询字典表 
        /// </summary>
        /// <param name="C_Category"></param>
        /// <returns></returns>
        public List<MODEL.CategoryItems> selectCategoryItems(string C_Category)
        {
            string sql = "select CI_ID,CI_Name from CategoryItems where C_Category = @C_Category";
            SqlParameter[] sqlpar = {
                new SqlParameter("C_Category",C_Category)
            };
            DataTable dt = DBHelper.GetSelect(sql, sqlpar);

            List<MODEL.CategoryItems> list = new List<MODEL.CategoryItems>();

            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count ; i++)
                {
                    MODEL.CategoryItems categoryItems = new MODEL.CategoryItems();
                    categoryItems.CI_ID = dt.Rows[i]["CI_ID"].ToString();
                    categoryItems.CI_Name = dt.Rows[i]["CI_Name"].ToString();
                    list.Add(categoryItems);
                }
            }

            return list;

        }

        #endregion

    }
}
