<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="selectPaySlip.aspx.cs" Inherits="HRCMR.selectPaySlip" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>

    <script src="Scripts/jquery-3.3.1.min.js"></script>
    <%--<script src="Scripts/bootstrap.js"></script>--%>
    <script src="Scripts/bootstrap.min.js"></script>
    <link href="css/bootstrap.css" rel="stylesheet" />

    <script src="js/bootstrap-table.min.js"></script>
    <script src="js/bootstrap-table-zh-CN.js"></script>
    <link href="css/bootstrap-table.css" rel="stylesheet" />

    <script src="Scripts/toastr.min.js"></script>
    <link href="Scripts/toastr.css" rel="stylesheet" />
    
    <script src="js/fileinput.min.js"></script>
    <script src="js/fileinput_locale_zh.js"></script>
    <link href="css/fileinput.css" rel="stylesheet" />

    <script src="js/bootstrapValidator.min.js"></script>
    <link href="css/bootstrapValidator.min.css" rel="stylesheet" />
    <script src="js/zh_CN.js"></script>

    <script src="js/bootstrap-datepicker.min.js"></script>
    <link href="css/bootstrap-datepicker3.min.css" rel="stylesheet" />
    <script src="js/bootstrap-datepicker.zh-CN.js"></script>

    <script src="Scripts/tableExport.min.js"></script>
    <script src="Scripts/bootstrap-table-export.min.js"></script>


     <link href="css/circle.css" rel="stylesheet" />
    <link href="css/index.css" rel="stylesheet" />

    <script type="text/javascript">

        $(function () {
            $("#select").click(function () {
                $("#Modal").modal('show');


                //初始化bootstrapTable
            $("#tbData").bootstrapTable({
                url: 'Handler/PaySlip.ashx?state=select',              //请求后台的URL（*）					
                striped: true,                      //是否显示行间隔色					
                cache: true,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）					
                pagination: false,                   //是否显示分页（*）					
                sortable: false,                     //是否启用排序					
                sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）					
                toolbar: '',
                pageNumber: 1,                       //初始化加载第一页，默认第一页					
                pageSize: 5,                       //每页的记录行数（*）					
                pageList: [5, 10, 15, 20, 25],        //可供选择的每页的行数（*）					
                strictSearch: true,
                clickToSelect: false,                //是否启用点击选中行					
                 showToggle: false,                   //是否显示详细视图和列表视图的切换按钮
                showRefresh: false,                  //是否显示刷新按钮                
                showColumns: false,
                cardView: false,                    //是否显示详细视图
                uniqueId: "",
                
                queryParams: function (parms) {				//参数列表
                    var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的				
                        //页面大小				
                        limit: parms.limit, //页面大小				
                        //////需要跳过的数量				
                        offset: parms.offset,
                        pageSize: parms.limit,
                    };
                    return temp;
                },
	                columns: [					
	                      				
                        {
                            field: 'LateMoney', title: '迟到', width: 100, align: 'center'
                        },					
                        {
                            field: 'AdvanceMoney', title: '早退', width: 100, align: 'center'
                        },					
                        {
                            field: 'TotalSalary', title: '结算工资', width: 100, align: 'center'
                        },	
                            //{field:"",title:'操作',formatter:addBtn,events:ope,width:100,align:'center'},
	                        	
	                ]					
	            })

            });
        })

    </script>

</head>
<body>
    <button id="select" class="btn btn-info">查看工资</button>
    
             <!-- 添加模态框（Modal） -->
                        <div class="modal fade" id="Modal"  role="dialog"  aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                            &times;
                                        </button>
                                        <h4 class="modal-title" id="myModalLabel">
                                            <span>查看</span> 
                                        </h4>
                                    </div>
                                    <div class="modal-body">   
                                        <table id="tbData"></table>
                                    </div>
                                    
                                </div><!-- /.modal-content -->
                            </div><!-- /.modal -->
                        </div>
                 
                        <!-- 添加模态框（Modal） -->
</body>
</html>
