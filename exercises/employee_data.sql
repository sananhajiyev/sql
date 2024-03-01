/*
1. Show minimum, average and maximum salary in last 15 years according to job id.
*/
select min(salary), round(avg(salary), 2), max(salary), job_id 
from hr.employees
where extract(year from sysdate) - extract(year from hire_date) > 15
group by job_id;

/*
2. How many employees hired after 2005 for each department?
*/
select department_id, count(employee_id) from hr.employees
where extract(year from hire_date) > 2005
group by department_id;

/*
3. Write a query to show departments in which the difference between maximum and minimum 
salary is greater than 5000.
*/
select department_id, max(salary), min(salary) from hr.employees
group by department_id
having max(salary) - min(salary) > 5000;

/*
4. Display sum of salaries of employees who has not commission pct according to departments 
(without using where).
*/
select department_id,
sum(case when commission_pct is null then salary
else 0
end)
from hr.employees
group by department_id;

/*
5. How many people has job id with average salary between 3000 and 7000?
*/
select job_id, count(*) from hr.employees
group by job_id
having avg(salary) between 3000 and 7000;

/*
6. Find number of employees with same name.
*/
select first_name, count(*) from hr.employees
group by first_name
having count(*)>1;

/*
7. How many people with the same phone code work in departments 50 and 90?
*/
select substr(phone_number, 1, 3) phone_code, department_id, count(*) EMP_CNT from hr.employees
group by substr(phone_number, 1, 3), department_id
having count(*)>1 AND department_id in (50, 90);

/*
8. Display departments with count of number of employees more than 5 in spring and autumn.
*/
select department_id, count(*)
from hr.employees
where extract(month from hire_date) in (3,4,5,9,10,11)
group by department_id
having count(*)>5;


/*
9. How many employees work in departments which has maximum salary more than 5000?
*/
select department_id, count(*) from hr.employees
group by department_id
having max(salary)>5000 and department_id is not null;

/*
10.Change second letter of employees� names with the last letter and display.
*/
select concat(substr(first_name, 1, 1), substr(first_name, -1, 1)||concat(substr(first_name,3,3), substr(first_name, 2, 1)) from dual;
select first_name,
substr(first_name, 1, 1)||
substr(first_name, -1, 1)||
substr(first_name, 3, length(first_name)-3)||
substr(first_name, 2, 1) from hr.employees;