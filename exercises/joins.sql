/*
1. Display the first promotion year for each employee.
*/

select emp.*, mhd.first_promotion_date from hr.employees emp
left join (select employee_id, min(end_date) first_promotion_date from hr.job_history
group by employee_id) mhd on emp.employee_id = mhd.employee_id;

/*
2. Display location, city and department name of employees who have been promoted more than 
once.
*/

select dep.department_name, loc.city, loc.location_id from hr.employees emp
left join hr.departments dep on emp.department_id = dep.department_id
left join hr.locations loc on dep.location_id = loc.location_id
where emp.employee_id in (select employee_id from hr.job_history 
                          group by employee_id
                          having count(*)>1);

/*
3. Display minimum and maximum �hire_date� of employees work in IT and HR departments.
*/

select d.department_name, min(e.hire_date), max(e.hire_date) from hr.employees e
left join hr.departments d on e.department_id = d.department_id
where d.department_id in (40, 60)
group by d.department_name;

/*
4. Find difference between current date and hire dates of employees after sorting them by hire 
date, then show difference in days, months and years.
*/

select emp.first_name,
round(sysdate - hire_date) day_diff,
round(months_between(sysdate, hire_date)) month_diff,
round(extract(year from sysdate) - extract(year from hire_date)) year_diff
from hr.employees emp
order by emp.hire_date;

/*
5. Find which departments used to hire earliest/latest.
*/

select d.department_name, e.hire_date from hr.employees e
left join hr.departments d on e.department_id = d.department_id
where e.hire_date = (select min(hire_date) from hr.employees)

union

select d.department_name, e.hire_date from hr.employees e
left join hr.departments d on e.department_id = d.department_id
where e.hire_date = (select max(hire_date) from hr.employees);

/*
6. Find the number of departments with no employee for each city. 
*/

select l.city, count(*) from hr.departments d
left join hr.employees e on e.department_id = d.department_id
left join hr.locations l on l.location_id = d.location_id
where e.employee_id is null
group by l.city;

/*
7. Create a category called �seasons� and find in which season most employees were hired.
*/

select * from (
select ss.seasons,count(*) say 
from (select first_name, hire_date,
case
when extract(month from hire_date) in (12,1,2)  then  'Qis'
when extract(month from hire_date) in (3,4,5)  then  'Yaz'
when extract(month from hire_date) in (6,7,8)  then  'Yay'
when extract(month from hire_date) in (9,10,11)  then  'Payiz'
else 'None'
end seasons from hr.employees) ss 
group by ss.seasons)
where say =
(select  max(say) from (
select ss.seasons,count(*) say from (select first_name, hire_date,
case 
when extract(month from hire_date) in (12,1,2)  then  'Qis'
when extract(month from hire_date) in (3,4,5)  then  'Yaz'
when extract(month from hire_date) in (6,7,8)  then  'Yay'
when extract(month from hire_date) in (9,10,11)  then  'Payiz'
else 'None'
end seasons from hr.employees) ss 
group by ss.seasons));

/*
8. Find the cities of employees with average salary more than 5000.
*/

select loc.city, count(*) from hr.employees emp 
left join hr.departments dep on  emp.department_id = dep.department_id
left join hr.locations loc on loc.location_id = dep.location_id
group by loc.city 
having  avg(salary)>5000;

/*
9. Display employee name and country in which he is working.
*/

select first_name||' '||last_name full_name, c.country_name from hr.employees e
join hr.departments d on e.department_id = d.department_id
join hr.locations l on l.location_id = d.location_id
join hr.countries c on c.country_id = l.country_id
order by c.country_name;