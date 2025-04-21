CREATE TABLE Employees(
     EmployeeID INT,
     Name VARCHAR(50),
     Department VARCHAR(50),
   Salary DECIMAL(10,2),
     HireDate DATE
) 

INSERT INTO Employees (EmployeeID, Name, Department, Salary, HireDate)
VALUES
(1, 'John Smith', 'HR', 55000.00, '2020-03-15'),
(2, 'Emily Johnson', 'IT', 72000.50, '2019-07-22'),
(3, 'Michael Brown', 'Finance', 68000.75, '2021-01-10'),
(4, 'Sophia Davis', 'Marketing', 60000.00, '2018-11-05'),
(5, 'David Wilson', 'IT', 75000.25, '2022-06-01'),
(6, 'Olivia Martinez', 'HR', 55000.00, '2020-03-15'),
(7, 'Liam Anderson', 'IT', 72000.50, '2019-07-22'),
(8, 'Emma Thompson', 'Finance', 68000.75, '2021-01-10'),
(9, 'Noah Taylor', 'Marketing', 60000.00, '2018-11-05'),
(10, 'Ava White', 'IT', 75000.25, '2022-06-01');

--1
SELECT *,
  ROW_NUMBER() OVER(ORDER BY Salary) AS rn
FROM Employees
ORDER BY EmployeeID

--2
SELECT Name, rn
FROM (
    SELECT *, DENSE_RANK() OVER (ORDER BY Salary) AS rn
    FROM Employees
) AS T
WHERE rn IN (
    SELECT rn
    FROM (
        SELECT DENSE_RANK() OVER (ORDER BY Salary) AS rn
        FROM Employees
    ) AS R
    GROUP BY rn
    HAVING COUNT(rn) > 1
);

--3
SELECT * FROM (SELECT *,
  ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary DESC) AS rn
FROM Employees) AS T
WHERE rn<=2

--4
SELECT * FROM (SELECT *,
  ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary) AS rn
FROM Employees) AS T
WHERE rn=1

--5
SELECT *,
  SUM(Salary) OVER(PARTITION BY Department ORDER BY Salary  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RN
FROM Employees

--6
SELECT *,
  SUM(Salary) OVER(PARTITION BY Department) AS TotalSalary
FROM Employees
ORDER BY EmployeeID

--7
SELECT *,
    CAST(AVG(Salary) OVER (PARTITION BY Department) AS DECIMAL(10,2)) AS AverageSalary
FROM Employees

--8
SELECT *,
    CAST((Salary - (AVG(Salary) OVER (PARTITION BY Department))) AS DECIMAL(10,2)) AS DifferenceSalary
FROM Employees

--9
SELECT *,
    CAST(AVG(Salary) OVER (PARTITION BY Department ORDER BY Salary 
	ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS DECIMAL(10,2)) AS MovingAvgSalary
FROM Employees

--10
SELECT SUM(Salary) AS Last3HiredTotalSalary
FROM (
    SELECT TOP 3 Salary
    FROM Employees
    ORDER BY HireDate DESC
) AS LastHired;

--11
SELECT *,
  CAST(
    AVG(Salary) OVER (
      ORDER BY HireDate
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS DECIMAL(10,2)
  ) AS RunningAvgSalary
FROM Employees;

--12
SELECT *,
  MAX(Salary) OVER(ORDER BY Salary  ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING) AS RN
FROM Employees

--13
SELECT *,
	CAST((Salary/SUM(Salary) OVER(PARTITION BY Department) * 100) AS decimal(10,2)) AS CONTRIBUTION
FROM Employees