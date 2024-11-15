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
