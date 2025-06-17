
/*SQL Project Name :BookShop Management System
Trainee Name : Sarah Sultana   
Trainee ID : 1285803 
Batch ID : CS/PNTL-A/62/01 
*/
/*
=> SECTION 01: Create a Database 
=> SECTION 02: Create Tables with column definition related to the project
=> SECTION 03: CREATE CLUSTERED AND NONCLUSTERED INDEX
=> SECTION 04: ALTER, DROP AND MODIFY TABLES & COLUMNS
=> SECTION 05: CREATE SEQUENCE & ALTER SEQUENCE
=> SECTION 06: CREATE A VIEW & ALTER VIEW
=> SECTION 07: CREATE STORED PROCEDURE & ALTER STORED PROCEDURE
=> SECTION 08: CREATE FUNCTION(SCALAR, SIMPLE TABLE VALUED, MULTISTATEMENT TABLE VALUED) & ALTER FUNCTION
=> SECTION 09: CREATE TRIGGER (FOR/AFTER TRIGGER)
=> SECTION 10: CREATE TRIGGER (INSTEAD OF TRIGGER)
*/
			/* SECTION 01:
						 Create a Database */
create database BookShop
on
(
	name= 'Bookshop_Data',
	filename='G:\New folder (7)\New folder\MSSQL16.MSSQLSERVER\MSSQL\DATA\Bookshop_Data.mdf',
	size= 2mb,
	maxsize=10mb,
	filegrowth=1%
)
log on 
(
	name= 'Bookshop_Log',
	filename='G:\New folder (7)\New folder\MSSQL16.MSSQLSERVER\MSSQL\DATA\Bookshop_Log.ldf',
	size= 2mb,
	maxsize=10mb,
	filegrowth=2kb
)
go


use BookShop
go

		  /* SECTION 02: 
						Create Tables with column definition */
create table Genre --1
(
	genreId int Primary Key,
	genreName varchar(20) not null
)
go


create table Author --2
(
	authorId int primary key,
	authorName nvarchar(40) not null,
	[address] varchar(30) not null,
	country char(10) null,
	contact nvarchar(20) not null 
)
go


create table Employee --3
(
	employeeId int Primary key,
	employeeName nvarchar(30) not null,
	[address] varchar(20),
	contact varchar(20) not null
)
go 
create table Customer --4
(
	customerId int Primary key,
	customerName nvarchar(30) not null,
	[address] varchar(20),
	contact varchar(20) not null,
	gender char(10),
	emailAddress nvarchar(30)
)
go 



create table BookBindingType --5
(
	Id tinyint primary key,
	bindingType char(3) not null
)
go
create table Publishers --6
(
	publisherID int primary key,
	publicationName nvarchar(40) not null,
	[address] nchar(20) not null,
	contact varchar(20) not null,
	country char(10) not null
)
go
create table [Language] --7
(
	id int primary key,
	languageName nvarchar(20) not null
)
go
/*ALTER TABLE [LANGUAGE]
DROP CONSTRAINT [PRIMARY KEY]
*/
create table Book-- 8
(
	BookId int primary key,
	ISBN bigint not null,
	bookTitle nvarchar(50) not null,
	listedPrice money not null,
	edition smallint not null,
	pages tinyint,
	origin char(20),
	authorId int references Author(authorId),
	translator nvarchar(30),
	genreId int  references Genre(genreId),
	publisherID int references Publishers(publisherID),
	BookBindingType tinyint references BookBindingType(Id),
	[languageId] int references [Language](id),
	available int default 0
)
go
create table Feedback --9
(
	feedbackId int primary key,
	customerId int references Customer(customerId),
	bookId int references Book(BookId),
	feedback nvarchar(100)not null,
	[date] smalldatetime 
)
go
/*trigger korte book table er available field + stock table er quantity field*/

--TABLE WITH CHECK KEY CONSTRAINT
create table Stock -- 10 
(
	stockid int primary key,
	stockName varchar(10) not null,
	stockDate datetime not null check (stockDate<=getdate()),
	bookId int references Book(BookId),
	quantity int default 0,
	unitPrice money not null,
	vat float not null
)
go
select * from Stock
exec sp_help 'stock'

go
--TABLE WITH FOREIGN KEY CONSTRAINT
create table OrderDetails   -- 11
(
	orderDetailsId int primary key,
	bookId int references Book(BookId),
	orderDate date not null,
	quantity int not null,
	discount float not null,
	totalPrice money not null,
	employeeId int references Employee(employeeId),
	customerId int references Customer(customerId)
)
go

--TABLE WITH FOREIGN KEY CONSTRAINT
Create table [Order] --12
(
	orderId int primary key,
	orderDetailsId int references OrderDetails(orderDetailsId),
	stockId int references Stock(stockid)
)
go
select * from Genre
select * from Author
select * from Employee
select * from Customer
select * from BookBindingType
select * from Publishers
select * from [Language]
select * from Book
select * from Feedback
select * from Stock
select * from OrderDetails
select * from [Order]
GO

		/*CREATE SCHEMA*/ 
CREATE SCHEMA ABC
GO

		/*SECTION 03: 
					CREATE CLUSTERED AND NONCLUSTERED INDEX */
-------------------/////////------INDEX(NON-CLUSTERED)-----\\\\\\\\\\------------
create nonclustered index ix_Genre 
on  Genre 
(
	genreId
)
go

