--ʹ��master���ݿ�
use master
go

--�ж�HRCMRDB���ݿ��Ƿ����
if exists(select * from sysdatabases where name ='HRCMRDB')
drop database HRCMRDB
go

--����HRCMRDB���ݿ�
create database HRCMRDB
go

--ʹ��HRCMRDB���ݿ�
use HRCMRDB
go


--�ж�Department��(���ű�)�Ƿ����
if exists(select * from sysobjects where name = 'Department')
drop table UserInfo
go

--����Department��(���ű�)
create table Department
(
	DepartmentID int primary key identity(10,10),	--���ű��(����)
	DepartmentName varchar(50),	--��������
	DepartmentRemarks varchar(200), --��ע
	isDel int
)


--�ж�Role��(��ɫ��)�Ƿ����
if exists(select * from sysobjects where name = 'Role')
drop table Role
go

--����Role��(��ɫ��)
create table Role
(
	RoleID Int primary key,	--��ɫ���(����)
	RoleName varchar(50),	--��ɫ����
	RoleNumber varchar(200)	--��ɫȨ�ްٷֱ�
)

--�ж�UserInfo��(�û���)�Ƿ����
if exists(select * from sysobjects where name = 'UserInfo')
drop table UserInfo
go

--����UserInfo��(�û���)
create table UserInfo
(
	UserID Int primary key identity(1001,1),	--���(����)
	DepartmentID int references Department(DepartmentID),	--���ű��
	RoleID Int references Role(RoleID),	--��ɫ��ţ�1.�ܾ��� 2.���¾��� 3.�������� 4.���ž��� 5.Ա����
	UserNumber Varchar(50),	--�û����
	LoginName Varchar(50),	--��½��
	LoginPwd Varchar(50),	--����
	UserName Varchar(50),	--��ʵ����
	UserAge int,	--����
	UserSex int,	--�Ա� ��1.��  0.Ů��
	UserTel varchar(11),	--�绰
	UserAddress Varchar(100),	--��ͥ��ַ
	UserIphone varchar(200),	--�ֻ�
	UserRemarks Varchar(200),	--��ע
	UserStatr int,	--�Ƿ���ã�0.���ɵ�½ 1.�ɵ�½��
	EntryTime Datetime,	--����½ʱ��
	DimissionTime Datetime,	--��ְʱ��
	BasePay money	--н��
)


--�ж�Assessment��(ҵ��������)�Ƿ����
if exists(select * from sysobjects where name = 'Assessment')
drop table Assessment
go

--����Assessment��(ҵ��������)
create table Assessment
(
	AssessmentID Int primary key identity(1,1),	--ҵ���������(����)
	PerformanceTime DateTime,	--��������
	UserID int references UserInfo(UserID),	--������
	WorkSummary varchar(MAX),	--�ܽ�
	UpperGoal varchar(MAX),	--��ɶ�
	CompletionDegree float,	--��������
	ExaminationItems Varchar(100),	--�½׶�Ŀ��
	NextStageObjectives Varchar(100),	--�Ͻ׶�Ŀ��
	PerformanceScore Float,	--�����ܷ�
	comments Varchar(200),	--��������
	perstate int	--���״̬
)


--�ж�AttendanceSheet��(������Ϣ��)�Ƿ����
if exists(select * from sysobjects where name = 'AttendanceSheet')
drop table AttendanceSheet
go

