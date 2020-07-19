<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Department.aspx.cs" Inherits="HRCMR.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
   
    <script src="Scripts/jquery-3.3.1.js"></script>
    <script src="Scripts/bootstrap.js"></script>
    <link href="Scripts/toastr.css" rel="stylesheet" />
    <script src="js/bootstrap-table.js"></script>
    <link href="css/bootstrap.css" rel="stylesheet" />
    <link href="css/bootstrap-table.css" rel="stylesheet" />
    <script src="js/bootstrap-table-zh-CN.js"></script>
    <script src="Scripts/toastr.min.js"></script>

    <script type="text/javascript">
        $(function () {
            toastr.options = {
                'positionClass': 'toast-top-center' ,
                'timeOut': '2000',
            };
            //行内添加按钮
            function addBtn(value,row,index) {
                return [
                    //修改按钮
                    '<button type="button" id="updata" class="btn btn-default" >修改</button>',
                    '<button type="button" id="del" class="btn btn-danger" >删除</button>'
                ].join('');
            }

            //行内按钮事件
            window.ope = {
                //修改事件
                'click #updata': function (e, value, row, index) {
                    $("#updataModal").modal('show');
                    $("#updataModal :text[name='DepartmentID']").val(row.DepartmentID);
                    $("#updataModal :text[name='DepartmentName']").val(row.DepartmentName);
                    $("#updataModal :input[name='DepartmentRemarks']").val(row.DepartmentRemarks);
                },
                'click #del': function (e, value, row, index) {
                    $("#delId").val(row.DepartmentID);
                    $("#delModal").modal('show');
                }
            };


            //初始化bootstrapTable
            $("#tbData").bootstrapTable({
                url: 'Handler/Department.ashx/?state=select',              //请求后台的URL（*）					
                striped: true,                      //是否显示行间隔色					
                cache: true,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）					
                pagination: true,                   //是否显示分页（*）					
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
                uniqueId: "DepartmentID",
                
                queryParams: function (parms) {				//参数列表
                    var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的				
                        //页面大小				
                        limit: parms.limit, //页面大小				
                        //////需要跳过的数量				
                        DepartmentName: $("#name").val(),
                        offset: parms.offset,
                        pageSize: parms.limit,
                    };
                    return temp;
                },
	                columns: [					
	                        { checkbox: true },					
	                        { field: 'DepartmentID', title: '部门ID', width: 100, align: 'center' },					
	                        { field: 'DepartmentName', title: '部门名称', width: 100, align: 'center' },					
	                        { field: 'DepartmentRemarks', title: '备注', width: 100, align: 'center' },		
                            {field:"",title:'操作',formatter:addBtn,events:ope,width:100,align:'center'},
	                        	
	                ]					
	            })					

            //查询
            $("#ta").click(function () {
                $("#tbData").bootstrapTable(('refresh'));
            })

            
            //添加部门
            $("#btnAdd").click(function () {
                toastr.clear();
                var depname = $("#DepartmentName").val().trim()
                if (depname == "") {
                    toastr.error('请填写部门名!');
                    //toastr.warning('部门有重复');
                    return;
                }
                $.ajax({
                    url: 'Handler/Department.ashx?state=add',
                    type: 'post',
                    data: { 'DepartmentName': depname },
                    success: function (msg) {
                        if (msg == '1') {
                            $("#tbData").bootstrapTable(('refresh'));
                            $("#addModal").modal("hide");
                            $("#DepartmentName").val("");
                            toastr.success('添加成功!');
                        } else if (msg == "0") {
                            toastr.warning('该部门已存在!');
                        }
                    }
                });
            });

            //确认删除
            $("#btnDel").click(function () {
                var rows = $("#tbData").bootstrapTable('getSelections');
                var a;
                if (rows.length == 0) {
                    a = $("#delId").val();
                    $.ajax({
                        url: 'Handler/Department.ashx?state=delO',
                        type: "post",
                        dataType: "json",
                        data: { 'DepartmentID': a },
                        success: function (msg) {
                            if (msg == "1") {
                                $("#tbData").bootstrapTable('refresh');
                                $("#delModal").modal('hide');
                            }
                        }
                    })
                } else {
                    a = $.map(rows, function (row) { return row.DepartmentID });
                    //var b = "";
                    //for (var i = 0; i < rows.length; i++) {
                    //    if (i==(rows.length-1)) {
                    //        b = b + rows[i].DepartmentID;
                    //    } else {
                    //        b = b + rows[i].DepartmentID+ ",";
                    //    }
                        
                    //}
                    //alert(b);
                    $.ajax({
                    url: 'Handler/Department.ashx?state=del',
                    type: "post",
                    dataType: "json",
                    data: { 'jsonStr': JSON.stringify(a) },
                    success: function (msg) {
                        if (msg == "1") {
                            $("#tbData").bootstrapTable('refresh');
                            $("#delModal").modal('hide');
                        }
                    }
                })
                }
                 
                delDepartment(a);
            })


            //修改
            $("#btnUpdata").click(function () {
                var obj = {
                    "DepartmentID": $("#updataForm :text[name='DepartmentID']").val(),
                    "DepartmentName": $("#updataForm :text[name='DepartmentName']").val().trim(),
                    "DepartmentRemarks": $("#updataForm :input[name='DepartmentRemarks']").val(),
                };
                $.ajax({
                    url: 'Handler/Department.ashx?state=updata',
                    type: "post",
                    dataType: "json",
                    data: { 'jsonStr': JSON.stringify(obj) },
                    success: function (msg) {
                        if (msg == '1') {
                            $("#tbData").bootstrapTable('refresh');
                            $("#updataModal").modal('hide');
                            toastr.success('修改成功!');
                        }else if (msg == "0") {
                            toastr.warning('该部门已存在!');
                        }
                    }
                })
            });

            //删除
            $("#delBtn").click(function () {
                toastr.clear();
                var row = $("#tbData").bootstrapTable('getSelections');
                if (row.length == 0) {
                    toastr.warning('请选择数据!');
                } else {
                    $("#delModal").modal('show');
                }                
            });

            

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
    
    <!-- 添加模态框（Modal） -->
                        <div class="modal fade" id="addModal"  role="dialog"  aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                            &times;
                                        </button>
                                        <h4 class="modal-title" id="myModalLabel">
                                            <span><i class="glyphicon glyphicon-plus"></i></span> 
                                        </h4>
                                    </div>
                                    <div class="modal-body">                                     
                                        <div class="form-group">
                                            <label class="control-label">部门名</label>                                            
                                            <input type="text" id="DepartmentName" class="form-control" />
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" id="btnAddExit " class="btn btn-default" data-dismiss="modal">关闭
                                        </button>
                                        
                                        <button type="button" id="btnAdd" class="btn btn-primary">
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
                                            <input type="hidden" id="delId" />
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button"  class="btn btn-default" data-dismiss="modal">关闭
                                        </button>
                                        <button type="button" id="btnDel" class="btn btn-primary">
                                            确认
                                        </button>
                                    </div>
                                </div><!-- /.modal-content -->
                            </div><!-- /.modal -->
                        </div>
                        <!-- 删除模态框（Modal） -->
 
            <!-- 修改模态框（Modal） -->
                    <div class="modal fade" id="updataModal"  role="dialog"  aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                            &times;
                                        </button>
                                        <h4 class="modal-title" id="updataModalLabel">
                                            操作提示
                                        </h4>
                                    </div>
                                    <div class="modal-body">
                                        <div class="form-group">
                                            <form id="updataForm">
                                                <label>部门ID</label>
                                                <input type="text" name="DepartmentID" readonly="readonly" class="form-control" />
                                                <label>部门名</label>
                                                <input type="text" name="DepartmentName" class="form-control" />
                                                <label>备注</label>
                                                <textarea name="DepartmentRemarks" class="form-control"></textarea>
                                            </form>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button"  class="btn btn-default" data-dismiss="modal">关闭</button>
                                        <button type="button" id="btnUpdata" class="btn btn-primary">
                                            确认
                                        </button>
                                    </div>
                                </div><!-- /.modal-content -->
                            </div><!-- /.modal -->
                        </div>
                    <!-- 修改模态框（Modal） -->


</body>
</html>
