--使用master数据库
use master
go

--判断HRCMRDB数据库是否存在
if exists(select * from sysdatabases where name ='HRCMRDB')
drop database HRCMRDB
go

--创建HRCMRDB数据库
create database HRCMRDB
go

--使用HRCMRDB数据库
use HRCMRDB
go


--判断Department表(部门表)是否存在
if exists(select * from sysobjects where name = 'Department')
drop table UserInfo
go

--创建Department表(部门表)
create table Department
(
	DepartmentID int primary key identity(10,10),	--部门编号(主键)
	DepartmentName varchar(50),	--部门名称
	DepartmentRemarks varchar(200), --备注
	isDel int
)


--判断Role表(角色表)是否存在
if exists(select * from sysobjects where name = 'Role')
drop table Role
go

--创建Role表(角色表)
create table Role
(
	RoleID Int primary key,	--角色编号(主键)
	RoleName varchar(50),	--角色名称
	RoleNumber varchar(200)	--角色权限百分比
)

--判断UserInfo表(用户表)是否存在
if exists(select * from sysobjects where name = 'UserInfo')
drop table UserInfo
go

--创建UserInfo表(用户表)
create table UserInfo
(
	UserID Int primary key identity(1001,1),	--序号(主键)
	DepartmentID int references Department(DepartmentID),	--部门编号
	RoleID Int references Role(RoleID),	--角色编号（1.总经理 2.人事经理 3.人事助理 4.部门经理 5.员工）
	UserNumber Varchar(50),	--用户编号
	LoginName Varchar(50),	--登陆名
	LoginPwd Varchar(50),	--密码
	UserName Varchar(50),	--真实姓名
	UserAge int,	--年龄
	UserSex int,	--性别 （1.男  0.女）
	UserTel varchar(11),	--电话
	UserAddress Varchar(100),	--家庭地址
	UserIphone varchar(200),	--手机
	UserRemarks Varchar(200),	--备注
	UserStatr int,	--是否可用（0.不可登陆 1.可登陆）
	EntryTime Datetime,	--最后登陆时间
	DimissionTime Datetime,	--入职时间
	BasePay money	--薪资
)


--判断Assessment表(业绩评定表)是否存在
if exists(select * from sysobjects where name = 'Assessment')
drop table Assessment
go

--创建Assessment表(业绩评定表)
create table Assessment
(
	AssessmentID Int primary key identity(1,1),	--业绩评定编号(主键)
	PerformanceTime DateTime,	--考评日期
	UserID int references UserInfo(UserID),	--评定人
	WorkSummary varchar(MAX),	--总结
	UpperGoal varchar(MAX),	--完成度
	CompletionDegree float,	--互评分数
	ExaminationItems Varchar(100),	--下阶段目标
	NextStageObjectives Varchar(100),	--上阶段目标
	PerformanceScore Float,	--最终总分
	comments Varchar(200),	--主管评论
	perstate int	--审核状态
)


--判断AttendanceSheet表(考勤信息表)是否存在
if exists(select * from sysobjects where name = 'AttendanceSheet')
drop table AttendanceSheet
go

--创建AttendanceSheet表(考勤信息表)
create table AttendanceSheet
(
	AttendanceID int primary key identity(1,1),	--考勤编号(主键)
	AttendanceStartTime DateTime,	--考勤时间
	AttendanceType Int,	--考勤状态
	UserID Int references UserInfo(UserID),	--用户编号
	ClockTime DateTime,	--第一次打卡
	ClockOutTime DateTime,	--第二次打卡
	Workinghours int,	--工作小时
	remake Varchar(200),	--备注
	Late int,	--迟到次数
	Absenteeism int check(len(Absenteeism)<=100)	--考勤次数
)
update AttendanceSheet set ClockOutTime =GETDATE(),AttendanceType= where AttendanceStartTime between '2019-10-28' and '2019-10-28 23:59:59' and UserID=1019
select * from AttendanceSheet where AttendanceStartTime = '2019-10-05' and UserID = '1019'
select * from AttendanceSheet where AttendanceStartTime between '2019-10-28' and '2019-10-29' and UserID=1019

update AttendanceSheet set ClockOutTime =GETDATE() where AttendanceStartTime ='2019-10-28' and UserID=1019

