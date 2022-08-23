Create Database assign13;
use assign13;

Create table Employee(
Name Varchar(20),
Year int,
Sales Int);

Insert Into Employee values 
('Pankaj',2010,72500),
('Rahul',2010,60500),
('Sandeep',2010,52000),
('Pankaj',2011,45000),
('Sandeep',2011,82500),
('Rahul',2011,35600),
('Pankaj',2012,32500),
('Pankaj',2010,20500),
('Rahul',2011,200500),
('Sandeep',2010,32000);

select * from Employee

--Q1. Convert the following given Employee table into the following output tables
--a

Select * from Employee Pivot (Sum(Sales) for Name In (Pankaj,Rahul,Sandeep)) As PivotTable;

--b

Select * from Employee Pivot (Sum(Sales) for Year In ([2010],[2011],[2012])) As PivotTable2;

--Q2. WAQ to do following changes from Original table to PIVOT table.


use assign12o

--4a. Write a query to dynamically filter and get records of cities with a sum of salaries greater than 1.5 Lakhs.

Declare @orderDate as varchar(25);

--5b. Write a query to dynamically filter the records which have employee ID greater than 125.

Declare @d Varchar(1000),
        @sql nvarchar(1000);

Set @d = '125';
Set @Sql = 'Select * from CustomerOrders where CustomerID >'+@d;

Exec(@sql);


--c. Write a query to dynamically filter on customers with total spend of 2500 or above
        @sql nvarchar(1000);

Set @d = '2500';
Set @Sql = 'Select CustomerID, Sum(OrderAmount) As Total_Spend from CustomerOrders Group by CustomerID Having Sum(OrderAmount) >='+@d;

Exec(@sql);

