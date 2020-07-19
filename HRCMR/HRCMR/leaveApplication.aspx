<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="leaveApplication.aspx.cs" Inherits="HRCMR.leaveApplication" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>

    <script src="Scripts/jquery-3.3.1.js"></script>
    <script src="Scripts/bootstrap.js"></script>
    <link href="css/bootstrap.css" rel="stylesheet" />

    <script src="js/bootstrap-table.js"></script>
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

            //初始化下拉框
            $.ajax({
                type: 'post',
                url: 'Handler/CategoryItems.ashx?state=select',
                data: { 'C_Category': 'LeaveHalfDay' },
                success: function (msg) {
                    var j = JSON.parse(msg);
                    var str = "";

                    for (var i = 0; i < j.length; i++) {
                        str += "<option value='" + j[i].CI_ID + "'>" + j[i].CI_Name + "</option>";
                    }

                    $("#LeaveHalfDay").append(str);
                }

            })

            //行内添加按钮
            function addBtn(value, row, index) {
                return [
                    '<button type="button" id="check" class="btn btn-default" >查看</button>'
                ].join('');
            };

            //行内按钮事件
            window.ope = {
                'click #check': function (e, value, row, index) {
                    $("#checkModal").modal('show');

                    $("#DepartmentalAudit").hide();
                    $("#GeneralManagerAudit").hide();
                    $("#ManagerAudit").hide();

                    if (row.DepartmentalAudit != 0) {//部门经理审批
                        if (row.DepartmentalAudit == 1) {    //同意
                            $("#DepartmentalAudit").attr('class','panel panel-success');
                        } else if (row.DepartmentalAudit == 2) { //驳回
                            $("#DepartmentalAudit").attr('class','panel panel-danger');
                        } else if (row.DepartmentalAudit == 3) { //审核中
                            $("#DepartmentalAudit").attr('class','panel panel-warning');
                        }

                        if (row.DepartmentalAuditRemarks == "")
                            $("#DepartmentalAuditRemarks").text('暂无审批意见')
                        else
                            $("#DepartmentalAuditRemarks").text(row.DepartmentalAuditRemarks);
                        $("#DepartmentalAudit").show();

                    } if (row.GeneralManagerAudit != 0) {//人事经理审批
                        if (row.GeneralManagerAudit == 1) {    //同意
                            $("#GeneralManagerAudit").attr('class','panel panel-success');
                        } else if (row.GeneralManagerAudit == 2) { //驳回
                            $("#GeneralManagerAudit").attr('class','panel panel-danger');
                        } else if (row.GeneralManagerAudit == 3) { //审核中
                            $("#GeneralManagerAudit").attr('class','panel panel-warning');
                        }

                        if (row.GeneralManagerAuditRemarks == "")
                            $("#GeneralManagerAuditRemarks").text('暂无审批意见')
                        else
                            $("#GeneralManagerAuditRemarks").text(row.DepartmentalAuditRemarks);
                        $("#GeneralManagerAudit").show();

                    } if (row.ManagerAudit != 0) {//总经理意见
                        if (row.ManagerAudit == 1) {    //同意
                            $("#ManagerAudit").attr('class','panel panel-success');
                        } else if (row.ManagerAudit == 2) { //驳回
                            $("#ManagerAudit").attr('class','panel panel-danger');
                        } else if (row.ManagerAudit == 3) { //审核中
                            $("#ManagerAudit").attr('class','panel panel-warning');
                        }

                        if (row.ManagerAuditRemarks == "")
                            $("#ManagerAuditRemarks").text('暂无审批意见')
                        else
                            $("#ManagerAuditRemarks").text(row.DepartmentalAuditRemarks);
                        $("#ManagerAudit").show();
                    }

                }
            };

            $("#tbData").bootstrapTable({
                url: 'Handler/Leave.ashx/?state=select',              //请求后台的URL（*）					
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
                    { field: 'ManagerAudit', title: '总经理审核状态', visible: false, width: 100, align: 'center' },
                    { field: 'ManagerAuditRemarks', title: '总经理意见', visible: false, width: 100, align: 'center' },
                    { field: 'GeneralManagerAudit', title: '人事经理审核状态', visible: false, width: 100, align: 'center' },
                    { field: 'GeneralManagerAuditRemarks', title: '人事经理意见', visible: false, width: 100, align: 'center' },
                    { field: 'DepartmentalAudit', title: '部门经理审核状态', visible: false, width: 100, align: 'center' },
                    {field: 'DepartmentalAuditRemarks', title: '部门经理意见',visible: false, width: 100, align: 'center'},
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
                    { field: 'CI_Name', title: '审批状态', width: 100, align: 'center' },
                    { field: "", title: '操作', formatter: addBtn, events: ope, width: 100, align: 'center' },

                ]
            });

            //申请请假
            $("#btnAdd").click(function () {
                $("#Modal").modal('show');
            });

            $("#LeaveHalfDay").change(function () {
                if ($(this).val() == '1') {
                    $("#t").val('8');
                } else {
                    $("#t").val('4');
                }
            });

            //选择时间
            $("#LeaveStartTime").change(function () {
                var is = changeLeaveTime();
                if (is == '0') {
                    $(this).val('');
                }
            });
            $("#LeaveEndTime").change(function () {
                var is = changeLeaveTime();
                if (is == '0') {
                    $(this).val('');
                }
            });

            //删除按钮
            $("#btnDel").click(function () {
                var row = $("#tbData").bootstrapTable("getSelections");
                if (row.length == 0) {
                    toastr.warning('请选择数据!');
                } else {
                    $("#delModal").modal('show');
                }
            });

            //删除
            $("#btnD").click(function () {
                var r = $("#tbData").bootstrapTable("getSelections");
                var leaveid = "";
                for (var i = 0; i < r.length; i++) {
                    if (r[i].LeaveState == '1' || r[i].LeaveState == '2') {
                        toastr.warning('已审批的记录不得删除!');
                        return;
                    }
                        if (i == (r.length - 1)) {
                            leaveid = leaveid + r[i].LeaveID;
                        } else {
                            leaveid = leaveid + r[i].LeaveID + ",";
                        }                        
                }

                $.ajax({
                    url: 'Handler/Leave.ashx?state=delete',
                        type: 'post',
                        data: {leaveid:leaveid},
                        success: function (msg) {
                            if (msg == '1') {
                                toastr.success("删除成功");
                                $("#delModal").modal('hide');
                                $("#tbData").bootstrapTable('refresh');
                            }
                        }
                })
            });

            //提交
            $("#btnU").click(function () {                
                if ($("#LeaveEndTime").val() == "" || $("#LeaveStartTime").val() == "") {
                    toastr.error("请选择请假时间!");
                } else {

                    var LeaveDays = "1";

                    if ($("#t").val()>=8) {
                        LeaveDays = $("#t").val() / 8;
                    }

                    var obj = {
                        "LeaveStartTime": $("#LeaveStartTime").val(),
                        "LeaveEndTime": $("#LeaveEndTime").val(),
                        "LeaveHalfDay": $("#LeaveHalfDay").val(),
                        "LeaveReason": $("#LeaveReason").val(),
                        "LeaveDays":LeaveDays,
                    };

                    $.ajax({
                        type: "post",
                        url: "Handler/Leave.ashx/?state=Application",
                        data: { "Leave": JSON.stringify(obj) },
                        success: function (msg) {
                            if (msg == "1") {
                                $("#Modal").modal('hide');
                                toastr.success("申请成功!");
                                $("#LeaveEndTime").val(''),
                                $("#LeaveStartTime").val('');
                                $("#LeaveHalfDay").val('1');
                                $("#LeaveReason").val('');
                                $("#t").val('');
                                $("#tbData").bootstrapTable('refresh');
                            }
                        }
                    })

                }
            });


        })

        //选择时间
        function changeLeaveTime() {
            if ($("#LeaveStartTime").val() != "" && $("#LeaveEndTime").val() != "") {
                //var date1 = $("#LeaveStartTime").val(); //开始时间
                //var date2 = $("#LeaveEndTime").val(); //结束时间 
                var date1 = new Date($("#LeaveStartTime").val()); //开始时间
                var date2 = new Date($("#LeaveEndTime").val()); //结束时间 
                var date3 = date2.getTime() - date1.getTime();  //时间差的毫秒数

                var days = Math.floor(date3 / (24 * 3600 * 1000));
                if (days == '0') {
                    $("#tdiv").show();
                    $("#t").val('8');
                } else if (days < 0) {
                    toastr.error("结束时间不得早于开始时间");
                    $("#t").val('');
                    $("#tdiv").hide();
                    $("#LeaveHalfDay").val('1');
                    return '0';
                } else {
                    $("#t").val(8*(days+1));
                    $("#tdiv").hide();
                    $("#LeaveHalfDay").val('1');
                }
            }
        }



    </script>

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
                    <button id="btnAdd" class="btn btn-success">申请请假</button>
                </div>
                <div class="form-group">
                    <button id="btnDel" class="btn btn-danger"><i class="glyphicon glyphicon-remove"></i></button>
                </div>
            </div>
        </div>
        
        <table id="tbData">

        </table>
        
         <!-- 添加模态框（Modal） -->
                        <div class="modal fade" id="Modal"  role="dialog"  aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                            &times;
                                        </button>
                                        <h4 class="modal-title" id="myModalLabel">
                                            <span>操作</span> 
                                        </h4>
                                    </div>
                                    <div class="modal-body">   
                                        <form id="Frm" class="form-horizontal">
                                        <div class="form-group">
                                            <div class="input-group input-daterange">
                                                <input id="LeaveStartTime" name="LeaveStartTime" type="text" placeholder="起始时间" data-date-format="yyyy-mm-dd" class="datetimepicker form-control"/>
                                            <div class="input-group-addon">~</div>
                                                <input id="LeaveEndTime" name="LeaveEndTime" type="text" placeholder="结束时间" data-date-format="yyyy-mm-dd" class="datetimepicker form-control"/>
                                            </div>
                                        </div>
                                       <div class="form-group">
                                            <div id="tdiv" style="display:none;">
                                               <div class="col-md-2">
                                                    <label>是否半天</label>
                                               </div>
                                               <div class="col-md-4">
                                                    <select id="LeaveHalfDay" class="form-control"></select>
                                               </div>
                                            </div>    
                                            <div class="col-md-2">
                                                <label>请假时长</label>
                                            </div>
                                            <div class="col-md-4">
                                                <input type="text" id="t" readonly="readonly" name="" class="form-control" />
                                            </div>   
                                        </div>
                                        <div class="form-group">
                                                <label>&nbsp&nbsp&nbsp 请假原因</label>
                                                <textarea id="LeaveReason" name="LeaveReason" class="form-control"></textarea>
                                        </div>
                                        
                                        </form>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" id="btnAddExit " class="btn btn-default" data-dismiss="modal">关闭
                                        </button>
                                        
                                        <button type="button" id="btnU" class="btn btn-primary">
                                            提交
                                        </button>
                                    </div>
                                    
                                </div><!-- /.modal-content -->
                            </div><!-- /.modal -->
                        </div>
                 
                        <!-- 添加模态框（Modal） -->
                        <!-- 删除模态框（Modal） -->
                        <div class="modal fade" id="delModal"  role="dialog"  aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                            &times;
                                        </button>
                                        <h4 class="modal-title" id="delModalLabel">
                                            操作提示
                                        </h4>
                                    </div>
                                    <div class="modal-body">
                                        <div class="form-inline">
                                            你确定要删除吗?
                                            <input type="hidden" id="UserID" value="0" />
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button"  class="btn btn-default" data-dismiss="modal">关闭
                                        </button>
                                        <button type="button" id="btnD" class="btn btn-primary">
                                            确认
                                        </button>
                                    </div>
                                </div><!-- /.modal-content -->
                            </div><!-- /.modal -->
                        </div>
                        <!-- 删除模态框（Modal） -->
                <!-- 查看模态框（Modal） -->
                        <div class="modal fade" id="checkModal"  role="dialog"  aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                            &times;
                                        </button>
                                        <h4 class="modal-title" id="checkModalLabel">
                                            操作提示
                                        </h4>
                                    </div>
                                    <div class="modal-body">
                                        <div class="form-inline">
                                            <div class="alert alert-info">注意!颜色代表审批状态(绿色-已同意,红色已反驳,橙色-待审核)</div>
                                            <div id="DepartmentalAudit" class="panel panel-warning" style="display:none;" >
                                               <div class="panel-heading">
                                                  <h3 class="panel-title">部门经理</h3>
                                               </div>
                                               <div id="DepartmentalAuditRemarks" class="panel-body">
                                                  暂无审批意见
                                               </div>
                                            </div>
                                            <div id="GeneralManagerAudit" style="display:none;" class="panel panel-warning">
                                               <div class="panel-heading">
                                                  <h3 class="panel-title">人事经理</h3>
                                               </div>
                                               <div id="GeneralManagerAuditRemarks" class="panel-body">
                                                  暂无审批意见
                                               </div>
                                            </div>
                                            <div id="ManagerAudit" style="display:none;" class="panel panel-warning">
                                               <div class="panel-heading">
                                                  <h3 class="panel-title">总经理</h3>
                                               </div>
                                               <div id="ManagerAuditRemarks" class="panel-body">
                                                  暂无审批意见
                                               </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button"  class="btn btn-default" data-dismiss="modal">退出
                                        </button>
                                    </div>
                                </div><!-- /.modal-content -->
                            </div><!-- /.modal -->
                        </div>
                        <!-- 查看模态框（Modal） -->

</body>
</html>
