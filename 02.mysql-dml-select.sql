-- DML - SELECT
USE hrdb;
SELECT USER();
SELECT DATABASE();	--	선택된 DB 확인

-------------------
-- SELECT ~ FROM
-------------------
-- 테이블 구조 확인
DESCRIBE employees;
DESCRIBE departments;

-- 가장 기본적인 SELECT의 형태: 전체 데이터(모든 컬럼, 모든 레코드)
SELECT * FROM employees; -- 107 rows
SELECT * FROM departments; -- 27 rows
-- 테이블 내 정의된 모든 컬럼을 Projection
-- 순서는 테이블을 작성할 때 정의한 순서를 따른다

-- 특정 컬럼만 선별적으로 Projection 할 수 있다.
SELECT first_name FROM employees;
SELECT first_name, salary FROM employees;
-- Alias (별칭)
SELECT first_name 이름, salary 월급 FROM employees;
SELECT first_name AS 이름, salary AS 월급 FROM employees;

/*
연습문제
사원의 이름 (first_name), 전화번호, 입사일, 급여를 출력해 봅시다
*/
SELECT first_name, phone_number, hire_date, salary
FROM employees;
/*
연습문제
사원의 이름 (first_name), 성(last_name), 급여, 
	전화번호, 입사일을 출력해 봅시다
*/
SELECT first_name, last_name, salary,
	phone_number, hire_date
FROM employees;

-- 산술연산 : 기본적인 산술 연산을 사용할 수 있다.
SELECT 3.14159 * 10 * 10 FROM dual;
-- 특정 테이블이 아니라 데이터베이스 자체에 문의할 경우 DUAL
-- 특정 필드의 값을 수치로 산술 계산을 할 수 있음
SELECT first_name, salary, salary * 12 AS 연봉
FROM employees;

-- NULL
-- 비어있는 데이터
-- 어떠한 타입에서도 사용할 수 있다.
-- NOT NULL 컬럼, PK 컬럼에서는 사용할 수 없다.
SELECT first_name, salary, salary * NULL 
FROM employees;
-- NULL이 포함된 산술식의 결과는 항상 NULL
SELECT salary, ISNULL(salary * NULL)
FROM employees;
SELECT salary, NOT ISNULL(salary * NULL)
FROM employees;

-- 
SELECT first_name, salary, salary * 12 AS 연봉
FROM employees;
-- 커미션까지 포함한 최종 급여
SELECT first_name, salary, commission_pct,
	salary + salary * commission_pct 최종급여
FROM employees;

-- COALESCE or IFNULL
-- COALESCE (ANSI-SQL) : 주어진 인수 중, NULL이 아닌 첫 값
SELECT coalesce(NULL, NULL, "A", "B");

-- IFNULL (MySQL) : 두개의 인수 중 첫 값이 NULL이면 두번째 값

SELECT IFNULL(NULL, "대체값");

SELECT first_name,
	salary, commission_pct,
    salary + salary * IFNULL(commission_pct, 0)
FROM employees;

SELECT first_name,
	salary, commission_pct,
    salary + salary * COALESCE(commission_pct, 0)
FROM employees;

-- FULL Name과 salary
SELECT first_name + " " + last_name, salary
FROM employees;
-- 문자열을 합칠때는 concat 함수를 사용
SELECT CONCAT(first_name, " ", last_name) AS 이름
FROM employees;

-- DISTINCT
SELECT job_id FROM employees;	-- 107개
SELECT DISTINCT job_id FROM employees; -- 19개

------------------
-- WHERE
------------------
-- SELECTION을 위한 조건

-- 부서 번호가 10번이 부서 정보
SELECT * FROM departments;

SELECT * FROM departments
WHERE department_id = 10;

-- 급여가 15000이상인 사원의 목록을 출력
SELECT * FROM employees
WHERE salary >= 15000;

-- 입사일이 2008-01-01 이후인 사원들의 이름과 입사일을 출력
SELECT CONCAT(first_name, ' ', last_name) AS name,
	hire_date AS "입사일"
FROM employees
WHERE hire_date > '2008-01-01';

-- 급여가 14000이하이거나 17000이상인 사원의 이름과 급여

