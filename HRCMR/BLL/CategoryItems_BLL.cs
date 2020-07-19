using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data;

namespace BLL
{
    public class CategoryItems_BLL
    {
        DAL.CategoryItems_DAL CategoryItems_dal = new DAL.CategoryItems_DAL();

        #region 查询

        /// <summary>
        ///查询字典表 
        /// </summary>
        /// <param name="C_Category"></param>
        /// <returns></returns>
        public List<MODEL.CategoryItems> selectCategoryItems(string C_Category)
        {
            return CategoryItems_dal.selectCategoryItems(C_Category);

        }

        #endregion

    }
}
