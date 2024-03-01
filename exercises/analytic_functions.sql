/*
1. Select the department name, employee name, and salary of all employees who work in the 
human resources or purchasing departments. Compute a rank for each unique salary in both 
departments.
*/

SELECT DEP.DEPARTMENT_NAME, EMP.FIRST_NAME, SALARY,
DENSE_RANK() OVER (PARTITION BY DEP.DEPARTMENT_ID
ORDER BY emp.salary) drank
from HR.EMPLOYEES EMP
LEFT JOIN HR.DEPARTMENTS DEP
ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
WHERE DEP.DEPARTMENT_ID IN (30,40);


/*
2. Select the 3 employees with minimum salary for department id 50.
*/

SELECT * FROM (SELECT DEP.DEPARTMENT_NAME, EMP.FIRST_NAME, SALARY,
DENSE_RANK() OVER (PARTITION BY DEP.DEPARTMENT_ID
ORDER BY emp.salary) drank
from HR.EMPLOYEES EMP
LEFT JOIN HR.DEPARTMENTS DEP
ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
WHERE DEP.DEPARTMENT_ID = 50)
WHERE  drank IN (1, 2, 3);


/*
3. Show first name, last name, salary and previously listed employee�s salary who works in
�IT_PROG� over hire date.
*/

SELECT LAST_NAME, HIRE_DATE, SALARY,
LAG(SALARY, 1, 0)
OVER (ORDER BY HIRE_DATE)
FROM HR.EMPLOYEES
WHERE JOB_ID = 'IT_PROG';


/*
4. Display details of current job for employees who worked as IT Programmers in the past.
*/

select emp.first_name, j.* from hr.employees emp
inner join hr.jobs j
on emp.job_id = j.job_id
where emp.employee_id in (select employee_id from hr.job_history where job_id = 'IT_PROG');


/*
5. Make a copy of the employees table and update the salaries of the employees in the new table 
with the maximum salary in their departments.
*/

update employees_copy ec set salary = (select max(salary) from hr.employees emp where emp.department_id = ec.department_id);


/*
6. Make a copy of the employees table and update the salaries of the employees in the new table 
with a 30 percent increase.
*/

update employees_copy ec set ec.salary = ec.salary*1.3;

/*
7. For any date given, write a script to find:
        a) The first and the last days of the next year;
        b) The first and the last days of the next month;
        c) The first and the last days of the previous month.
*/

SELECT TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE, 12), 'YYYY'), 'DD-MON-YY') AS next_year_first_day,
       TO_CHAR(LAST_DAY(ADD_MONTHS(SYSDATE, 15)), 'DD-MON-YY') AS next_year_last_day
FROM dual;


SELECT TRUNC(SYSDATE, 'MM') + INTERVAL '1' MONTH AS next_month_first_day,
       LAST_DAY(TRUNC(SYSDATE, 'MM') + INTERVAL '1' MONTH) AS next_month_last_day
FROM dual;


SELECT TRUNC(SYSDATE, 'MM') - INTERVAL '1' MONTH AS prev_month_first_day,
       LAST_DAY(TRUNC(SYSDATE, 'MM') - INTERVAL '1' MONTH) AS prev_month_last_day
FROM dual;