select *from UserInfo

insert  AttendanceSheet values('2019-03-28',1,1022,'2019-03-20 08:30','2019-03-20 18:00',8,null,null,null)
insert  AttendanceSheet values('2019-03-20',2,1022,'2019-03-21 09:10','2019-03-20 18:00',8,null,null,null)
insert  AttendanceSheet values('2019-03-20',4,1022,'2019-03-22 09:20','2019-03-20 17:00',8,null,null,null)
insert  AttendanceSheet values('2019-03-2',1,1022,'2019-03-20 09:00','2019-03-20 18:00',8,null,null,null)
insert  AttendanceSheet values('2019-03-3',1,1022,'2019-03-03 09:00','2019-03-03 18:00',8,null,null,null)
insert  AttendanceSheet values('2019-03-4',1,1022,'2019-03-04 09:00','2019-03-04 18:00',8,null,null,null)

insert  AttendanceSheet values('2019-03-5',2,1022,'2019-03-05 10:10','2019-03-05 18:11',8,null,1,null)
insert  AttendanceSheet values('2019-03-5',2,1022,'2019-03-05 09:10','2019-03-05 18:00',8,null,1,null)
insert  AttendanceSheet values('2019-03-6',2,1022,'2019-03-06 09:30','2019-03-06 18:00',8,null,1,null)

insert  AttendanceSheet values('2019-03-07',2,1022,'2019-03-07 09:20','2019-03-07 18:00',8,null,1,null)

insert  AttendanceSheet values('2019-03-25',4,1022,'2019-03-05 09:00','2019-03-05 18:00',8,null,1,null)
insert  AttendanceSheet values('2019-03-28',4,1022,'2019-03-06 09:00','2019-03-06 18:00',8,'155',1,null)



--判断CategoryItems表(字典表)是否存在
if exists(select * from sysobjects where name = 'CategoryItems')
drop table CategoryItems
go

--创建CategoryItems表(字典表)
create table CategoryItems
(
	CID Int primary key identity(1,1),	--编号(主键)
	C_Category Varchar(20),	--表名
	CI_ID int,	--ID
	CI_Name Varchar(20)	--字典名称
)

--判断Leave表(请假表)是否存在
if exists(select * from sysobjects where name = 'Leave')
drop table Leave
go

--创建Leave表(请假表)
create table Leave
(
	LeaveID Int primary key identity(1,1),	--请假编号(主键)
	UserID Int references UserInfo(UserID),	--用户编号
	LeaveState int,	--审批状态
	LeaveTime DateTime,	--请假时间
	LeaveStartTime DateTime,	--请假起始时间
	LeaveEndTime DateTime,	--结束时间
	LeaveHalfDay int,	--时间段（上午或下午）
	LeaveDays Int,	--请假天数
	LeaveReason Varchar(250),	--请假原因
	ApproverID Int,	--审批编号
	ApprovalTime DateTime,	--审批时间
	ApproverReason Varchar(250)	--审批备注
)


--判断Notice表(公告表)是否存在
if exists(select * from sysobjects where name = 'Notice')
drop table Notice
go

--创建Notice表(公告表)
create table Notice
(
	NoticeID Int primary key,	--公告编号(主键)
	NoticeType int,	--公告类型
	NoticeTitle Varchar(250),	--公告标题
	NoticeContent Varchar(500),	--公告内容
	UserID int references UserInfo(UserID),	--发布人
	NoticeStateTime dateTime,	--通知起始时间
	NoticeEndTime Datetime,	--结束时间
	NoticeState Int --通知紧急状态（可参考字典表）
)

--判断Overtime表(加班申请表)是否存在
if exists(select * from sysobjects where name = 'Overtime')
drop table Overtime
go

--创建Overtime表(加班申请表)
create table Overtime
(
	OvertimeID  Int,	--加班编号(主键)
	OvertimeStateTime Datetime,	--加班起始时间
	OvertimeEndTime Datetime,	--加班结束时间
	OvertimeDuration Int,	--申请状态
	UserID Int references UserInfo(UserID),	--用户编号
	ApplyTime Datetime,	--审批时间
	OvertimeState Int,	--审批进度
	ApproverReason varchar(200)	--审批内容
)