--����AttendanceSheet��(������Ϣ��)
create table AttendanceSheet
(
	AttendanceID int primary key identity(1,1),	--���ڱ��(����)
	AttendanceStartTime DateTime,	--����ʱ��
	AttendanceType Int,	--����״̬
	UserID Int references UserInfo(UserID),	--�û����
	ClockTime DateTime,	--��һ�δ�
	ClockOutTime DateTime,	--�ڶ��δ�
	Workinghours int,	--����Сʱ
	remake Varchar(200),	--��ע
	Late int,	--�ٵ�����
	Absenteeism int check(len(Absenteeism)<=100)	--���ڴ���
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



--�ж�CategoryItems��(�ֵ��)�Ƿ����
if exists(select * from sysobjects where name = 'CategoryItems')
drop table CategoryItems
go

--����CategoryItems��(�ֵ��)
create table CategoryItems
(
	CID Int primary key identity(1,1),	--���(����)
	C_Category Varchar(20),	--����
	CI_ID int,	--ID
	CI_Name Varchar(20)	--�ֵ�����
)

--�ж�Leave��(��ٱ�)�Ƿ����
if exists(select * from sysobjects where name = 'Leave')
drop table Leave
go

--����Leave��(��ٱ�)
create table Leave
(
	LeaveID Int primary key identity(1,1),	--��ٱ��(����)
	UserID Int references UserInfo(UserID),	--�û����
	LeaveState int,	--����״̬
	LeaveTime DateTime,	--���ʱ��
	LeaveStartTime DateTime,	--�����ʼʱ��
	LeaveEndTime DateTime,	--����ʱ��
	LeaveHalfDay int,	--ʱ��Σ���������磩
	LeaveDays Int,	--�������
	LeaveReason Varchar(250),	--���ԭ��
	ApproverID Int,	--�������
	ApprovalTime DateTime,	--����ʱ��
	ApproverReason Varchar(250)	--������ע
)


--�ж�Notice��(�����)�Ƿ����
if exists(select * from sysobjects where name = 'Notice')
drop table Notice
go

--����Notice��(�����)
create table Notice
(
	NoticeID Int primary key,	--������(����)
	NoticeType int,	--��������
	NoticeTitle Varchar(250),	--�������
	NoticeContent Varchar(500),	--��������
	UserID int references UserInfo(UserID),	--������
	NoticeStateTime dateTime,	--֪ͨ��ʼʱ��
	NoticeEndTime Datetime,	--����ʱ��
	NoticeState Int --֪ͨ����״̬���ɲο��ֵ��
)

--�ж�Overtime��(�Ӱ������)�Ƿ����
if exists(select * from sysobjects where name = 'Overtime')
drop table Overtime
go

--����Overtime��(�Ӱ������)
create table Overtime
(
	OvertimeID  Int,	--�Ӱ���(����)
	OvertimeStateTime Datetime,	--�Ӱ���ʼʱ��
	OvertimeEndTime Datetime,	--�Ӱ����ʱ��
	OvertimeDuration Int,	--����״̬
	UserID Int references UserInfo(UserID),	--�û����
	ApplyTime Datetime,	--����ʱ��
	OvertimeState Int,	--��������
	ApproverReason varchar(200)	--��������
)

--�ж�PayRise��(����������)�Ƿ����
if exists(select * from sysobjects where name = 'PayRise')
drop table PayRise
go

--����PayRise��(����������)
create table PayRise
(
	PayRiseID Int primary key identity(1,1),	--�����������(����)
	UserID int references UserInfo(UserID),	--�û����
	PayRiseMoney Money,	--��������
	Reason Varchar(MAX),	--ԭ��
	ApplicationTime Datetime,	--����ʱ��
	ApprovalContent varchar(500),	--��׼����
	ApprovalState int,	--��׼״̬
	ApprovalTime Datetime	--��׼ʱ��
)

--�ж�PaySlipID��(���ʱ�)�Ƿ����
if exists(select * from sysobjects where name = 'PaySlipID')
drop table PaySlipID
go

--����PaySlipID��(���ʱ�)
create table PaySlipID
(
	id Int primary key,	--���(����)
	UserID int references UserInfo(UserID),	--�û����
	BasicSalary Money,	--��������
	AttendanceBonus money,	--���ڽ���
	Fine Money,	--����
	SalaryTime Datetime,	--������ʱ��
	SalarySum money	--�����
)

--�ж�PaySlip��(���ʵ���)�Ƿ����
if exists(select * from sysobjects where name = 'PaySlip')
drop table PaySlip
go

--����PaySlip��(���ʵ���)
create table PaySlip
(
	PaySlipID Int primary key,	--���ʱ��(����)
	UserID int references UserInfo(UserID),	--Ա�����
	Prize Money,	--ȫ�ڽ���
	LeaveMoney Money,	--��ٿ�Ǯ
	OvertimeMoney Money,	--�Ӱཱ��3
	LateMoney Money,	--�ٵ�
	AdvanceMoney Money,	--����
	Absence Money,	--ȱ��
	fine Money,	--����
	Sa_Bonus Money,	--ҵ������
	Sa_Time Datetime,	--���ʽ���ʱ��
	Sa_TotalSalary Money	--�ϼƹ���
)

--�ж�SystemLog��(��־��)�Ƿ����
if exists(select * from sysobjects where name = 'SystemLog')
drop table SystemLog
go

--����SystemLog��(��־��)
create table SystemLog
(
	LogID Int primary key,	--��½���(����)
	userID int references UserInfo(UserID),	--�û����
	LogTime Datetime,	--��½ʱ��
	LogOperation Varchar(500)	--��������
)

--������
create table OvertineCheck
(
	ApproverID int primary key identity (1,1),	--����ID
	ApproverType int,	--�������
	userID int references UserInfo(UserID),	--�û�ID
	LeaveID int,	--���ID
	ManagerAudit int,	--�ܾ������״̬
	ManagerAuditRemarks varchar(250),	
	GeneralManagerAudit int,	--���¾������״̬
	GeneralManagerAuditRemarks varchar(250),
	DepartmentalAudit int,	--���ž������״̬
	DepartmentalAuditRemarks varchar(250)
)

select * from (select ROW_NUMBER() over(order by Leave.LeaveID) rowindex,Leave.*,UserInfo.UserName,UserInfo.UserTel,Department.DepartmentName from Leave inner join UserInfo on Leave.UserID = UserInfo.UserID inner join Department on UserInfo.DepartmentID=Department.DepartmentID inner join OvertineCheck on Leave.LeaveID = OvertineCheck.LeaveID where 1 = 1  and (DepartmentalAudit = 1 or DepartmentalAudit = 0) and GeneralManagerAudit = 3 and RoleID != 4) a  where rowindex between1 and 5



--insert into OvertineCheck(ApproverType,userID,ManagerAudit,ManagerAuditRemarks,GeneralManagerAudit,GeneralManagerAuditRemarks,DepartmentalAudit,DepartmentalAuditRemarks) values(2,1)
--select @@identity


insert into Department values('���²�','',1)
insert into Department values('����','',1)
insert into Department values('������','',1)
insert into Department values('�з���','',1)
insert into Department values('���۲�','',1)
insert into Department values('������','',1)
insert into Department values('���鲿','',1)





--���ű��ҳ
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

insert into Role values(1,'��ͨԱ��','')
insert into Role values(2,'���ž���','')
insert into Role values(3,'��������','')
insert into Role values(4,'���¾���','')
insert into Role values(5,'�ܾ���','')


insert into UserInfo(DepartmentID,UserName,LoginName,LoginPwd,RoleID) values(70,'a','admin' , '123456',5)
insert into UserInfo(DepartmentID,UserName,LoginName,LoginPwd,RoleID) values(20,'b','admin1' , '123456',2)
insert into UserInfo(DepartmentID,UserName,LoginName,LoginPwd,RoleID) values(20,'c','admin2' , '123456',1)
insert into UserInfo(DepartmentID,UserName,LoginName,LoginPwd,RoleID) values(20,'d','admin3' , '123456',1)

delete from UserInfo where UserID=0

insert into CategoryItems values('UserInfo',0,'���ɵ�½')
insert into CategoryItems values('UserInfo',1,'�ɵ�½')

insert into CategoryItems values('LeaveState',1,'ͬ��')
insert into CategoryItems values('LeaveState',2,'����')
insert into CategoryItems values('LeaveState',3,'������')
insert into CategoryItems values('LeaveHalfDay',1,'ȫ��')
insert into CategoryItems values('LeaveHalfDay',2,'����')
insert into CategoryItems values('LeaveHalfDay',3,'����')
insert into CategoryItems values('ApproverType',1,'�Ӱ�')
insert into CategoryItems values('ApproverType',2,'���')
insert into CategoryItems values('ApproverType',3,'��н')
insert into CategoryItems values('Audit',1,'ͬ��')
insert into CategoryItems values('Audit',2,'����')
insert into CategoryItems values('Audit',3,'������')

insert into CategoryItems values('Attendance',1,'����')
insert into CategoryItems values('Attendance',2,'�ٵ�')
insert into CategoryItems values('Attendance',3,'����')
insert into CategoryItems values('Attendance',4,'ȱ��')
insert into CategoryItems values('Attendance',5,'���')
insert into CategoryItems values('Attendance',6,'�ٵ�/����')
insert into CategoryItems values('Attendance',7,'δ��')



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