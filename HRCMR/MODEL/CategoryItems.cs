using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MODEL
{
    public class CategoryItems
    {
        /// <summary>
        /// 编号(主键)
        /// </summary>
        public string CID { get; set; }

        /// <summary>
        /// 表名
        /// </summary>
        public string C_Category { get; set; }

        /// <summary>
        /// ID
        /// </summary>
        public string CI_ID { get; set; }

        /// <summary>
        /// 字典名称
        /// </summary>
        public string CI_Name { get; set; }
    }
}
