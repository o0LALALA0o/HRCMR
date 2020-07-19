<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="selectColleague.aspx.cs" Inherits="HRCMR.selectColleague" %>

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

    <script type="text/javascript">

        $(function () {
            $("#tbData").bootstrapTable({
                url: 'Handler/UserInfo.ashx/?state=selectColleague',              //请求后台的URL（*）					
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

                ]
            });

            $("#btnSel").click(function () {
                $("#tbData").bootstrapTable('refresh');
            });
        })

    </script>

</head>
<body>
   <div>
            <div id ="ta">
                <form class="form-inline">
                    <div class="form-group"><input type="text" placeholder="请输入姓名" id="UserNameTxt" class="form-control" /></div>
                    <div class="form-group"><button id="btnSel" class="btn btn-primary"><i class="glyphicon glyphicon-search"></i></button></div>
                </form>
            </div>
            <table id="tbData">

            </table>


    </div>
</body>
</html>
