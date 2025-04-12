
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);
INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary, HireDate)
VALUES
(1, 'John', 'Doe', 'IT', 60000.00, '2018-05-12'),
(2, 'Jane', 'Smith', 'HR', 55000.00, '2019-03-18'),
(3, 'Mike', 'Johnson', 'Sales', 52000.00, '2020-01-23'),
(4, 'Emily', 'Davis', 'IT', 65000.00, '2017-11-10'),
(5, 'Chris', 'Brown', 'Marketing', 48000.00, '2021-07-01'),
(6, 'Anna', 'Taylor', 'Sales', 50000.00, '2019-06-14'),
(7, 'David', 'Wilson', 'Finance', 70000.00, '2016-09-30'),
(8, 'Sarah', 'Lee', 'HR', 53000.00, '2018-02-21'),
(9, 'Daniel', 'Walker', 'Marketing', 47000.00, '2022-01-05'),
(10, 'Laura', 'Allen', 'IT', 61000.00, '2020-10-12'),
(11, 'Robert', 'Young', 'Finance', 72000.00, '2015-12-03'),
(12, 'Jessica', 'King', 'HR', 56000.00, '2021-03-15'),
(13, 'Brian', 'Wright', 'Sales', 51000.00, '2023-04-19'),
(14, 'Olivia', 'Scott', 'IT', 64000.00, '2022-09-11'),
(15, 'Matthew', 'Adams', 'Marketing', 49000.00, '2023-06-25');

INSERT INTO Orders (OrderID, CustomerName, OrderDate, TotalAmount, Status)
VALUES
(1, 'Alice Johnson', '2022-01-10', 250.00, 'Delivered'),
(2, 'Bob Smith', '2024-01-12', 120.50, 'Shipped'),
(3, 'Charlie Lee', '2023-01-15', 330.75, 'Pending'),
(4, 'Diana White', '2023-01-17', 150.00, 'Cancelled'),
(5, 'Evan Harris', '2023-04-20', 200.99, 'Delivered'),
(6, 'Fiona Brown', '2024-01-22', 180.45, 'Shipped'),
(7, 'George Moore', '2023-07-25', 275.60, 'Pending'),
(8, 'Hannah Wilson', '2023-06-28', 310.40, 'Delivered'),
(9, 'Ian Clark', '2022-12-01', 145.90, 'Shipped'),
(10, 'Julia Adams', '2023-03-04', 190.00, 'Pending'),
(11, 'Kevin Hall', '2023-09-07', 299.99, 'Delivered'),
(12, 'Lily Baker', '2024-02-10', 260.75, 'Cancelled'),
(13, 'Martin Carter', '2023-11-12', 225.30, 'Shipped'),
(14, 'Nina Turner', '2022-11-15', 350.10, 'Pending'),
(15, 'Oscar Perez', '2024-01-18', 310.00, 'Delivered');

INSERT INTO Products (ProductID, ProductName, Category, Price, Stock)
VALUES
(1, 'Laptop X100', 'Electronics', 999.99, 10),
(2, 'Smartphone Z5', 'Electronics', 699.00, 25),
(3, 'Office Chair', 'Furniture', 149.50, 40),
(4, 'Wireless Mouse', 'Accessories', 25.99, 100),
(5, 'Bluetooth Headphones', 'Accessories', 89.00, 50),
(6, 'Standing Desk', 'Furniture', 320.00, 15),
(7, '4K Monitor', 'Electronics', 399.99, 30),
(8, 'Gaming Keyboard', 'Accessories', 75.00, 60),
(9, 'LED Desk Lamp', 'Furniture', 35.00, 70),
(10, 'USB-C Hub', 'Accessories', 45.90, 80),
(11, 'Webcam HD', 'Electronics', 89.50, 45),
(12, 'Graphic Tablet', 'Electronics', 299.00, 20),
(13, 'File Cabinet', 'Furniture', 110.00, 25),
(14, 'Smartwatch Pro', 'Electronics', 250.00, 35),
(15, 'Ergonomic Footrest', 'Furniture', 65.00, 50);

--Task1
SELECT TOP 10 *
FROM Employees
ORDER BY Salary DESC;

SELECT Department,
	AVG(Salary) as AverageSalary
FROM Employees
GROUP BY Department
ORDER BY AverageSalary
OFFSET 2 ROW FETCH NEXT 5 ROWS ONLY;

SELECT Salary,
	CASE
		WHEN Salary>80000 THEN 'High'
		WHEN Salary>50000 THEN 'Medium'
		ELSE 'Low'
	END AS SalaryCategory
FROM Employees

--Task2
SELECT 
    CASE 
        WHEN Status IN ('Shipped', 'Delivered') THEN 'Completed'
        WHEN Status = 'Pending' THEN 'Pending'
        WHEN Status = 'Cancelled' THEN 'Cancelled'
    END AS OrderStatus,
    COUNT(*) AS TotalOrders,
    SUM(TotalAmount) AS TotalRevenue
FROM Orders
WHERE OrderDate BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY 
    CASE 
        WHEN Status IN ('Shipped', 'Delivered') THEN 'Completed'
        WHEN Status = 'Pending' THEN 'Pending'
        WHEN Status = 'Cancelled' THEN 'Cancelled'
    END
HAVING SUM(TotalAmount) > 5000
ORDER BY TotalRevenue DESC;

--Task3
SELECT DISTINCT Category
FROM Products;

SELECT *
FROM (
    SELECT 
        ProductID,
        ProductName,
        Category,
        Price,
        Stock,
        ROW_NUMBER() OVER (PARTITION BY Category ORDER BY Price DESC) AS rn
    FROM Products
) AS Ranked
WHERE rn = 1;


SELECT 
    ProductID,
    ProductName,
    Category,
    Price,
    Stock,
    IIF(Stock = 0, 'Out of Stock',
        IIF(Stock BETWEEN 1 AND 10, 'Low Stock', 'In Stock')) AS InventoryStatus
FROM Products;

SELECT *
FROM Products
ORDER BY Price DESC
OFFSET 5 ROWS;

