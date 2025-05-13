CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50)
);


INSERT INTO Customers VALUES 
(1, 'Alice'), (2, 'Bob'), (3, 'Charlie');

INSERT INTO Orders VALUES 
(101, 1, '2024-01-01'), (102, 1, '2024-02-15'),
(103, 2, '2024-03-10'), (104, 2, '2024-04-20');

INSERT INTO OrderDetails VALUES 
(1, 101, 1, 2, 10.00), (2, 101, 2, 1, 20.00),
(3, 102, 1, 3, 10.00), (4, 103, 3, 5, 15.00),
(5, 104, 1, 1, 10.00), (6, 104, 2, 2, 20.00);

INSERT INTO Products VALUES 
(1, 'Laptop', 'Electronics'), 
(2, 'Mouse', 'Electronics'),
(3, 'Book', 'Stationery');

--Question 1
select c.CustomerName,o.OrderID,o.OrderDate
from Customers as c
left join Orders as o
	on c.CustomerID = o.CustomerID;

--Question 2
select c.CustomerName
from Customers as c
left join Orders as o
	on c.CustomerID = o.CustomerID 
where OrderID is null;

--Question 3
select OD.OrderID,P.ProductName,OD.Quantity
from OrderDetails as OD
join Products as P
	on P.ProductID = OD.ProductID;

--Question 4
select c.CustomerName,count(OrderID) as NumOfOrders
from Customers as c
left join Orders as o
	on c.CustomerID = o.CustomerID
group by CustomerName
having count(OrderID)>1;

--Question 5
select OD.OrderID,P.ProductName,OD.Price
from OrderDetails as OD
join (select OrderID,Max(Price) as Price from OrderDetails group by OrderID) as x
	on x.OrderID = OD.OrderID and x.Price = OD.Price
join Products as P
	on OD.ProductID = P.ProductID
order by OrderID;

--Question 6
select CustomerName,OrderId,OrderDate
from(select c.CustomerName,o.OrderID,o.OrderDate,
	ROW_NUMBER() Over(partition by c.CustomerName order by o.OrderDate desc) as rn
from Customers as c
left join Orders as o
	on c.CustomerID = o.CustomerID) as Ranked
where rn = 1;

--Question 7
select c.CustomerName
from Customers as c
join Orders as o on c.CustomerID = o.CustomerID 
join OrderDetails as od on o.OrderID = od.OrderID 
join Products as p on p.ProductID = od.ProductID
group by CustomerName
having COUNT(DISTINCT CASE WHEN P.Category != 'Electronics' THEN P.Category END) = 0;

--Question 8
select c.CustomerName
from Customers as c
join Orders as o on c.CustomerID = o.CustomerID 
join OrderDetails as od on o.OrderID = od.OrderID 
join Products as p on p.ProductID = od.ProductID
group by CustomerName
having COUNT(CASE WHEN P.Category = 'Stationery' THEN 1 END) > 0;

--Question 9
select c.CustomerID, c.CustomerName,
COALESCE(SUM(od.Price * od.Quantity), 0) AS TotalSpent
from Customers as c
left join Orders as o on c.CustomerID = o.CustomerID 
left join OrderDetails as od on o.OrderID = od.OrderID 
left join Products as p on p.ProductID = od.ProductID
group by c.CustomerID, c.CustomerName;