/*Question 1*/

select * from hr.employees;

UPDATE hr.employees
SET phone_number = replace(phone_number, '.', '-')
WHERE employee_id in (132,133,134);

/*Question 2*/

UPDATE hr.employees
SET email = email || '@dsa.az'
WHERE salary > (SELECT AVG(salary) FROM hr.employees);

/*Question 3*/

select * from hr.locations;

SELECT r.region_name, l.city
FROM hr.regions r
JOIN hr.countries c ON r.region_id = c.region_id
JOIN hr.locations l on l.country_id = c.country_id
WHERE l.street_address LIKE '%Boxwood%' or l.street_address LIKE '%Zagora%';

/*Question 4*/

SELECT e.job_id, AVG(j.max_salary - j.min_salary) AS avg_salary_difference
FROM hr.employees e
left join hr.jobs j on j.job_id = e.job_id
GROUP BY e.job_id;

/*Question 5*/

select extract(year from end_date) from hr.job_history;

SELECT e.department_id from hr.employees e
left join hr.job_history jh on jh.employee_id = e.employee_id
where extract(year from jh.end_date) < 2005;

/*Question 6*/

select * from hr.employees;

SELECT *
FROM (
  SELECT TO_CHAR(hire_date, 'YYYY') AS hire_year,
         department_id,
         COUNT(*) AS employee_count
  FROM hr.employees
  WHERE department_id IN (20, 50, 80, 90)
  GROUP BY TO_CHAR(hire_date, 'YYYY'), department_id
)
PIVOT (
  SUM(employee_count) AS employees
  FOR department_id IN (20 AS "Dept 20", 50 AS "Dept 50", 80 AS "Dept 80", 90 AS "Dept 90")
);
--ORDER BY hire_date;


DESC hr.employees;

/*Question 7*/

SELECT department_name, first_name, last_name, salary, dense_rank() OVER (PARTITION BY department_name ORDER BY salary) AS salary_rank
FROM hr.employees e
JOIN hr.departments d ON e.department_id = d.department_id
ORDER BY department_name, salary_rank;

/*Question 8*/
select count(*) from hr.employees
where first_name = 'John';

/*Question 9*/
select manager_id, count(*) from hr.employees
where manager_id is not null
group by manager_id;

/*Question 10*/
select first_name, concat(email, '@dsa.az') from hr.employees
where first_name not like 'M%' or length(last_name)>6;

/*Question 11*/
select first_name from hr.employees
where substr(first_name,1,1) = substr(initcap(first_name),1,1);
 
 /*Question 12*/
select first_name,last_name, hire_date,
case
when extract(year from hire_date) < 2006 then 'Kohne isciler'
else 'Yeni isciler'
end
from hr.employees;

/*Question 13*/
select lpad(employee_id, 5, '0'), lpad(manager_id, 5, '0') from hr.employees;

/*Question 14*/
select job_title, substr(job_title, 1, instr(job_title, ' ', 1)-1) first_word  from hr.jobs;