<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserInfoManage.aspx.cs" Inherits="HRCMR.UserInfoManage" %>

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

    <script type="text/javascript">
        $(function () {
            //提示框初始化
            toastr.options = {
                 'positionClass': 'toast-top-center' ,
                'timeOut': '2000',
            };

            //绑定下拉框
            $.ajax({
                type: "post",
                url: "Handler/Department.ashx?state=sel",
                success: function (msg) {
                    var j = JSON.parse(msg);
                 
                    var strDep = "";
                    var strRole = "";
                    for (var i = 0; i < j["Department"].length; i++) {
                        strDep += "<option value='" + j["Department"][i].DepartmentID + "'>" + j["Department"][i].DepartmentName + "</option>";
                    }

                    for (var i = 0; i < j["Role"].length; i++) {
                        strRole += "<option value='" + j["Role"][i].RoleID + "'>" + j["Role"][i].RoleName + "</option>";
                    }

                    $("#selDep").append(strDep);
                    $("#DepartmentID").append(strDep);
                    $("#RoleID").append(strRole);
                }
            });

            //行内添加按钮
            function addBtn(value, row, index) {
                return [
                    '<button type="button" id="updata" class="btn btn-default" >修改</button>',
                    '<button type="button" id="del" class="btn btn-danger" >删除</button>'
                ].join('');
            };

            //行内按钮事件
            window.ope = {
                'click #updata': function (e, value, row, index) {
                    $("#Modal").modal('show');
                    $("#uUserID").val(row.UserID);
                    $("#UserName").val(row.UserName);
                    $("#DepartmentID").val(row.DepartmentID);
                    $("#RoleID").val(row.RoleID);
                    $("#UserAge").val(row.UserAge);
                    $("#UserSex").val(row.UserSex);
                    $("#UserTel").val(row.UserTel);
                    $("#UserAddress").val(row.UserAddress);
                    $("#testfile").fileinput('clear');
                    $("#EG_Photo").show();
                    EmImg = row.UserIphone;
                    $("#EG_Photo").attr('src', "img/FileUpload/" + row.UserIphone);

                    //重置验证
                    $("form").data('bootstrapValidator').destroy();
                    $('form').data('bootstrapValidator', null);
                    FormValidator();
                },
                'click #del': function (e, value, row, index) {
                    $("#delModal").modal('show');
                    $("#UserID").val(row.UserID);
                }
            };

            $("#tbData").bootstrapTable({
                url: 'Handler/UserInfo.ashx/?state=select',              //请求后台的URL（*）					
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
                uniqueId: "UserID",

                queryParams: function (parms) {				//参数列表
                    var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的				
                        //页面大小						
                        //////需要跳过的数量				
                        UserNameTxt: $("#UserNameTxt").val().trim(),
                        DepartmentID: $("#selDep").val(),
                        offset: parms.offset,
                        pageSize: parms.limit,
                    };
                    return temp;
                },
                columns: [
                    { checkbox: true },
                    { field: 'UserID', title: '编号', width: 100, align: 'center' },
                    { field: 'UserName', title: '姓名', width: 100, align: 'center' },
                    { field: 'DepartmentName', title: '部门', width: 100, align: 'center' },
                    {
                        field: 'UserSex', title: '性别',formatter: function (value, row, index) {
                            if (value=="1") {
                                return "男";
                            } else {
                                return "女";
                            }
                        }, width: 100, align: 'center'
                    },
                    { field: 'UserAge', title: '年龄', width: 100, align: 'center' },
                    { field: 'UserTel', title: '联系电话', width: 100, align: 'center' },
                    {
                        field: 'DimissionTime', title: '入职时间', formatter: function (value, row, index) {
                            var data = new Date(value)
                            var year = data.getFullYear();
                            var month = data.getMonth() + 1;
                            var day = data.getDate();
                            var d = year + "-" + month + "-" + day;
                            return d;
                        }, width: 100, align: 'center'
                    },
                    { field: 'BasePay', title: '基本工资', width: 100, align: 'center' },
                    { field: 'RoleID', title: '角色', visible: false, width: 100, align: 'center' },
                    { field: 'UserIphone', title: '角色', visible: false, width: 100, align: 'center' },
                    { field: 'DepartmentID', title: '角色', visible: false, width: 100, align: 'center' },
                    { field: "", title: '操作', formatter: addBtn, events: ope, width: 100, align: 'center' },

                ]
            });

            //验证
            FormValidator()

            //查询
            $("#btnSel").click(function () {
                $("#tbData").bootstrapTable(('refresh'));
            });

            //删除按钮
            $('#btnDel').click(function () {
                var row = $("#tbData").bootstrapTable("getSelections");
                if (row.length == 0) {
                    toastr.warning('请选择数据!');
                } else {
                    $("#UserID").val('0');
                    $("#delModal").modal('show');
                }
                
            });

            //添加
            $("#btnAdd").click(function () {
                //打开模态框
                $("#Modal").modal('show');
                //清空fileinput
                $("#testfile").fileinput('clear');
                $("#uUserID").val('0');
                $("#UserName").val('');
                $("#DepartmentID option,#RoleID option").removeAttr("selected");
                $("#DepartmentID option:eq(0)").attr("selected","selected");
                $("#RoleID option:eq(0)").attr("selected","selected");
                $("#UserAge").val('');
                $("#UserSex").val('1');
                $("#UserTel").val('');
                $("#UserAddress").val('');
                $("#EG_Photo").hide();
                
                //重置验证
                $("form").data('bootstrapValidator').destroy();
                $('form').data('bootstrapValidator', null);
                FormValidator();
            });

            //确认删除
            $("#btnD").click(function () {
                var id = $("#UserID").val();
                
                if (id == "0") {
                    var r = $("#tbData").bootstrapTable('getSelections');
                    var userid = "";
                    for (var i = 0; i < r.length; i++) {
                        if (i == (r.length - 1)) {
                            userid = userid + r[i].UserID;
                        } else {
                            userid = userid + r[i].UserID + ",";
                        }                        
                    }
                    $.ajax({
                        url: 'Handler/UserInfo.ashx?state=batchdel',
                        type: 'post',
                        data: {userid:userid},
                        success: function (msg) {
                            if (msg == '1') {
                                toastr.success("删除成功");
                                $("#delModal").modal('hide');
                                $("#tbData").bootstrapTable('refresh');
                            }
                        }
                    })
                } else {
                    $.ajax({
                        url: 'Handler/UserInfo.ashx?state=del',
                        type: 'post',
                        data: {userid:id},
                        success: function (msg) {
                            if (msg == '1') {
                                toastr.success("删除成功");
                                $("#delModal").modal('hide');
                                $("#tbData").bootstrapTable('refresh');
                            }
                        }
                    })  
                }
            });

            //提交
            $("#btnU").click(function () {
                //$("form").submit(function () { return false; });

                //开启验证
                $('form').data('bootstrapValidator').validate();  
                 if(!$('form').data('bootstrapValidator').isValid()){  
                 return ;  
                 }

                var obj = {
                    "UserID": $("#uUserID").val(),
                    "UserName": $("#UserName").val(),
                    "DepartmentID": $("#DepartmentID").val(),
                    "RoleID": $("#RoleID").val(),
                    "UserAge": $("#UserAge").val(),
                    "UserSex": $("#UserSex").val(),
                    "UserTel": $("#UserTel").val(),
                    "UserAddress": $("#UserAddress").val(),
                    "UserIphone":EmImg,
                };
                $.ajax({
                    type: "post",
                    url: "Handler/UserInfo.ashx/?state=AddUpdate",
                    data: { user: JSON.stringify(obj) },
                    success: function (msg) {
                        if (msg == "1") {
                            toastr.success('添加成功！');
                            $("#tbData").bootstrapTable('refresh');
                            $("#Modal").modal('hide');
                        } else if (msg == "2") {
                            toastr.success('修改成功！');
                            $("#tbData").bootstrapTable('refresh');
                            $("#Modal").modal('hide');
                        }
                    }
                });               
               
            });           

           		   var oFileInput = new FileInput();									
		           oFileInput.Init("testfile", "Handler/FileUploadHandler.ashx");									//上传图片调用方法


        })

        		//定义一个全局变量存储图片									
		        var EmImg="";									
		        //初始化fileinput									
		        var FileInput = function () {									
		            var oFile = new Object();									
											
		            //初始化fileinput控件（第一次初始化）									
		            oFile.Init = function (ctrlName, uploadUrl) {									
		                var control = $('#' + ctrlName);									
		                //初始化上传控件的样式									
		                control.fileinput({									
		                    language: 'zh', //设置语言									
		                    uploadUrl: uploadUrl, //上传的地址									
		                    allowedFileExtensions: ['jpg', 'gif', 'png'],//接收的文件后缀									
		                    showUpload: true, //是否显示上传按钮									
		                    showCaption: false,//是否显示标题									
		                    browseClass: "btn btn-primary", //按钮样式     									
		                    minImageWidth: 50, //图片的最小宽度									
		                    minImageHeight: 50,//图片的最小高度									
		                    maxImageWidth: 500,//图片的最大宽度									
		                    maxImageHeight: 500,//图片的最大高度									
		                    maxFileCount: 1, //表示允许同时上传的最大文件个数									
		                    enctype: 'multipart/form-data',									
		                    validateInitialCount: true,									
		                    previewFileIcon: "<i class='glyphicon glyphicon-king'></i>",									
		                    msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",									
		                });									
											
		                //导入文件上传完成之后的事件									
		                $(control).on("fileuploaded", function (event, data, previewId, index) {									
		                    var data = data.response;									
		                    //var last = data.lastIndexOf("Upload");									
                            //EmImg = data.substring(last + 7);			
                            
                            EmImg = data;
                            $("#EG_Photo").attr('src',"img/FileUpload/"+EmImg);
											
		                });									
		            }									
		            return oFile;									
		        };									

        //验证表单
        function FormValidator() {
            //验证
            $('form').bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                UserName: {
                    message: '用户名验证失败',
                    validators: {
                        notEmpty: {
                            message: '用户名不能为空'
                        },
                        stringLength: {
                            min: 0,
                            max: 18,
                            message: '用户名长度必须小于18位'
                        }
                       
                    }
                },
                DepartmentID: {
                    message: '部门验证失败',
                    validators: {
                        notEmpty: {
                            message: '请选择部门'
                        }
                    }
                },
                RoleID: {
                    message: '角色验证失败',
                    validators: {
                        notEmpty: {
                            message: '请选择角色'
                        }
                    }
                },
                UserAge: {
                     message: '年龄验证失败',
                    validators: {
                        notEmpty: {
                            message: '请输入年龄'
                        },
                        numeric: {
                            message: '请输入数字'
                        },
                        between: {
                            min: 0,
                            max: 130,
                            message: '请输入正确的年龄'
                        }
                    }
                },
                UserTel: {
                     message: '电话验证失败',
                    validators: {
                        notEmpty: {
                            message: '请输入电话'
                        },
                        regexp: {
                            regexp: /^1(3|4|5|7|8)\d{9}$/,
                            message: '电话格式不正确'
                        }
                    }
                },
                UserAddress: {
                     message: '地址验证失败',
                    validators: {
                        notEmpty: {
                            message: '请输入地址'
                        },
                        stringLength: {
                            min: 0,
                            max: 200,
                            message: '用户名长度必须小于200位'
                        }
                    }
                }
            }
        });
        }


    </script>

    <title></title>
