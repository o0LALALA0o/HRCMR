<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="signin.aspx.cs" Inherits="HRCMR.signin" %>

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
   
    <script src="js/index.js"></script>
    <script src="js/schedule.js"></script>

    <script type="text/javascript">

        $(function () {

            var mySchedule = new Schedule({							
		                el: '#schedule-boxS',							
		                //异常考勤							
		                //qqDate: [{ time: "2019-10-17", Morning: "", Afternoon: "16:01" }, { time: "2019-07-16", Morning: "08:15", Afternoon: "" }, { time: "2019-07-13", Morning: "08:15", Afternoon: "" }],							
									
		                ////正常考勤							
		                //zcDate: [{ time: "2019-10-01", Morning: "10:00", Afternoon: "16:01" }, { time: "2019-07-02", Morning: "08:15", Afternoon: "" }, { time: "2019-07-03", Morning: "08:15", Afternoon: "" }],							
									
	        })							

            $("#btnAdd").click(function () {
                var obj = new Date();

                var AttendanceType = '3';

               
                $.ajax({
                     url: 'Handler/AttendanceSheet.ashx?state=selectIs',
                    type: 'post',
                    data: { 'AttendanceType':AttendanceType,'AttendanceStartTime': obj.getFullYear() + "-" + (obj.getMonth()+1) + "-"+obj.getDate() },
                    success: function (msg) {
                        if (msg == '0') {

                             //1 迟到 2早退 3正常
                            if (obj.getHours() > 8) {
                                AttendanceType = "1";
                            } 


                            $.ajax({
                                url: 'Handler/AttendanceSheet.ashx?state=add1',
                                type: 'post',
                                success: function (msg) {
                                    if (msg == '0' && obj.getHours() > 8) {
                                        alert('打卡成功！已迟到');
                                    } else {
                                        alert('打卡成功！');
                                    }
                                }
                            })

                            
                        } else {

                            if (obj.getHours()<18) {
                                AttendanceType = "2";
                            }

                             $.ajax({
                                url: 'Handler/AttendanceSheet.ashx?state=add2',
                                type: 'post',
                                data: {'AttendanceType':AttendanceType, 'AttendanceStartTime': obj.getFullYear() + "-" + (obj.getMonth()+1) + "-"+obj.getDate() },
                                success: function (msg) {
                                    if (msg == '0' && obj.getHours() < 18) {
                                        alert('打卡成功！已早退');
                                    } else {
                                        alert('打卡成功！');
                                    }
                                }
                            })

                           
                        }
                    }

                })

                
                //alert(obj.getFullYear() + "-" + (obj.getMonth()+1) + "-"+obj.getDate());
            });						
		 

        })

    </script>

    <title></title>
</head>
<body>
    		<div class="form-horizontal">							
									
		        <div class="index_frame_leftTop">							
		            <div id='schedule-boxS'></div>							
		            <%--上半部分：日历列表样式设置--%>							
									
		            <div class="index_liTLeft">							
		                <div class="index_liTline"></div>							
		            </div>							
		            <div class="index_liTRight">							
		                <div class="index_liTline"></div>							
		            </div>							
		        </div>							
									
		        <div class="index_frame_leftBottom">							
		            <%--下半部分打卡样式设置--%>							
		            <div class="index_liBLeft"></div>							
		            <div class="index_liBRight"></div>							
		            <div class="index_frame_leftBottom_Top clearfix">							
		            </div>							
									
		            <div class="main clearfix" style="margin-top: -60px">							
		                <%--打卡按钮--%>							
									
		                <div class="circle" id="btnAdd">							
									
		                    <h3 style="margin: 45px">打卡</h3>							
									
		                </div>							
									
		            </div>							
		        </div>							
		</div>							

</body>
</html>
