<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="leaveLoc.aspx.cs" Inherits="HRCMR.leaveLoc" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    
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

    <script type="text/javascript">

        $(function () {

            //初始化提示框
            toastr.options = {
                'positionClass': 'toast-top-center' ,
                'timeOut': '2000',
            };

            //初始时间插件
            $('.datetimepicker').each(function () {
                $(this).datepicker({
                    language: 'zh-CN', //语言
                    autoclose: true, //选择后自动关闭
                    clearBtn: true,//清除按钮
                    format: "yyyy-mm-dd",//日期格式
                    todayHighlight: true,//今天高亮
                    startDate: new Date(),   //设置最小日期
                    //daysOfWeekDisabled: "0,6",//禁用周末
                    daysOfWeekHighlighted:"0,6"//设置高亮
                });
            });

            $("#tbData").bootstrapTable({
                url: 'Handler/Leave.ashx/?state=selectLoc',              //请求后台的URL（*）					
                striped: true,                      //是否显示行间隔色					
                cache: true,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）					
                pagination: true,                   //是否显示分页（*）					
                sortable: false,                     //是否启用排序		
                sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）					
                toolbar: '#ta',
                pageNumber: 1,                       //初始化加载第一页，默认第一页					
                pageSize: 5,                       //每页的记录行数（*）					
                pageList: [5, 10, 15, 20, 25],        //可供选择的每页的行数（*）					
                strictSearch: true,
                clickToSelect: false,                //是否启用点击选中行					
                showToggle: true,                   //是否显示详细视图和列表视图的切换按钮
                showRefresh: true,                  //是否显示刷新按钮                
                showColumns: true,
                cardView: false,                    //是否显示详细视图
                uniqueId: "LeaveID",
                queryParams: function (parms) {				//参数列表
                    var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的				
                        //页面大小						
                        //////需要跳过的数量				
                        
                        offset: parms.offset,
                        pageSize: parms.limit,
                    };
                    return temp;
                },
                columns: [
                    { checkbox: true },
                    { field: 'LeaveID', title: '编号',visible: false, width: 100, align: 'center' },
                    { field: 'UserName', title: '姓名', width: 100, align: 'center' },
                    { field: 'UserTel', title: '电话', width: 100, align: 'center' },
                    { field: 'DepartmentName', title: '部门', width: 100, align: 'center' },
                    {
                        field: 'LeaveStartTime', title: '开始时间', formatter: function (value, row, index) {
                            var data = new Date(value)
                            var year = data.getFullYear();
                            var month = data.getMonth() + 1;
                            var day = data.getDate();
                            var d = year + "-" + month + "-" + day;
                            return d;
                        }, width: 100, align: 'center' },
                    {
                        field: 'LeaveEndTime', title: '结束时间', formatter: function (value, row, index) {
                            var data = new Date(value)
                            var year = data.getFullYear();
                            var month = data.getMonth() + 1;
                            var day = data.getDate();
                            var d = year + "-" + month + "-" + day;
                            return d;
                        }, width: 100, align: 'center'
                    },
                    { field: 'LeaveDays', title: '请假天数', width: 100, align: 'center' },
                    {
                        field: 'LeaveHalfDay', title: '是否为半天',formatter: function (value, row, index) {
                            if (value=="1") {
                                return "全天";
                            } else if(value == "2"){
                                return "上午";
                            } else {
                                return "下午";
                            }
                        }, width: 100, align: 'center'
                    },
                    {
                        field: 'LeaveTime', title: '申请时间', formatter: function (value, row, index) {
                            var data = new Date(value)
                            var year = data.getFullYear();
                            var month = data.getMonth() + 1;
                            var day = data.getDate();
                            var d = year + "-" + month + "-" + day;
                            return d;
                        }, width: 100, align: 'center'
                    },
                    { field: 'LeaveReason', title: '审批理由', width: 100, align: 'center' },

                ],
                showExport: true,  //是否显示导出按钮
                //buttonsAlign:"right",  //按钮位置
                //exportDataType: 'basic',   //导出的方式 all全部 selected已选择的  basic', 'all', 'selected'.
                //export: 'glyphicon-export icon-share',
        
                //>>>>>>>>>>>>>>导出excel表格设置
 //是否显示导出按钮(此方法是自己写的目的是判断终端是电脑还是手机,电脑则返回true,手机返回falsee,手机不显示按钮)
exportDataType: "basic", //basic', 'all', 'selected'.

//exportButton: $('#btn_export'), //为按钮btn_export 绑定导出事件 自定义导出按钮(可以不用)
exportOptions:{
//ignoreColumn: [0,0], //忽略某一列的索引
fileName: '数据导出', //文件名称设置
worksheetName: 'Sheet1', //表格工作区名称
tableName: '商品数据表',
excelstyles: ['background-color', 'color', 'font-size', 'font-weight'],
//onMsoNumberFormat: DoOnMsoNumberFormat
}
//导出excel表格设置<<<<<<<<<<<<<<<<



            });

        })

    </script>

    <title></title>
</head>
<body>
        <%--工具栏--%>
        <div id ="ta">
            <div class="form-inline">
                <div class="form-group">
                    <div class="input-group input-daterange">
                        <input id="" name="" type="text" placeholder="起始时间" data-date-format="yyyy-mm-dd" class="datetimepicker form-control"/>
                        <div class="input-group-addon">~</div>
                        <input id="" name="" type="text" placeholder="结束时间" data-date-format="yyyy-mm-dd" class="datetimepicker form-control"/>
                    </div>
                </div>      
                <div class="form-group">
                    <button id="btnSel" class="btn btn-primary"><i class="glyphicon glyphicon-search"></i></button>
                </div>
                <div class="form-group">
                    <button id="btnDel" class="btn btn-danger"><i class="glyphicon glyphicon-remove"></i></button>
                </div>
            </div>
        </div>
        
        <table id="tbData">

        </table>
</body>
</html>