--判断PayRise表(工资增长表)是否存在
if exists(select * from sysobjects where name = 'PayRise')
drop table PayRise
go

--创建PayRise表(工资增长表)
create table PayRise
(
	PayRiseID Int primary key identity(1,1),	--工资增长编号(主键)
	UserID int references UserInfo(UserID),	--用户编号
	PayRiseMoney Money,	--工资收入
	Reason Varchar(MAX),	--原因
	ApplicationTime Datetime,	--申请时间
	ApprovalContent varchar(500),	--批准内容
	ApprovalState int,	--批准状态
	ApprovalTime Datetime	--批准时间
)

--判断PaySlipID表(工资表)是否存在
if exists(select * from sysobjects where name = 'PaySlipID')
drop table PaySlipID
go

--创建PaySlipID表(工资表)
create table PaySlipID
(
	id Int primary key,	--编号(主键)
	UserID int references UserInfo(UserID),	--用户编号
	BasicSalary Money,	--基本工资
	AttendanceBonus money,	--考勤奖金
	Fine Money,	--罚款
	SalaryTime Datetime,	--发工资时间
	SalarySum money	--最后工资
)

--判断PaySlip表(工资单表)是否存在
if exists(select * from sysobjects where name = 'PaySlip')
drop table PaySlip
go

--创建PaySlip表(工资单表)
create table PaySlip
(
	PaySlipID Int primary key,	--工资编号(主键)
	UserID int references UserInfo(UserID),	--员工编号
	Prize Money,	--全勤奖金
	LeaveMoney Money,	--请假扣钱
	OvertimeMoney Money,	--加班奖金3
	LateMoney Money,	--迟到
	AdvanceMoney Money,	--早退
	Absence Money,	--缺勤
	fine Money,	--罚款
	Sa_Bonus Money,	--业绩奖金
	Sa_Time Datetime,	--工资结算时间
	Sa_TotalSalary Money	--合计工资
)

--判断SystemLog表(日志表)是否存在
if exists(select * from sysobjects where name = 'SystemLog')
drop table SystemLog
go

--创建SystemLog表(日志表)
create table SystemLog
(
	LogID Int primary key,	--登陆编号(主键)
	userID int references UserInfo(UserID),	--用户编号
	LogTime Datetime,	--登陆时间
	LogOperation Varchar(500)	--操作内容
)

--审批表
create table OvertineCheck
(
	ApproverID int primary key identity (1,1),	--审批ID
	ApproverType int,	--申请类别
	userID int references UserInfo(UserID),	--用户ID
	LeaveID int,	--请假ID
	ManagerAudit int,	--总经理审核状态
	ManagerAuditRemarks varchar(250),	
	GeneralManagerAudit int,	--人事经理审核状态
	GeneralManagerAuditRemarks varchar(250),
	DepartmentalAudit int,	--部门经理审核状态
	DepartmentalAuditRemarks varchar(250)
)

select * from (select ROW_NUMBER() over(order by Leave.LeaveID) rowindex,Leave.*,UserInfo.UserName,UserInfo.UserTel,Department.DepartmentName from Leave inner join UserInfo on Leave.UserID = UserInfo.UserID inner join Department on UserInfo.DepartmentID=Department.DepartmentID inner join OvertineCheck on Leave.LeaveID = OvertineCheck.LeaveID where 1 = 1  and (DepartmentalAudit = 1 or DepartmentalAudit = 0) and GeneralManagerAudit = 3 and RoleID != 4) a  where rowindex between1 and 5



--insert into OvertineCheck(ApproverType,userID,ManagerAudit,ManagerAuditRemarks,GeneralManagerAudit,GeneralManagerAuditRemarks,DepartmentalAudit,DepartmentalAuditRemarks) values(2,1)
--select @@identity


insert into Department values('人事部','',1)
insert into Department values('财务部','',1)
insert into Department values('行政部','',1)
insert into Department values('研发部','',1)
insert into Department values('销售部','',1)
insert into Department values('公共部','',1)
insert into Department values('待议部','',1)





--部门表分页
select top (5) * from Department where DepartmentID not in (select top ((0)*5) DepartmentID from Department)
select * from Department
select COUNT(DepartmentID) from Department

