CREATE TABLE Employees
(
	EmployeeID  INTEGER PRIMARY KEY,
	ManagerID   INTEGER NULL,
	JobTitle    VARCHAR(100) NOT NULL
);
INSERT INTO Employees (EmployeeID, ManagerID, JobTitle) 
VALUES
	(1001, NULL, 'President'),
	(2002, 1001, 'Director'),
	(3003, 1001, 'Office Manager'),
	(4004, 2002, 'Engineer'),
	(5005, 2002, 'Engineer'),
	(6006, 2002, 'Engineer');

--Question 1
WITH  EmployeeDepth AS (
    SELECT EmployeeID, ManagerID, JobTitle, 0 AS Depth
    FROM Employees
    WHERE ManagerID IS NULL
    UNION ALL
    SELECT e.EmployeeID, e.ManagerID, e.JobTitle, ed.Depth + 1
    FROM Employees e
    JOIN EmployeeDepth ed ON e.ManagerID = ed.EmployeeID
)
SELECT * FROM EmployeeDepth;

--Question 2

;With cte as(
	select 1 as Num, 1 as Factorial
	union all
	select Num+1,Factorial*(Num+1) from cte
	where Num<10
)
select * from cte;

--Question 3

;With cte as(
	select 1 as n, 1 as Fibonacci_Number, 1 as x	
	union all
	select n+1,x,Fibonacci_Number+x from cte
	where n<10
)
select n, Fibonacci_Number from cte;