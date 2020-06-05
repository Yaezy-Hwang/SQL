/*
���� 1. 
��ü������ ���� ������ ��ȸ�ϼ���.
������ �Ի���(hire_date)�� �ø�����(ASC)���� ���� ���Ӻ��� ����� �ǵ��� �ϼ���.
�̸�(first_name last_name),  ����(salary),  ��ȭ��ȣ(phone_number), �Ի���(hire_date) �����̰�
���̸���, �����ޡ�, ����ȭ��ȣ��, ���Ի��ϡ� �� �÷��̸��� ��ü�� ������.
*/
select first_name as "�̸�",
       salary as "����",
       phone_number as "��ȭ��ȣ",
       hire_date as "�Ի���"
from employees
order by hire_date asc;


/*
����2.
����(jobs)���� �����̸�(job_title)�� �ְ����(max_salary)�� ������ ��������(DESC)�� �����ϼ���.
*/
select job_title as "������",
       max_salary as "�ְ����"
from jobs
order by max_salary desc;


/*
����3.
��� �Ŵ����� �����Ǿ�������
Ŀ�̼Ǻ����� ����,
������ 3000�ʰ���
������ �̸�, �Ŵ������̵�, Ŀ�̼� ����, ���� �� ����ϼ���.
*/
SELECT first_name as "�̸�",
       manager_id as "�Ŵ���ID",
       commission_pct as "Ŀ�̼Ǻ���",
       salary as "����"
FROM employees
where manager_id is not null
and   commission_pct is null
and   salary>3000;


/*
����4.
�ְ����(max_salary)�� 10000 �̻���>where
������ �̸�(job_title)�� �ְ����(max_salary)�� >select
�ְ������(max_salary) ��������(DESC)�� �����Ͽ� ����ϼ���. <order by    
*/
SELECT job_title as "������",
       max_salary as "�ְ����"
FROM jobs
where max_salary >= 10000
order by max_salary DESC;


/*
����5.
������ 14000 �̸� 10000 �̻��� > where, and
������ �̸�(first_name), ����, Ŀ�̼��ۼ�Ʈ �� > select
���޼�(��������) ����ϼ���. >order by
�� Ŀ�̼��ۼ�Ʈ �� null �̸� 0 ���� ��Ÿ���ÿ�. select, nvl2
*/
SELECT first_name AS "�̸�",
       salary AS "����",
       nvl(commission_pct, 0) AS "Ŀ�̼��ۼ�Ʈ"
FROM employees
where salary<14000
and   salary>=10000
order by salary DESC;


/*
����6.
�μ���ȣ�� 10, 90, 100 �� >where in
������ �̸�, ����, �Ի���, �μ���ȣ�� ��Ÿ���ÿ� >select
�Ի����� 1977-12 �� ���� ǥ���Ͻÿ�. >to_char
*/
SELECT first_name "�̸�",
       salary "����",
       to_char(hire_date, 'yyyy-mm') "�Ի���",
       department_id "�μ���ȣ"
FROM employees
where department_id in (10, 90, 100); 


/*
����7.
�̸�(first_name)�� S �Ǵ� s �� ���� > where like
������ �̸�, ������ ��Ÿ���ÿ� >select
*/
SELECT first_name "�̸�",
       salary "����"
FROM employees
where first_name like '%S%'
OR    first_name like '%s%';


/*
����8.
��ü �μ��� ����Ϸ��� �մϴ�.
������ �μ��̸��� �� ������� ����� ������. >order by, length
*/
SELECT *
FROM jobs
ORDER BY length(job_title) DESC;


/*
����9.
��Ȯ���� ������, ���簡 ���� ������ ����Ǵ� ������� �����̸���>select
�빮�ڷ� ����ϰ� >select, upper
�ø�����(ASC)���� ������ ������. >order by
*/
SELECT upper(country_name) "�����"
FROM countries
where country_id in(
    SELECT country_id
    FROM locations
    where location_id in(
        SELECT location_id
        FROM departments
        )
    );


/*
����10.
�Ի����� 03/12/31 �� ���� �Ի��� >where
������ �̸�, ����, ��ȭ ��ȣ, �Ի����� ����ϼ��� >select
��ȭ��ȣ�� 545-343-3433 �� ���� ���·� ����Ͻÿ�. > to_char
*/
SELECT first_name "�̸�",
       salary "����",
       replace(phone_number,'.','-')"��ȭ��ȣ",
       hire_date
FROM employees
where hire_date < '03/12/31';