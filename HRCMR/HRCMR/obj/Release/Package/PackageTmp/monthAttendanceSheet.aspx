<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="monthAttendanceSheet.aspx.cs" Inherits="HRCMR.monthAttendanceSheet" %>

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


     <link href="css/circle.css" rel="stylesheet" />
    <link href="css/index.css" rel="stylesheet" />
   
    <script type="text/javascript">

        function getLastDay(year, month)
        {
            var d = new Date(0);
            if (month == 12)
            {
                d.setUTCFullYear(year + 1);
                d.setUTCMonth(0);
            }
            else
            {
                d.setUTCFullYear(year);
                d.setUTCMonth(month);
            }
            d.setTime(d.getTime() - 1);
            return d.getUTCDate();
        }

        $(function () {
            var obj = new Date();
            var m = obj.getMonth() + 1;
            var d = getLastDay(obj.getFullYear(),m);

            var d1 = obj.getFullYear() + "-" + m + "-" + "1";
            var d2 = obj.getFullYear() + "-" + m + "-" + d;

            //初始化bootstrapTable
            $("#tbData").bootstrapTable({
                url: 'Handler/AttendanceSheet.ashx?state=select',              //请求后台的URL（*）					
                striped: true,                      //是否显示行间隔色					
                cache: true,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）					
                pagination: false,                   //是否显示分页（*）					
                sortable: false,                     //是否启用排序					
                sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）					
                toolbar: '#g',
                pageNumber: 1,                       //初始化加载第一页，默认第一页					
                pageSize: 5,                       //每页的记录行数（*）					
                pageList: [5, 10, 15, 20, 25],        //可供选择的每页的行数（*）					
                strictSearch: true,
                clickToSelect: false,                //是否启用点击选中行					
                 showToggle: true,                   //是否显示详细视图和列表视图的切换按钮
                showRefresh: true,                  //是否显示刷新按钮                
                showColumns: true,
                cardView: false,                    //是否显示详细视图
                uniqueId: "",
                
                queryParams: function (parms) {				//参数列表
                    var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的				
                        //页面大小				
                        limit: parms.limit, //页面大小				
                        //////需要跳过的数量				
                        offset: parms.offset,
                        pageSize: parms.limit,
                        d1: d1,
                        d2:d2,
                    };
                    return temp;
                },
	                columns: [					
	                        { checkbox: true },					
                        {
                            field: 'AttendanceStartTime', title: '考勤时间', width: 100, align: 'center', formatter: function (value, row, index) {
                                var data = new Date(value)
                                var year = data.getFullYear();
                                var month = data.getMonth() + 1;
                                var day = data.getDate();
                                var d = year + "-" + month + "-" + day;
                                return d;
                            }
                        },					
                        {
                            field: 'ClockTime', title: '出勤时间', width: 100, align: 'center', formatter: function (value, row, index) {
                                var data = new Date(value)
                                var Hours = data.getHours();
                                var Minutes = data.getMinutes();
                                if (data.getMinutes() < 10) {
                                    Minutes = "0" + Minutes;
                                }
                                if (data.getHours() < 10) {
                                     Hours = "0" + Hours;
                                }
                                
                                var d = Hours + ":" + Minutes;
                                return d;
                            }
                        },					
                        {
                            field: 'ClockOutTime', title: '退勤时间', width: 100, align: 'center', formatter: function (value, row, index) {
                                var data = new Date(value)
                                var Hours = data.getHours();
                                var Minutes = data.getMinutes();
                                if (data.getMinutes() < 10) {
                                    Minutes = "0" + Minutes;
                                }
                                if (data.getHours() < 10) {
                                     Hours = "0" + Hours;
                                }
                                
                                var d = Hours + ":" + Minutes;
                                return d;
                            }
                        },		
                        {
                            field: 'AttendanceType', title: '考勤状态', width: 100, align: 'center',formatter: function (value, row, index) {
                                if (value == "1") {
                                    return "迟到";
                                } else if(value == "2"){
                                    return "早退";
                                } else {
                                    return "正常";
                                }
                            }
                        },
                            //{field:"",title:'操作',formatter:addBtn,events:ope,width:100,align:'center'},
	                        	
	                ]					
	            })
        })

    </script>

    <title></title>
</head>
<body>
    <div id="g">
            <div class="form-inline">
              <div class="form-group">
                <input type="text" class="form-control " id="name" placeholder="请输入部门名称" />
              </div>
              <div class="form-group">
                <button type="button" id="ta" class="btn btn-default" ><i class="glyphicon glyphicon-search"></i></button>
              </div> 
              <div class="form-group">
                  <button class="btn btn-success" data-toggle="modal" data-target="#addModal"><i class="glyphicon glyphicon-plus"></i></button>    
              </div>
                <div class="form-group">
                  <button class="btn btn-danger" id="delBtn" data-toggle="modal"><i class="glyphicon glyphicon-remove"></i></button>
              </div>
              
            </div>
      </div>
      <table id="tbData"></table>
</body>
</html>
