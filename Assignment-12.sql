CREATE DATABASE ASSIGN12;
USE ASSIGN12;

--1QA. Find the overall rank of each student in class.
--Note : Try all the rank functions and suggest which rank function should be used for ranking and why?

CREATE TABLE CGPA(
Roll_Number int,
Name varchar(10),
X float,
Section char(1));

insert into CGPA Values(1,'Ajay',8.4,'A'),(2,'Priyansh',9.8,'B'),
(3,'Neha',9.9,'C'),(4,'Pooja',7.2,'A'),(5,'Salim',9.5,'C'),(6,'Sahil',9.8,'A'),
(7,'Geeta',8.4,'B'),(8,'Rahul',7.6,'B'),(9,'Pinki',8.4,'C');
Select * from CGPA;

Select *,
ROW_NUMBER() over (Order by X DESC) as Row_Num,
RANK() over (Order by X DESC) as Rank,
DENSE_RANK() over (Order by X DESC) as Dense_Rank
from CGPA;

--QB. WAQ to find the section wise
--a. Average CGPA

Select *,Avg(X) Over (Partition By Section Order by Section) As Avg_CGPA from CGPA;

--b. Cumulative average of CGPA

Select *,Avg(X) Over (Partition By Section Order by x) As Avg_CGPA from CGPA;

--c. First rank holder (Assign lowest rank to highest scorer)

select * from (Select *, DENSE_RANK() over(Partition by Section Order by X Desc) As Rank1 from CGPA) c where Rank1 = 1;

--d. Highest scorerselect * from (Select *, DENSE_RANK() over(Partition by Section Order by X Desc) As Rank1 from CGPA) c where Rank1 = 1;--4a. Find the rank of each employee according to their salary

--select * from Departments;
--select * from Employee;
Select *, DENSE_RANK() Over (Order by Salary) as Rank From Employee;

--4b. Find the 3rd highest salary in the company using a window function.

Select * from (Select *, DENSE_RANK() Over (Order by Salary desc) as Rank From Employee)a where Rank = 3;

--4c. Find the 4th Highest salary in each department.

Select * from (Select *, DENSE_RANK() Over (Partition by DEPT_ID Order by Salary desc) as Rank From Employee)a where Rank = 4;

--4d. Find the department wise cumulative salary with salary ordered in ascending order.

Select *, Sum(Salary) Over (Partition by DEPT_ID Order by Salary) as Cumm_Salary From Employee;

--4e. Print the average salary of the employees in a new column using a window function,
--partitioning by gender.

Select *,avg(salary) over(Partition by gender Order by Salary) As Avg_Sal from EMPLOYEE;

--4f. Divide the employees into quartiles by utilizing their Salary to bucket them. Maximum
--salaried employees should fall in 1st Quartile.
--(Here, Quartile means divide data into 4 buckets)
Select *,NTILE(4) over(order by Salary Desc) As Salary_Quartile from Employee;

--5. You are given a Transactions table for the year 2021 Columns(id, remark, amount, CREATEDAT,
--userID). For each user, find the MONTH when the total amount transacted by them was maximum

Select userID, Month(CTREATEDAT) As Month , MAX(amount) 
over (Partition by userID Order by amount Desc) As Max_Amount From transactions

--6. Find the cumulative sum of sales month wise: Question on sales

select * from sales
select *,MONTH(Date) As Month, Sum(Sales)over(Partition by MONTH(Date) order by sales) As Cumm_Sum from Sales;