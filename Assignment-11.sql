CREATE DATABASE ASSIGN11;
USE ASSIGN11;

create table Employee(
ID INT,
NAME VARCHAR(15),
SALARY INT,
JOB_ROLE VARCHAR(50),
GENDER CHAR(1),
DEPT_ID INT);

INSERT INTO Employee values
(102,'Amit',70000,'Business Analyst','M',2),
(103,'Rahul',62000,'Data Analyst','M',1),
(105,'Rina',60000,'Accountant','F',5),
(106,'Dilip',74000,'SDE','M',1),
(107,'Aman',81000,'Accountant','M',5),
(108,'Neha',50000,'Receptionist','F',4),
(110,'Bhupendra',32000,'Salesman','M',3),
(111,'Ashish',73000,'Business Analyst','M',2),
(112,'Pooja',45000,'Generalist','F',4),
(114,'Neelu',30000,'Help Desk','F',4),
(115,'Amar',87000,'SDE','M',1),
(116,'Priyansh',345000,'President','M',2),
(117,'Hema',187000,'VP','F',2),
(119,'Swami',30000,'Salesman','M',3),
(120,'Salman',91000,'Data Scientist','M',1);

create table Departments(
ID INT,
Departments varchar(20));

Insert into Departments values
(1,'IT'),
(2,'Management'),
(3,'Sales'),
(4,'HR'),
(5,'Accounts');

select * from Departments;
select * from Employee;

--Q.1 Find the following from the given tables.
--a. Find the cumulative sum of salary using:
--i. window function

Select *,sum(salary) Over(Order by ID) as Cumm_Sum from Employee;

--ii. self joinSelect A.ID,A.Name,A.Salary, Sum(B.Salary) As Cumm_Sum from Employee A Inner Join Employee B ON (A.ID >= B.ID)Group by A.ID,A.NAME,A.SALARY order by A.ID;--b. Find the department wise average salary using:
--i. Window function

Select *,avg(salary) Over(Partition by DEPT_ID Order by ID) as Avg_Sal from Employee;

--ii. Group By
Select DEPT_ID, Avg(Salary) as Avg_Sal From Employee group by DEPT_ID;

--c. Find the employees who have their salary greater than their Department’s average salary.


select * into #emp from (Select DEPT_ID ,Avg(Salary) as Avg_Sal From Employee group by DEPT_ID)c;
select * from #emp

select A.ID,A.DEPT_ID,A.SALARY,B.AVG_SAL FROM Employee A Inner Join #emp B 
ON A.DEPT_ID = B.DEPT_ID where A.SALARY > B.Avg_Sal;

--d. Write a query to print the maximum salary per job role (using window function)Select *,Max(salary) Over(Partition by Job_Role Order by Job_Role) as Max_Sal from Employee;

--e. Write a query to print the minimum salary per job role (using window function)Select *,Min(salary) Over(Partition by Job_Role Order by Job_Role) as Min_Sal from Employee;--f. Write a query to print the maximum salary per job role (using window function),
--minimum salary per job role (using window function) in two separate columns in the
--output table (this is a combination of 1c and 1d).Select *,Max(salary) Over(Partition by Job_Role Order by Job_Role) as Max_Sal,Min(salary) Over(Partition by Job_Role Order by Job_Role) as Min_Sal from Employee;--g. Write a query to print the maximum salary per department (using window function)Select *,Max(salary) Over(Partition by Dept_ID Order by DEPT_ID) as Max_Sal from Employee;--h. Write a query to print the minimum salary per department (using window function)Select *,Min(salary) Over(Partition by Dept_ID Order by DEPT_ID) as Max_Sal from Employee;--Q.4 We're given a table of bank transactions with 4 columns, user_id, created_at (date for each
--transaction), transaction_value, and type (deposit/withdrawal).--Write a query to get the cumulative average of transaction values for each type.Select *,avg(transaction_value) Over(Partition by Type Order by Type) as Avg_Trans from Bank_Transactions;--2a. Create a view for each department and name the view in the name of the department.create view d1 as (select * from Employee where DEPT_ID =1);create view d2 as (select * from Employee where DEPT_ID =2);create view d3 as (select * from Employee where DEPT_ID =3);create view d4 as (select * from Employee where DEPT_ID =4);create view d5 as (select * from Employee where DEPT_ID =5);--2c. Create a view containing 5 highest paid employees.create view High_Paid as (select * from Employee where DEPT_ID =5);--b. Create a view for each gender and name the view as male and female.create view Male as (select * from Employee where Gender ='M');create view Female as (select * from Employee where Gender ='F');--c. Create a view containing 5 highest paid employees.create view High_Sal as (select top 5 * from Employee Order by SALARY DESC);SELECT * FROM High_Sal