--Task 3
create table WorkLog(
	EmployeeID int,
	EmployeeName varchar(50),
	Department varchar(50),
	WorkDate Date,
	HoursWorked int
);
INSERT INTO WorkLog (EmployeeID, EmployeeName, Department, WorkDate, HoursWorked) 
VALUES 
(1, 'Alice', 'HR', '2024-03-01', 8),
(2, 'Bob', 'IT', '2024-03-01', 9),
(3, 'Charlie', 'Sales', '2024-03-02', 7),
(1, 'Alice', 'HR', '2024-03-03', 6),
(2, 'Bob', 'IT', '2024-03-03', 8),
(3, 'Charlie', 'Sales', '2024-03-04', 9);


Create view vw_MonthlyWorkSummary as
select EmployeeID, EmployeeName, Department, 
	sum(HoursWorked) as TotalHoursWorked
from WorkLog
group by EmployeeID,EmployeeName,Department
Go
select Department,
	sum(HoursWorked) as TotalHoursDepartment
	from WorkLog
group by Department
Go
select Department,
	avg(HoursWorked) as TotalHoursDepartment
	from WorkLog
group by Department;

Select * from vw_MonthlyWorkSummary;
