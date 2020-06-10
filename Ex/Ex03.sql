SELECT
    employee_id,
    first_name || ' ' || last_name,
    salary
FROM
    employees
where
    salary > (SELECT salary
                FROM employees
               where first_name = 'Den');
               
SELECT
    salary
FROM
    employees
where
    first_name = 'Den';

--급여를 가장 적게 받는 사람의 이름, 급여, 사원번호는?
SELECT
    first_name || ' ' || last_name,
    salary,
    employee_id
FROM
    employees
where salary = (SELECT MIN(salary)
                FROM employees);

--평균 급여보다 적게 받는 사람의 이름, 급여를 출력하세요?
--출력문
SELECT
    first_name || ' ' || last_name,
    salary
FROM
    employees
WHERE
    salary < (SELECT avg(salary)
                FROM employees);
                
--각 부서별로 최고급여를 받는 사원을 출력하세요
SELECT
    first_name || ' ' || last_name,
    salary,
    department_id
FROM
    employees
WHERE
    (department_id,
    salary) in (SELECT department_id, MAX(salary)
                from employees
            GROUP BY department_id);
            
--부서번호가 110인 직원의 급여 보다 큰 모든 직원의 
--사번, 이름, 급여를 출력하세요.(or연산--> 8300보다 큰)
SELECT
    employee_id,
    first_name,
    salary
FROM 
    employees
where salary > any(SELECT salary
                    from employees
                    WHERE department_id = 110);

                    
select department_id, employee_id, first_name, salary
from employees
where (department_id, salary) in (select department_id, max(salary)
                                  from employees
                                  group by department_id);

select e.department_id, e.employee_id, e.first_name, e.salary
from employees e, (select department_id, max(salary) salary
                   from employees
                   group by department_id) s 
where e.department_id = s.department_id
and e.salary = s.salary;

SELECT
    ROWNUM
    employee_id,
    first_name || ' ' || last_name,
    salary
FROM(
    SELECT
        employee_id,
        first_name,
        last_name,
        salary
    FROM
        employees
    order by salary DESC
    )
WHERE ROWNUM<=5;

SELECT 
        ro,
        first_name || ' ' || last_name,
        salary,
        hire_date
from 
    (SELECT
        ROWNUM ro,
        first_name,
        last_name,
        salary,
        hire_date
    FROM
        (SELECT
            first_name,
            last_name,
            salary,
            hire_date
        FROM employees
        where hire_date LIKE '07%'
        order by salary asc)
    )
where ro between 3 and 7;