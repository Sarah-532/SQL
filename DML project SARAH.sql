--DML part insert
exec sp_insert_author 1,'Bivutivushan Bandapadhay','West Bengal'
go 

--dml part update
exec sp_update_Author 'North 24 Paraganas, West Bengal', 1 
go 
--dml part delete
exec sp_delete_language 10 
--dml part raiserror sproc
exec spRaisError
--dml part udf
select dbo.fn_order_total(2020,3)
select dbo.fn_order_total(2020,02) as 'Total Order'
--dml part udf
select * from fn_check_stock('2020-03-21 10:00')
--insert test for trigger
select * from Book
select * from Stock
insert into Stock values (1,'Stock 1','2020-02-01',2, 50,200.00,.15)
go
--insert data using stor proc with output param
declare @output int
exec sp_insert_publisers 'Ananda Publishers','Kolkata', '40890909', 'India',2
select @output as 'ID'
go--id null dekhay keno
use BookShop
go


insert into genre (genreId,genreName) values (1,'Novel'),(2,'Non-Fiction'),(3,'Science Fiction'),(4,'Drama')
go
insert into Genre values(5,'Children"s Lit'),(6,'Translation')

insert into Author(authorId,authorName,address,country) 
values (2,'Samaresh Majumder','Jalpaiguri','India'),
	   (3,'Sunil Gangapadhay','West Bengal','India'),
	   (4,'Albert Camus ','Drean','Algeria'), 
	   (5,'Ahmed Safa ','Chattogram','Bangladesh'),
	   (6,'Shirshendu Mukhopadhay ','Mymensingh,British India','India'),
	   (7,'Obayed Haq','Kumilla','Bangladesh')
go
insert into Employee values (1,'Nayeem Islam','Mirpur, Dhaka', '01798456123'),
							(2,'Tamanna Khatun','Kazipara, Mirpur', '01798474823')
go
insert into Customer values (1,'Abdullah al Rashed','Gaibandha', '0175423681','Male', 'abrashed@gmail.com')
insert into Customer values (2,'Ruman Khan','Pabna', '0195423641','Male', 'khanruman41@gmail.com')
go
insert into [Language] values (1,'Bengali'),(2,'French'),(3,'English')
go
insert into Publishers (publisherID,publicationName,address,contact,country) 
			values	(3,'Bayanno("52)','38/3 Banglabazar, Dhaka', '01973389068', 'Bangladesh'),
					(4,'Hawladar Publication','38/2Banglabazar, Dhaka','01726956104', 'Bangladesh'),(5,'Dey"s Publication','Kolkata','22412330','India')
go
insert into BookBindingType values (1,'HB'),(2,'PB')
go 
select * from Book 
insert into Book(BookId,ISBN,bookTitle,listedPrice,edition,pages,origin,authorId,genreId,publisherID,binding,languageId) values (1,9789350400463,'আম আটির ভেঁপু',130.00,6,96,'BN',1,5,1,1,1),(2,9789350401729,'পূর্ব পশ্চিম',1000.00,5,986,'BN',3,1,2,1,1),(3,9841802686,'দি প্লেগ',350.00,2,312,'FR',4,6,1,1,1),(4,9788129513700,'আদর্শ হিন্দু হোটেল',220.00,4,144,'BN',1,1,5,2,1),
(5,9789843471871,'জলেশ্বরী',252.00,7,128,'BN',7,1,3,1,1)
go

