SELECT count(*) --27
FROM departments;

SELECT count(*) --107
FROM employees;

SELECT
    em.employee_id,
    em.first_name,
    em.department_id edid,
    de.department_id,
    de.department_name
FROM
    employees em,
    departments de
where
    em.department_id = de.department_id
order by
    em.first_name asc;
    
-- 모든 직원과 직업명
SELECT
    em.first_name || ' ' || em.last_name,
    de.department_name,
    jo.job_title
FROM
    employees em,
    departments de,
    jobs jo
where
    em.job_id = jo.job_id
    and em.department_id = de.department_id
order by
    em.first_name asc;
    
select
    em.employee_id,
    em.first_name,
    em.department_id,
    de.department_id,
    de.department_name
from
    employees em left outer join departments de
    on em.department_id = de.department_id;

SELECT
    e.employee_id,
    e.first_name,
    e.department_id,
    d.department_id,
    d.department_name
FROM 
    departments d full outer join employees e
    on e.department_id = d.department_id;
    
SELECT
    em.employee_id,
    em.first_name,
    
FROM
    employees em,
    employees man
where em.manager_id = man.manager_id;