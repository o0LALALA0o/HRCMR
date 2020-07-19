<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyUserInfoManage.aspx.cs" Inherits="HRCMR.MyUserInfoManage" %>

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
                    $("#DepartmentID").append(strDep);
                }
            });

            $.ajax({
                type: "post",
                url: "Handler/UserInfo.ashx?state=selMy",
                success: function (msg) {
                    var j = JSON.parse(msg);
                    $("#UserID").val(j.UserID);
                    $("#UserName").val(j.UserName);
                    $("#DepartmentID").val(j.DepartmentID);
                    $("#DepartmentID").attr("disabled","true");
                    $("#UserAge").val(j.UserAge);
                    $("#UserSex").val(j.UserSex);
                    $("#UserTel").val(j.UserTel);
                    $("#UserAddress").val(j.UserAddress);
                    $("#DimissionTime").val(j.DimissionTime);
                    $("#BasePay").val(j.BasePay);
                    $("#UserRemarks").val(j.UserRemarks);
                }
            })

            FormValidator()

            $("#btnU").click(function () {
                //开启验证
                $('form').data('bootstrapValidator').validate();  
                 if(!$('form').data('bootstrapValidator').isValid()){  
                 return ;  
                }

                var obj = {
                    "UserID": $("#UserID").val(),
                    "UserName": $("#UserName").val(),
                    "UserAge": $("#UserAge").val(),
                    "UserSex": $("#UserSex").val(),
                    "UserTel": $("#UserTel").val(),
                    "UserAddress": $("#UserAddress").val(),
                    "UserRemarks": $("#UserRemarks").val(),
                };

                $.ajax({
                    type: "post",
                    url: "Handler/UserInfo.ashx?state=updataMy",
                    data: { "User": JSON.stringify(obj) },
                    success: function (msg) {
                        if (msg == "1") {
                            toastr.success('修改成功!');
                            //重置验证
                            $("form").data('bootstrapValidator').destroy();
                            $('form').data('bootstrapValidator', null);
                            FormValidator();
                        }
                    }
                })

            });

        })

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
                        stringLength: {
                            min: 0,
                            max: 200,
                            message: '用户名长度必须小于200位'
                        }
                    }
                },
                UserRemarks: {
                     message: '个人介绍验证失败',
                    validators: {
                        stringLength: {
                            min: 0,
                            max: 200,
                            message: '个人介绍长度必须小于200位'
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
     
    <h4>&nbsp;&nbsp;个人信息</h4>
   <hr class="simple" color="#6f5499" />		
    <form role="form" class="form-horizontal">
            <%--<div class="form-group" >
                <img id="EG_Photo"  style="width:100px; height:100px; border-radius:50%; overflow:hidden;"/>
            </div>
            <div class="form-group">                                            
                <label class="control-label" for="testfile">上传文件</label>
                <input type="file" id="testfile" name="test" multiple />
            </div>--%>
            <div class="form-group">
                <div class="col-md-1"></div>
                <input type="hidden" id="UserID" value="" />
                <label class="control-label col-md-1">姓名</label>   
                <div class="col-md-8">
                    <input type="text" id="UserName" name="UserName" class="form-control " />
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-1"></div>
                <label class="control-label col-md-1">部门</label>  
                <div class="col-md-8">
                    <select id="DepartmentID" name="DepartmentID" class="form-control"><option value="0" >---请选择---</option></select>
                </div>
            </div>

            <div class="form-group">
                <div class="col-md-1"></div>
                <label class="control-label col-md-1">年龄</label>   
                <div class="col-md-8">
                    <input type="text" id="UserAge" name="UserAge" class="form-control" />
                </div>
            </div>
            <div class="form-group">                            
                <div class="col-md-1"></div>
                <label class="control-label col-md-1">性别</label>          
                <div class="col-md-8">
                    <select id="UserSex" name="UserSex" class ="form-control"><option value="1">男</option><option value="0">女</option></select>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-1"></div>
                <label class="control-label col-md-1">电话</label>          
                 <div class="col-md-8">
                     <input type="text" id="UserTel" name="UserTel" class="form-control" />
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-1"></div>
                <label class="control-label col-md-1">地址</label> 
                <div class="col-md-8">
                    <input type="text" id="UserAddress"  name="UserAddress" class="form-control" />
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-1"></div>
                <label class="control-label col-md-1">入职时间</label> 
                <div class="col-md-8">
                    <input type="text" id="DimissionTime"  readonly="readonly" name="DimissionTime" class="form-control" />
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-1"></div>
                <label class="control-label col-md-1">薪资</label> 
                <div class="col-md-8">
                    <input type="text" id="BasePay" readonly="readonly" name="BasePay" class="form-control" />
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-1"></div>
                <label class="control-label col-md-1">个人介绍</label> 
                <div class="col-md-8">
                    <textarea id="UserRemarks" placeholder="这个家伙很懒什么也没留下!"  name="UserRemarks" class="form-control"></textarea>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-9"></div>
                <div class="col-md-1">
                    <button type="button" id="btnU" class="btn btn-primary">
                        保存
                    </button>
                </div>
            </div>
    </form>
</body>
</html>
