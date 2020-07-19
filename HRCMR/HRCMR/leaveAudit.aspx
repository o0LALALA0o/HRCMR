<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="leaveAudit.aspx.cs" Inherits="HRCMR.leaveAudit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

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

            //初始化表格
            $("#tbData").bootstrapTable({
                url: 'Handler/Leave.ashx/?state=selectAudit',              //请求后台的URL（*）					
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
                    { field: 'LeaveReason', title: '理由', width: 100, align: 'center' },
                    //{ field: "", title: '操作', formatter: addBtn, events: ope, width: 100, align: 'center' },

                ]
            });

            //审批
            $("#btnUp").click(function () {
                var row = $("#tbData").bootstrapTable('getSelections')
                if (row.length == 0) {
                    toastr.warning('请选择数据!');
                } else if (row.length > 1) {
                    toastr.warning('不要选择多条数据!');
                } else {
                    $("#LeaveReason").val(row[0].LeaveReason);
                    $("#LeaveID").val(row[0].LeaveID);
                    $("#Modal").modal('show');
                }
            });

            //提交
            $("#btnU").click(function () {
                if ($("#Audit").val() == '0') {
                    toastr.error('请选择审批结果!');
                } else {
                    $.ajax({
                        type: 'post',
                        url: 'Handler/OvertineCheck.ashx?state=audit',
                        data: { Audit: $("#Audit").val(), AuditRemarks: $("#AuditRemarks").val(), LeaveID: $("#LeaveID").val() },
                        success: function (msg) {
                            if (msg == '1') {
                                toastr.success('审批成功!');
                                $("#Modal").modal('hide');
                                $("#tbData").bootstrapTable('refresh');                                
                            }
                        }
                    });
                }
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
                    <button id="btnUp" class="btn btn-warning">审批</button>
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
                                            <input type="hidden" id="LeaveID" name="LeaveID" />
                                            <label>&nbsp&nbsp&nbsp 请假原因</label>
                                            <textarea id="LeaveReason" readonly="readonly" name="LeaveReason" class="form-control"></textarea>
                                        </div>
                                        <div class="form-group">
                                            <label>&nbsp&nbsp&nbsp 审批意见</label>
                                            <textarea id="AuditRemarks" name="AuditRemarks" class="form-control"></textarea>
                                        </div>
                                        <div class="form-group">
                                            <label>&nbsp&nbsp&nbsp 审批结果</label>
                                            <select id="Audit" name="Audit" class="form-control"><option value="0">--请选择--</option><option value="1">同意</option><option value="2">驳回</option></select>
                                        </div>
                                        </form>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" id="btnAddExit " class="btn btn-default" data-dismiss="modal">关闭
                                        </button>
                                        
                                        <button type="button" id="btnU" class="btn btn-primary">
                                            保存
                                        </button>
                                    </div>
                                    
                                </div><!-- /.modal-content -->
                            </div><!-- /.modal -->
                        </div>
                 
                        <!-- 添加模态框（Modal） -->
</body>
</html>
