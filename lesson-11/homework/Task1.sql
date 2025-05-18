--Task 1
create table Employees(
	EmployeeID int primary key,
	Name varchar(50),
	Department varchar(10),
	Salary int
);
INSERT INTO Employees (EmployeeID, Name, Department, Salary) VALUES (1, 'Alice', 'HR', 5000);
INSERT INTO Employees (EmployeeID, Name, Department, Salary) VALUES (2, 'Bob', 'IT', 7000);
INSERT INTO Employees (EmployeeID, Name, Department, Salary) VALUES (3, 'Charlie', 'Sales', 6000);
INSERT INTO Employees (EmployeeID, Name, Department, Salary) VALUES (4, 'David', 'HR', 5500);
INSERT INTO Employees (EmployeeID, Name, Department, Salary) VALUES (5, 'Emma', 'IT', 7200);


create table #EmployeeTransfers(
	EmployeeID int primary key,
	Name varchar(50),
	Department varchar(10),
	Salary int
);
Insert INTO #EmployeeTransfers
SELECT 
    EmployeeID,
    Name,
    CASE 
        WHEN Department = 'HR' THEN 'IT'
        WHEN Department = 'IT' THEN 'Sales'
        WHEN Department = 'Sales' THEN 'HR'
        ELSE Department -- Keep others unchanged
    END AS Department,
    Salary
FROM Employees;

Select * from #EmployeeTransfers;