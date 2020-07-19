0<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Main.aspx.cs" Inherits="HRCMR.Main" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
   <%-- <link href="css/bootstrap.min.css" rel="stylesheet" />--%>
    <link href="css/bootstrap.css" rel="stylesheet" />
    <link rel="stylesheet" href="css/bootstrap-responsive.min.css" />
    <link rel="stylesheet" href="css/fullcalendar.css" />
    <link rel="stylesheet" href="css/matrix-style.css" />
    <link rel="stylesheet" href="css/matrix-media.css" />
    <link href="font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link rel="stylesheet" href="css/jquery.gritter.css" />

    <script src="Scripts/jquery-3.3.1.js"></script>
    <script src="Scripts/bootstrap.js"></script>
    <script src="js/matrix.js"></script>

    <script src="js/bootstrapValidator.min.js"></script>
    <link href="css/bootstrapValidator.min.css" rel="stylesheet" />
    <script src="js/zh_CN.js"></script>

    <script src="Scripts/toastr.min.js"></script>
    <link href="Scripts/toastr.css" rel="stylesheet" />

    <style type="text/css">
        /*#user-nav {
            z-index: 0;
        }*/
        body {
            margin-top: -18px;
        }
        #header {
            height: 86px;
        }
        #user-nav > ul > li > a {
            padding: 13px 10px;
        }
    </style>

    <script type="text/javascript">
        $(function () {
                //提示框初始化
                toastr.options = {
                     'positionClass': 'toast-top-center' ,
                    'timeOut': '2000',
                };

            	//动态加载iframe内容
	            $("#ul-menu  a ,#umenu a").click(function () {
	                var titles = $(this).text();
	                var url = $(this).attr("url");
	                if (url != undefined) {
	                    $("#ifr").attr("src", url);
	                    $("#breadcrumb").html("<a href='/Main/Index' title='主页' class='tip-bottom'><i class='icon-home'></i>主页</a><a href=" + url + " title=" + titles + " class='tip-bottom'>" + titles + "</a>");
	
	                }
	            });
	           
	            $("#ul-menu li").click(function () {
	                $("#ul-menu .active").removeClass("active");
	                $(this).addClass("active");
            });

            FormValidator();

            $("#aPwd").click(function () {
                $("#Modal").modal('show');

                $("#lLoginPwd").val('');
                $("#newLoginPwd").val('');
                $("#cLoginPwd").val('');


                //重置验证
                $("#pwdForm").data('bootstrapValidator').destroy();
                $('#pwdForm').data('bootstrapValidator', null);
                FormValidator();

            });

            //提交修改
            $('#btnU').click(function () {
                //开启验证
                $('#pwdForm').data('bootstrapValidator').validate();  
                 if(!$('#pwdForm').data('bootstrapValidator').isValid()){  
                 return ;  
                 }

                var obj = {
                   "lLoginPwd": $("#lLoginPwd").val(),
                    "newLoginPwd": $("#newLoginPwd").val(),
                   "cLoginPwd":  $("#cLoginPwd").val(),
                };

                $.ajax({
                    type: "post",
                    url: "Handler/UserInfo.ashx?state=updataPwd",
                    data: { "lLoginPwd": $("#lLoginPwd").val(), "newLoginPwd": $("#newLoginPwd").val(), "cLoginPwd": $("#cLoginPwd").val() },
                    success: function (msg) {
                        if (msg == "0") {
                            toastr.warning('原密码错误!');
                        } else if(msg == "1") {
                            toastr.success('修改成功!');
                            $("#Modal").modal('hide');
                        }
                    }
                })


            });

        })


        //验证表单
        function FormValidator() {
            //验证
            $('#pwdForm').bootstrapValidator({
                message: 'This value is not valid',
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    lLoginPwd: {
                        message: '原密码验证失败',
                        validators: {
                            notEmpty: {
                                message: '原密码不能为空'
                            },
                            stringLength: {
                                min: 6,
                                max: 18,
                                message: '原密码长度必须大于6位小于18位'
                            },                           
                            //remote: {   // ajax校验，获得一个json数据（{'valid': true or false}）
                            //      url: 'Handler/UserInfo.ashx?state=ValidatorPwd',       //验证地址
                            //      message: '原密码错误',   //提示信息
                            //      type: 'POST'          //请求方式
                            //      //data: function(validator){  //自定义提交数据，默认为当前input name值
                            //      //  return {
                            //      //    act: 'is_registered',
                            //      //    username: $("input[name='username']").val()
                            //      //  };
                            //      //}
                            //}

                        }
                    }, newLoginPwd: {
                        message: '新密码验证失败',
                        validators: {
                            notEmpty: {
                                message: '新密码不能为空'
                            },
                            stringLength: {
                                min: 6,
                                max: 18,
                                message: '新密码长度必须大于6位小于18位'
                            },
                             different: {  //比较
                              field: 'lLoginPwd', //需要进行比较的input name值
                              message: '新密码不能与原密码相同'
                            },
 

                        }
                    }, cLoginPwd: {
                        message: '确认密码验证失败',
                        validators: {
                            notEmpty: {
                                message: '新密码不能为空'
                            },
                            identical: {
                                field: 'newLoginPwd',
                                message: '输入的两次密码不一致'
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
    <form id="form1" runat="server">
    </form>

    	    <!--Header-part-->
	    <div id="header">
	        <h1><a href="dashboard.html">MatAdmin</a></h1>
	    </div>
	    <!--close-Header-part-->
	    <!--top-Header-menu-->
	    <div id="user-nav" class="navbar navbar-inverse">
	        <ul class="nav">
	            <li class="dropdown" id="profile-messages"><a title="" href="#" data-toggle="dropdown" data-target="#profile-messages" class="dropdown-toggle"><i class="icon icon-user"></i>
	                <span class="text">欢迎 <%= user.LoginName %></span><b class="caret"></b></a>
	                <ul id="umenu" class="dropdown-menu">
	                    <li><a url="MyUserInfoManage.aspx" href="#"><i class="icon-user"></i>我的资料</a></li>
                        <li class="divider"></li>
                        <li><a href="#" id="aPwd"><i class="icon-key"></i>修改密码</a></li>
	                    <li class="divider"></li>
	                    <li><a href="#"><i class="icon-check"></i>我的任务</a></li>	                    
	                </ul>
	            </li>
	
	            <li class=""><a title="" href="Login.aspx"><i class="icon icon-share-alt"></i><span class="text">退出</span></a></li>
	        </ul>
	    </div>
	    <!--close-top-Header-menu-->

	    <!--sidebar-menu-->
	    <div id="sidebar">
	        <a href="#" class="visible-phone"><i class="icon icon-home"></i>控制台</a>
	        <ul id="ul-menu">
	            <li><a href="Login.aspx"><i class="icon icon-home"></i><span>首页</span></a> </li>
	
	            <li class="submenu" >
	                <a href="#"><i class="icon icon-home"></i><span>员工资料管理</span></a>
	                <ul>
	
	                    <li><a href="#" url="MyUserInfoManage.aspx">个人信息</a></li>
	                    <li><a href="#" url="selectColleague.aspx">查询同事信息</a></li>	 
	                    <li><a href="#" url="UserInfoManage.aspx">员工管理</a></li>
	
	                </ul>
	            </li>
                <%if (user.RoleID == "5")
                    { %>
	            <li><a href="#" url="Department.aspx"><i class="icon icon-signal"></i><span>部门管理</span></a> </li>
	          <%} %>
	            <li class="submenu">
	                <a href="#"><i class="icon icon-th-list"></i><span>请假管理</span> </a>
	                <ul>
	                    <li><a href="#" url="leaveApplication.aspx">申请请假</a></li>
                        <%if (user.RoleID == "2" || user.RoleID == "4" || user.RoleID == "5")
                            { %>
	                    <li><a href="#" url="leaveAudit.aspx">请假审核</a></li>
                        <%} %>
                        <% if ( user.RoleID == "4" || user.RoleID == "5")
                            { %>
	                    <li><a href="#" url="leaveLoc.aspx">请假记录</a></li>
                        <%} %>
	                </ul>
	            </li>
                <li class="submenu">
                    <a href="#"><i class="icon icon-pencil"></i><span>考勤管理</span></a>
                    <ul>
                        <li><a href="#" url="monthAttendanceSheet.aspx">查看本月考勤</a></li>
	                    <li><a href="#" url="signin.aspx">签到</a></li>
                   </ul>
                </li>
                
	            <li class="submenu">
                    <a href="#"><i class="icon icon-tint"></i><span>薪资管理</span></a>
                     <ul>
                        <li><a href="#" url="selectPaySlip.aspx">查看本月薪资</a></li>
                   </ul>
	            </li>
	            
	       
	          
	        </ul>
	    </div>
	    <!--sidebar-menu-->
	
	    <!--main-container-part-->
	    <div id="content"  style="width: 100%; height: 100%;"> 
	        <!--breadcrumbs-->
	        <div id="content-header">
	            <div id="breadcrumb"><a href="index.html" title="Go to Home" class="tip-bottom"><i class="icon-home"></i>首页</a></div>
	        </div>
	        <!--End-breadcrumbs-->
	
	        <!--Action boxes-->
	      <div class="container-fluid" style="width: 100%; height: 97%;">
	            <div class="row-fluid" style="width: 100%; height: 98%;">
	            
	                <iframe id="ifr" style="width: 85%; height: 99%; background:url(/Content/cat1.jpg) no-repeat;background-size:cover;" frameborder="0"></iframe>
	            </div>
	        </div>
	    </div>


    <!-- 添加模态框（Modal） --><form id="pwdForm">
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
                                        <div class="form-group">
                                            <label class="control-label">原密码</label>                                                 
                                            <input type="password" id="lLoginPwd" name="lLoginPwd" class="form-control" />
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">新密码</label>                                                 
                                            <input type="password" id="newLoginPwd" name="newLoginPwd" class="form-control" />
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">确认密码密码</label>                                                 
                                            <input type="password" id="cLoginPwd" name="cLoginPwd" class="form-control" />
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" id="btnAddExit " class="btn btn-default" data-dismiss="modal">关闭
                                        </button>
                                        
                                        <button type="button" id="btnU" class="btn btn-primary">
                                            修改
                                        </button>
                                    </div>
                                    
                                </div><!-- /.modal-content -->
                            </div><!-- /.modal -->
                        </div>
                 </form>
                        <!-- 添加模态框（Modal） -->
</body>
</html>
