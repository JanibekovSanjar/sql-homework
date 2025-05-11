create table Employees(
	EmployeeID int primary key,
	Name nvarchar(50),
	DepartmentID int,
	Salary int
);
insert into Employees (EmployeeID, Name, DepartmentID, Salary)
values
(1, 'Alice', 101, 60000),
(2, 'Bob', 102, 70000),
(3, 'Charlie', 101, 65000),
(4, 'David', 103, 72000),
(5, 'Eva', NULL, 68000);


create table Departments(
	DepartmentID int,
	DepartmentName nvarchar(30)
);
insert into Departments(DepartmentID, DepartmentName)
values
(101, 'IT'),
(102, 'HR'),
(103, 'Finance'),
(104, 'Marketing');


create table Projects(
	ProjectID int primary key,
	ProjectName nvarchar(30),
	EmployeeID int
);
insert into Projects values
(1,'Alpha',1),
(2,'Beta',2),
(3,'Gamma',3),
(4,'Delta',4),
(5,'Omega',5)

--Question 1
select 
    e.EmployeeID,
    e.Name,
    d.DepartmentName
from Employees as e 
inner join Departments as d
	on e.DepartmentID = d.DepartmentID;

--Question 2
select 
    e.EmployeeID,
    e.Name,
    d.DepartmentName
from 
    Employees e
left join 
    Departments d
on 
    e.DepartmentID = d.DepartmentID;

--Question 3
select 
    e.EmployeeID,
    e.Name,
    d.DepartmentName,
	e.Salary
from 
    Employees e
right join 
    Departments d
on 
    e.DepartmentID = d.DepartmentID
order by e.EmployeeID;

--Question 4
select 
    e.EmployeeID,
    e.Name,
    d.DepartmentName,
    e.Salary
from 
    Employees e
full outer join 
    Departments d
on 
    e.DepartmentID = d.DepartmentID;

--Question 5
select DepartmentName,
	sum(Salary) as TotalSalary
from (select 
    e.EmployeeID,
    e.Name,
    d.DepartmentName,
	e.Salary
from 
    Employees e
right join 
    Departments d
on 
    e.DepartmentID = d.DepartmentID) as NewTable
group by DepartmentName
order by TotalSalary;

--Question 6
select * from Departments 
cross join Projects;

--Question 7
select Name,DepartmentName,p.ProjectName
from (select 
    e.EmployeeID,
    e.Name,
    d.DepartmentName
from 
    Employees e
left join 
    Departments d
on 
    e.DepartmentID = d.DepartmentID) as Table1
left join Projects as p
	on Table1.EmployeeID = p.EmployeeID;