</head>
<body>

        <div>
            <div id ="ta">
                <div class="form-inline">
                    <div class="form-group"><select id="selDep" class="form-control"><option value="0">全部</option></select></div>
                    <div class="form-group"><input type="text" placeholder="请输入姓名" id="UserNameTxt" class="form-control" /></div>
                    <div class="form-group"><button id="btnSel" class="btn btn-primary"><i class="glyphicon glyphicon-search"></i></button></div>
                    <div class="form-group"><button id="btnAdd" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i></button></div>
                    <div class="form-group"><button id="btnDel" class="btn btn-danger"><i class="glyphicon glyphicon-remove"></i></button></div>
                </div>
            </div>
            <table id="tbData">

            </table>


        </div>

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
                                        <form id="Frm">
                                        <div class="form-group" >
                                            <img id="EG_Photo"  style="width:100px; height:100px; border-radius:50%; overflow:hidden;"/>
                                        </div>
                                        <div class="form-group">                                            
                                            <label class="control-label" for="testfile">上传文件</label>
                                            <input type="file" id="testfile" name="test" multiple />
                                        </div>
                                        <div class="form-group">
                                            <input type="hidden" id="uUserID" value="0" />
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">名字</label>                                                 
                                            <input type="text" id="UserName" name="UserName" class="form-control" />
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">部门名</label>         
                                            <select id="DepartmentID" name="DepartmentID" class="form-control"><option value="" >---请选择---</option></select>
                                            
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">角色</label>           
                                            <select id="RoleID" name="RoleID" class ="form-control"><option value="">---请选择---</option></select>
                                            
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">年龄</label>                                            
                                            <input type="text" id="UserAge" name="UserAge" class="form-control" />
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">性别</label>                               
                                            <select id="UserSex" name="UserSex" class ="form-control"><option value="1">男</option><option value="0">女</option></select>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">电话</label>                                            
                                            <input type="text" id="UserTel" name="UserTel" class="form-control" />
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">地址</label>                                            
                                            <input type="text" id="UserAddress"  name="UserAddress" class="form-control" />
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

        </div>
</body>
</html>
