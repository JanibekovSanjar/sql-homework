--Task 2
create table Orders_DB1(
	OrderID int primary key,
	CustomerName varchar(10),
	Product	varchar(15),
	Quantity int
);

insert into Orders_DB1 values 
	(101,'Alice','Laptop',1),
	(102,'Bob','Phone',2),
	(103,'Charlie','Tablet',1),
	(104,'David','Monitor',1);

create table Orders_DB2(
	OrderID int primary key,
	CustomerName varchar(10),
	Product	varchar(15),
	Quantity int
);

insert into Orders_DB2 values 
	(101,'Alice','Laptop',1),
	(103,'Charlie','Tablet',1);

declare @MissingOrders table(
	OrderID int primary key,
	CustomerName varchar(10),
	Product	varchar(15),
	Quantity int
);

insert into @MissingOrders 
select db1.* from 
Orders_DB1 db1
left join Orders_DB2 db2
	on db1.OrderID = db2.OrderID
where db2.OrderID is null;

SELECT * FROM @MissingOrders;

