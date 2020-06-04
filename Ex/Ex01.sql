select * from employees; 

select * from departments;

select employee_id, first_name, last_name
from employees;

select first_name, phone_number, hire_date, salary
from employees;

select first_name "�̸�",
       last_name "��",
       salary "�޿�",
       phone_number "��ȭ��ȣ",
       email "�̸���",
       hire_date "�Ի���"
from employees;

/*select �� as ���*/
select employee_id as empNO,
       first_name "E-name",
       salary "�� ��"
from employees;

select first_name || last_name
from employees;

select first_name, salary*12
from employees;

select first_name || '-' || last_name as "����",
       salary "�޿�",
       salary*12 "����",
       (salary*12)+5000 "����2",
       phone_number "��ȭ��ȣ"
from employees;

select first_name as "�̸�",
       salary as "����"
from employees
where salary >= 15000;

select first_name as "�̸�",
       hire_date as "�Ի���"
from employees
where hire_date >=  '07/01/01';


select salary as "����"
from employees
where first_name = 'Lex';

select first_name, salary
from employees
where salary >=14000
and salary <=17000; 

select first_name, hire_date
from employees
where hire_date >= '04/01/01';
and salary <= '05/12/31';

select first_name, salary
from employees
where salary between 14000 and 17000;

select first_name, last_name, salary
from employees
where  between 14000 and 17000;

select first_name, salary
from employees
where salary in (2100, 3100, 4100, 5100);

select first_name, salary
from employees
where salary = 2100
or salary = 3100
or salary = 4100
or salary = 5100;

SELECT first_name, last_name, salary
FROM employees
where first_name like 'L%'
or first_name like 'A%';

SELECT first_name || '-' || last_name, salary
FROM employees
where first_name like '%am%';

SELECT first_name || '-' || last_name, salary
FROM employees
where first_name like '_a%';

SELECT first_name || '-' || last_name, salary
FROM employees
where first_name like '___am%';

SELECT first_name || '-' || last_name, salary
FROM employees
where first_name like '%a_';

select first_name, salary, commission_pct, salary*commission_pct
from employees
where salary between 13000 and 15000;

select first_name, salary, commission_pct
from employees
where commission_pct is not null;

select first_name
from employees
where manager_id is null 
and commission_pct is null;

select first_name, salary
from employees
where salary >= 9000
order by salary asc, first_name asc;

select department_id, salary, first_name
from employees
order by department_id;

select first_name, salary
from employees
where salary >= 1000
order by salary desc;

select department_id, salary, first_name
from employees
order by department_id asc, salary desc;