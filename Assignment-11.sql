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

--ii. self join
--i. Window function

Select *,avg(salary) Over(Partition by DEPT_ID Order by ID) as Avg_Sal from Employee;

--ii. Group By
Select DEPT_ID, Avg(Salary) as Avg_Sal From Employee group by DEPT_ID;

--c. Find the employees who have their salary greater than their Department�s average salary.


select * into #emp from (Select DEPT_ID ,Avg(Salary) as Avg_Sal From Employee group by DEPT_ID)c;
select * from #emp

select A.ID,A.DEPT_ID,A.SALARY,B.AVG_SAL FROM Employee A Inner Join #emp B 
ON A.DEPT_ID = B.DEPT_ID where A.SALARY > B.Avg_Sal;

--d. Write a query to print the maximum salary per job role (using window function)

--e. Write a query to print the minimum salary per job role (using window function)
--minimum salary per job role (using window function) in two separate columns in the
--output table (this is a combination of 1c and 1d).
--transaction), transaction_value, and type (deposit/withdrawal).