select top (5) * from Department where DepartmentID not in (select top (5*(1-1)) DepartmentID from Department)  

select * from (select ROW_NUMBER() over(order by DepartmentId) rowindex,* from Department ) c where rowindex between 1 and 2

select * from UserInfo

update Department set isDel = '0',DepartmentName='' where DepartmentID in (1,2)

select * from (select ROW_NUMBER() over(order by UserID) rowindex, UserInfo.* , Department.DepartmentName from UserInfo inner join Department on UserInfo.DepartmentID=Department.DepartmentID) c where rowindex between 1 and 2

select distinct DepartmentID,DepartmentName from Department

select * from (select ROW_NUMBER() over(order by UserID) rowindex,UserInfo.* , Department.DepartmentName from UserInfo inner join Department on UserInfo.DepartmentID=Department.DepartmentID  where 1 = 1  and UserName like '%a%' ) c where rowindex between 1 and 5

select * from Role

insert into Role values(1,'普通员工','')
insert into Role values(2,'部门经理','')
insert into Role values(3,'人事助理','')
insert into Role values(4,'人事经理','')
insert into Role values(5,'总经理','')


insert into UserInfo(DepartmentID,UserName,LoginName,LoginPwd,RoleID) values(70,'a','admin' , '123456',5)
insert into UserInfo(DepartmentID,UserName,LoginName,LoginPwd,RoleID) values(20,'b','admin1' , '123456',2)
insert into UserInfo(DepartmentID,UserName,LoginName,LoginPwd,RoleID) values(20,'c','admin2' , '123456',1)
insert into UserInfo(DepartmentID,UserName,LoginName,LoginPwd,RoleID) values(20,'d','admin3' , '123456',1)

delete from UserInfo where UserID=0

insert into CategoryItems values('UserInfo',0,'不可登陆')
insert into CategoryItems values('UserInfo',1,'可登陆')

insert into CategoryItems values('LeaveState',1,'同意')
insert into CategoryItems values('LeaveState',2,'驳回')
insert into CategoryItems values('LeaveState',3,'审批中')
insert into CategoryItems values('LeaveHalfDay',1,'全天')
insert into CategoryItems values('LeaveHalfDay',2,'上午')
insert into CategoryItems values('LeaveHalfDay',3,'下午')
insert into CategoryItems values('ApproverType',1,'加班')
insert into CategoryItems values('ApproverType',2,'请假')
insert into CategoryItems values('ApproverType',3,'加薪')
insert into CategoryItems values('Audit',1,'同意')
insert into CategoryItems values('Audit',2,'驳回')
insert into CategoryItems values('Audit',3,'审批中')

insert into CategoryItems values('Attendance',1,'正常')
insert into CategoryItems values('Attendance',2,'迟到')
insert into CategoryItems values('Attendance',3,'早退')
insert into CategoryItems values('Attendance',4,'缺勤')
insert into CategoryItems values('Attendance',5,'请假')
insert into CategoryItems values('Attendance',6,'迟到/早退')
insert into CategoryItems values('Attendance',7,'未打卡')



select * from CategoryItems

select Leave.*,UserInfo.UserName from Leave inner join UserInfo on Leave.UserID = UserInfo.UserID inner join (select * from CategoryItems where C_Category ='LeaveState') a on Leave.LeaveState = a.CI_ID

 select * from (select ROW_NUMBER() over(order by LeaveID) rowindex,Leave.*,UserInfo.UserName,a.CI_Name from Leave inner join UserInfo on Leave.UserID = UserInfo.UserID inner join (select * from CategoryItems where C_Category ='LeaveState') a on Leave.LeaveState = a.CI_ID) b  where rowindex between 0 and 5 
 
 insert into Leave(UserID,LeaveState) values(1001,1)
 
 select * from UserInfo
 
 select COUNT(LeaveID) from Leave
 
select CI_ID,CI_Name from CategoryItems where C_Category = 'LeaveHalfDay'

select * from Leave where UserID=1017

