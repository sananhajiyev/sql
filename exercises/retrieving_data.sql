/*
1) Write a query in SQL to display job Title, the difference between minimum and maximum salaries 
for those jobs which max salary within the range 12000 to 18000.
*/

select job_title, min_salary - max_salary as "Salary Difference" from hr.jobs WHERE max_salary BETWEEN 12000 and 18000;

/*
2) Display the details of the employees who have no commission percentage and whose salary is 
within the range 7000 to 12000 for those employees who are not working in the departments 50,30 and 80.
*/

select * from hr.employees where commission_pct is null 
and salary BETWEEN 7000 and 12000 
and department_id not in (30, 50, 80);

/*
3) Write a query in SQL to display the full name (first name and last name), hire date, commission 
percentage, email and telephone separated by '-', and salary for those employees whose salary 
is above 11000 and make the result set in a descending order by the full name.
*/

select first_name||' '||last_name as "FULLNAME", hire_date, commission_pct, email ||'-'||phone_number "CONTACT-DETAILS" 
from hr.employees
where salary>11000 ORDER BY 1 DESC;

/*
4) Write a query in SQL to display the first and last name, and salary for those employees whose first 
name is ending with the letter �m� and they have been hired before June 5th, 2010.
*/

select first_name, last_name,salary, hire_date from hr.employees
where first_name like '%m' and hire_date<'5-jun-2010';

/*
5) Display the full name (first and last), the phone number and email separated by hyphen, and 
salary, for those employees whose salary is not within the range of 9000 and 17000 and 
commission is not null. The column headings assign with Full_Name, Contact_Details and 
Remuneration respectively.
*/

select first_name||' '||last_name "Full_Name", salary, email ||'-'||phone_number as "Contact_Details" 
from hr.employees
where salary NOT BETWEEN 9000 and 17000
and commission_pct is not null;

/*
6) Write a query in SQL to display all the information about the department Marketing.
*/

select * from hr.departments
where department_name = 'Marketing';

/*
7) Write a query to display data from job_history and make the result set in descending order by the 
epmloyee_id and ascending order by start date.
*/

select * from hr.job_history
ORDER BY employee_id asc, start_date desc;

/*
8) Write a query to display job_id and salary of employees whose phone number starts with 515 or 
590 and was hired after 2003 by sorting hire_date and salary in ascending way.
*/

select job_id, salary,hire_date from hr.employees
where (phone_number like '515%' or phone_number like '590%')
and (hire_date > '31-DEC-2003')
order by hire_date, salary;

/*
9) Write a query to display employees who were hired in 2001.
*/

select * from hr.employees
where hire_datE LIKE '%01';

/*
10) Write a query to display employees� first and last name who were not hired in 2006 and 2007.
*/

SELECT first_name, last_name from hr.employees 
WHERE hire_date not like '%06' and hire_date not like '%07';

/*
11) Write a query to display email, job_id and first name of employees whose hired year was 2007 
or hired month was 1.
*/

select email, job_id, first_name from hr.employees
where hire_date like '%07' or hire_date like '%-JAN-%';

/*
12) Write a query to display details of employees who was hired after 2007 or salary is less than 
10000.
*/

select * from hr.employees
where hire_date > '01-DEC-2007' or salary<10000;

/*
13. Display the length of first name for employees where last name contain character �b� after 3rd
position.
*/

select first_name, LENGTH(first_name) first_name_length
from hr.employees
WHERE last_name like '___%b%';