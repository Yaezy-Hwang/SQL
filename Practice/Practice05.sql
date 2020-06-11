--혼합 SQL 문제입니다.
/*
문제1.
담당 매니저가 배정되어있으나
커미션비율이 없고,
월급이 3000초과인 직원의 
이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요.
(45건)
*/
SELECT
    first_name || ' ' || last_name "이름",
    manager_id "매니저아이디",
    commission_pct "커미션비율",
    salary "월급"
FROM
    employees
WHERE
    manager_id is not null
    and commission_pct is null
    and salary > 3000;

/*
문제2. 
각 부서별로 최고의 급여를 받는 사원의
직원번호(employee_id), 이름(first_name), 급여(salary), 입사일(hire_date), 전화번호(phone_number), 부서번호(department_id) 를 조회하세요 
-조건절비교 방법으로 작성하세요
-급여의 내림차순으로 정렬하세요
-입사일은 2001-01-13 토요일 형식으로 출력합니다.
-전화번호는 515-123-4567 형식으로 출력합니다.
(11건)
*/
SELECT
    employee_id "직원번호",
    first_name "이름",
    salary "급여",
    to_char(hire_date, 'yyyy-mm-dd') "입사일",
    replace(phone_number, '.', '-') "전화번호",
    department_id "부서번호"
FROM
    employees
WHERE
    (department_id, salary) in
        (SELECT department_id,
                max(salary)
        FROM employees
        GROUP BY department_id)
ORDER BY
    salary asc;

/*
문제3
매니지별로 평균급여 최소급여 최대급여를 알아보려 한다.
-통계대상(직원)은 2005년 이후 입사자입니다.
-평균급여가 5000이상인 매니저만 출력합니다.
-매니저별 평균 급여는 소수점 첫째자리에서 반올림합니다.
-출력내용은 매니저아이디, 매니저이름(first_name), 매니저별평균급여, 매니저별최소급여, 매니저별 최대급여입니다.
(9건)
*/
SELECT
    mng_out.mngid "매니저아이디",
    mng_out.mngname "매니저이름",
    round(avg(em_out.salary),0) "매니저별평균급여",
    min(em_out.salary) "매니저별최소급여",
    max(em_out.salary) "매니저별최대급여"      
FROM
    employees em_out,
    (SELECT
        em.employee_id emid,
        ma.first_name mngname,
        ma.employee_id mngid,
        ma.salary masal
    FROM
        employees em,
        employees ma
    WHERE
        em.manager_id = ma.employee_id
        and em.hire_date>'05/01/01') mng_out
WHERE
    em_out.employee_id = mng_out.emid
GROUP BY
    mng_out.mngname,
    mng_out.mngid
HAVING
    avg(em_out.salary) >= 5000
ORDER BY
    avg(em_out.salary) DESC;



/*
문제4.
각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명(department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
부서가 없는 직원(Kimberely)도 표시합니다.
(106명)
*/
SELECT
    em.employee_id "사번",
    em.first_name "이름",
    em.department_id "부서명",
    mng.first_name "매니저이름"
FROM
    employees em,
    employees mng
 WHERE
    em.manager_id = mng.employee_id;

/*
문제5.
2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의 
사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요
*/
SELECT
    employee_id "사번",
    first_name || ' ' || last_name "이름",
    salary "급여",
    hire_date "입사일"
FROM(
    SELECT
        rownum no,
        employee_id,
        first_name,
        last_name,
        salary,
        hire_date
    FROM
        (SELECT
            employee_id,
            first_name,
            last_name,
            salary,
            hire_date
        FROM employees
        ORDER BY hire_date asc))
WHERE no between 11 and 20;


/*
문제6.
가장 늦게 입사한 직원의 이름(first_name last_name)과 연봉(salary)과 근무하는 부서 이름(department_name)은?
*/ 
SELECT
    em.first_name || ' ' || em.last_name "막내이름",
    em.salary "막내연봉",
    de.department_name
FROM
    employees em,
    departments de
WHERE
    em.department_id = de.department_id
    and hire_date =
        (select max(hire_date)
        from employees);

/*
문제7.
평균연봉(salary)이 가장 높은 부서 직원들의
직원번호(employee_id), 이름(firt_name), 성(last_name)과  업무(job_title), 연봉(salary)을 조회하시오.
*/ 
SELECT
    em.employee_id,
    em.first_name,
    em.last_name,
    jo.job_title,
    em.salary
FROM
    employees em left outer join jobs jo
    on em.job_id = jo.job_id
where
    em.department_id in
        (select department_id
        from employees
        where salary in
            (select max(salary)
            from employees));

/*
문제8.
평균 급여(salary)가 가장 높은 부서는? 
*/
SELECT
    de_name
FROM
    (SELECT
        rownum no,
        de_name,
        salary
    FROM
        (SELECT
            de.department_name de_name,
            avg(em.salary) salary
        FROM
            departments de,
            employees em
        WHERE
            de.department_id = em.department_id
        GROUP BY
            de.department_name
        ORDER BY avg(em.salary) desc))
WHERE no = 1;


/*
문제9.
평균 급여(salary)가 가장 높은 지역은? 
*/ 
SELECT
    name
FROM
    (SELECT
        rownum no,
        name,
        salary
    FROM
        (SELECT
            re.region_name name,
            avg(em.salary) salary
        FROM
            regions re,
            countries co,
            locations lo,
            departments de,
            employees em
        WHERE
            re.region_id = co.region_id
            and co.country_id = lo.country_id
            and lo.location_id = de.location_id
            and de.department_id = em.department_id
        GROUP BY re.region_name
        ORDER BY avg(em.salary) desc))
WHERE no = 1;


/*
문제10.
평균 급여(salary)가 가장 높은 업무는? 
*/ 
--1번
SELECT
    job_title
FROM
    (SELECT
        rownum no,
        job_title,
        salary
    FROM
        (SELECT
            jo.job_title job_title,
            avg(em.salary) salary
        FROM
            jobs jo,
            employees em
        WHERE
            jo.job_id = em.job_id
        GROUP BY
            jo.job_title
        ORDER BY avg(em.salary) desc))
WHERE no = 1;

--2번
SELECT
    jo.job_title
FROM
    jobs jo,
    (SELECT
        avg(salary) salary,
        job_id
    FROM
        employees
    group by job_id) avgsal,
    (SELECT
        max(avg(salary))salary
     FROM
        employees
    GROUP by job_id) maxsal
where
    avgsal.salary =  maxsal.salary
    and jo.job_id = avgsal.job_id;