select * from (select ROW_NUMBER() over(order by LeaveID) rowindex,Leave.*,UserInfo.UserName,UserInfo.DepartmentID,UserTel,a.CI_Name from Leave inner join UserInfo on Leave.UserID = UserInfo.UserID inner join (select * from CategoryItems where C_Category ='LeaveState') a on Leave.LeaveState = a.CI_ID) b  where rowindex between 1 and 5 and 1=1 and UserID = 10

select * from (select ROW_NUMBER() over(order by LeaveID) rowindex,Leave.*,UserInfo.UserName,UserInfo.DepartmentID,UserTel,a.CI_Name from Leave inner join UserInfo on Leave.UserID = UserInfo.UserID inner join (select * from CategoryItems where C_Category ='LeaveState') a on Leave.LeaveState = a.CI_ID) b  where rowindex between 1 and 5 and 1=1  and DepartmentID = 10

insert into OvertineCheck(ApproverType,userID,ManagerAudit,ManagerAuditRemarks,GeneralManagerAudit,GeneralManagerAuditRemarks,DepartmentalAudit,DepartmentalAuditRemarks) values('',1017,3,'',3,'','','')

select * from OvertineCheck

select * from (select ROW_NUMBER() over(order by LeaveID) rowindex,Leave.*,UserInfo.UserName,UserInfo.DepartmentID,UserTel,a.CI_Name from Leave inner join UserInfo on Leave.UserID = UserInfo.UserID inner join (select * from CategoryItems where C_Category ='LeaveState') a on Leave.LeaveState = a.CI_ID) b 


select ROW_NUMBER() over(order by LeaveID) rowindex,Leave.*,UserInfo.UserName,UserInfo.DepartmentID,UserTel,a.CI_Name from Leave inner join UserInfo on Leave.UserID = UserInfo.UserID where UserID = 1017) inner join (select * from CategoryItems where C_Category ='LeaveState') a on Leave.LeaveState = a.CI_ID



select * from Leave

delete from OvertineCheck

select * from ( select ROW_NUMBER() over(order by LeaveID) rowindex ,* from (select Leave.*,UserInfo.UserName,UserInfo.UserTel from Leave inner join UserInfo on Leave.UserID = UserInfo.UserID where 1=1) a inner join (select * from CategoryItems where C_Category ='LeaveState') b on a.LeaveState = b.CI_ID) c inner join OvertineCheck on c.LeaveID = OvertineCheck.LeaveID 

select * from OvertineCheck

--select * from ( select ROW_NUMBER() over(order by LeaveID) rowindex ,* from (select Leave.*,UserInfo.UserName,UserInfo.UserTel from Leave) inner join UserInfo on Leave.UserID = UserInfo.UserID where 1=1 ) a  where a.rowindex between 1 and  1

--select * from (select ROW_NUMBER() over(order by Leave.LeaveID) rowindex,Leave.*,UserInfo.UserName,UserInfo.UserTel,Department.DepartmentName from Leave inner join UserInfo on Leave.UserID = UserInfo.UserID inner join Department on UserInfo.DepartmentID=Department.DepartmentID inner join OvertineCheck on Leave.LeaveID = OvertineCheck.LeaveID where 1 = 1) a where rowindex between


--select * from Leave inner join UserInfo on Leave.UserID = UserInfo.UserID inner join OvertineCheck on Leave.LeaveID = OvertineCheck.LeaveID inner join Department on UserInfo.DepartmentID = Department.DepartmentID
 
select * from OvertineCheck where LeaveID =51





select * from ( select ROW_NUMBER() over(order by LeaveID desc) rowindex ,* from (select Leave.*,UserInfo.UserName,UserInfo.UserTel from Leave inner join UserInfo on Leave.UserID = UserInfo.UserID where 1=1 ) a inner join (select * from CategoryItems where C_Category ='LeaveState') b on a.LeaveState = b.CI_ID) c inner join OvertineCheck on c.LeaveID = OvertineCheck.LeaveID  where rowindex between 1 and 5 order by c.LeaveID desc


select * from (select ROW_NUMBER() over(order by Leave.LeaveTime desc) rowindex,Leave.*,UserInfo.UserName,UserInfo.UserTel,Department.DepartmentName from Leave inner join UserInfo on Leave.UserID = UserInfo.UserID inner join Department on UserInfo.DepartmentID=Department.DepartmentID where 1 = 1 ) a