-------------------/////////------INDEX(CLUSTERED)-----\\\\\\\\\\------------
create index ix_order 
on [Order]
(
	orderId
)
go
--exec sp_help 'order'

		/* SECTION 04: 
					ALTER, DROP AND MODIFY TABLES & COLUMNS*/

--ALTER COLUMN NULLABLE
alter table author 
alter column 
contact nvarchar(20) null
go
alter table book
alter column pages int
go
--ALTER COLUMN NAME
sp_rename 'Book.BookBindingType','binding', 'column'

--DROP COLUMN
ALTER TABLE Book
DROP COLUMN available 
GO

--ADD COLUMN WITH DEFAULT CONSTRAINT
ALTER TABLE Book
ADD [availability] int default 0
GO
		/*SECTION 05: 
					CREATE A VIEW & ALTER VIEW*/

CREATE VIEW vw_bookgenre
as
select b.bookTitle,g.genreName from Book b 
join Genre g on b.genreId=g.genreId
go



--ALTER
ALTER VIEW vw_bookgenre
as
select b.bookTitle,a.authorName,g.genreName from Book b 
join Genre g on b.genreId=g.genreId
join Author a on b.authorId=a.authorId

go

/*CREATE A VIEW WITH ENCRYPTION*/
create view vw_booksWithHardBinding 
with encryption
as
select b.BookId,b.bookTitle,bb.bindingType from BookBindingType bb
join Book b on b.[binding]=bb.bindingType
where bb.Id=1
go


/*CREATE A VIEW WITH SCHEMABINDING*/
create view vw_booksWithPBBinding 
with SCHEMABINDING
as
select b.BookId,b.bookTitle,bb.bindingType from DBO.BookBindingType bb
join DBO.Book b on b.[binding]=bb.bindingType
where bb.Id=2
go

--DROP VIEW
DROP VIEW vw_booksWithPBBinding
go
/*SECTION 06  ==============================
							 CREATE SEQUENCE*/
create sequence seq_1
as int 
start with 1
increment by 1
maxvalue 200
minvalue 0
go
/*Alter Sequence*/
alter sequence seq_1 
maxvalue 300
minvalue 1
go
/*Drop sequence*/
drop sequence seq_1
go


/*==============================  SECTION 07  ==============================
							 STORED PROCEDURE
==========================================================================*/
--with input parameter
--insert
create proc sp_insert_author @aId int, @aName nvarchar(40), @aAddress varchar(30)
as 
begin
insert into Author (authorId,authorName,[address]) values (@aId,@aName,@aAddress)
end
go
--update 
create proc sp_update_Author @address varchar(30), @id int
as 
begin
update Author set address=@address
where authorId=@id
end
go
exec sp_update_Author 
--delete
create proc sp_delete_language @lId int
as
begin
delete from Language where id=@lId
end
go

--with output parameter
alter procedure sp_insert_publisers  
								@pName nvarchar(40), 
								@pAddress nchar(20), 
								@contact varchar(20), 
								@country char(10),
								@pId int output
as
begin 
	insert into Publishers(publicationName,address,contact,country,publisherID) 
					values (@pName,@pAddress,@contact,@country,@pId)
	select @pId=IDENT_CURRENT('Publishers')  
end
go

SELECT * FROM Author
use BookShop
go
--Raiserror
CREATE PROCEDURE spRaisError
AS
BEGIN
 BEGIN TRY
	DELETE FROM OrderDetails
 END TRY
 BEGIN CATCH
	DECLARE @Error VARCHAR(200) = 'Error' + CONVERT(varchar, ERROR_NUMBER(), 1) + ' : ' + ERROR_MESSAGE()
	RAISERROR(@Error, 1, 1)
 END CATCH
END
GO
 


/*SECTION 08  ==============================
								 FUNCTION*/
--	CREATE USER DEFINED FUNCTION
--scalar function

create function fn_order_total(@year int, @month int)
returns money
as
begin
declare @totalsales money
select @totalsales= sum((quantity*totalPrice)-discount) from OrderDetails
where year(orderDate)=@year and month(orderDate)=@month
return @totalsales
end
go

--inline table valued function
create function fn_check_stock(@stockdate datetime)
returns table 
as 
return 
(select stockid,bookId from Stock
where stockDate<datediff(DAY,@stockdate,10))
go
--multistatement table function
create function fn_latestOrders()
returns table
as
return
(
	select top 5 orderDetailsId,bookId from OrderDetails
	where orderDate<getdate()
	order by orderDetailsId desc 
)
go
 /*SECTION 09  ==============================
							FOR/AFTER TRIGGER*/
create trigger tr_in_quantity_fromStock 
on stock
after insert
as 
begin
	declare @BId int, @av int
	select 
	@BId=BookId,
	@av=inserted.quantity 
	from inserted
	update Book 
	set availability=availability+@av 
	where BookId=@BId
	print 'Stock Updated'
end
go
--to check if this is only for insertion
create trigger tr_check_for_insert 
on stock
after insert 
as
begin
	declare @BId int, 
			@av int
	IF (EXISTS(SELECT * FROM INSERTED) AND NOT EXISTS(SELECT * FROM DELETED))
	begin
		select 
				@BId=BookId,
				@av=inserted.quantity 
				from inserted
				update Book 
				set availability=availability+@av 
				where BookId=@BId
				print 'Stock Updated'
	end
	else 
	rollback transaction
end
go
use BookShop
go
--update not possible
create trigger tr_del_restriction
on [order] 
after delete
as
begin
	print 'NO DELETE APPLICABLE'
	ROLLBACK TRANSACTION
end
go