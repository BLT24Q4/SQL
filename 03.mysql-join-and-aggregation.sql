USE hrdb;

SELECT * FROM departments WHERE department_id=50;

--------------------
-- SET OPERATION
--------------------
SELECT CONCAT(first_name, ' ', last_name) AS full_name,
	salary, hire_date 
FROM employees
WHERE department_id = 80; -- 34
SELECT CONCAT(first_name, ' ', last_name) AS full_name,
	salary, hire_date
FROM employees
WHERE salary > 9000;	--	23 

SELECT CONCAT(first_name, ' ', last_name) AS full_name,
	salary, hire_date 
FROM employees
WHERE department_id = 80
UNION
SELECT CONCAT(first_name, ' ', last_name) AS full_name,
	salary, hire_date
FROM employees
WHERE salary > 9000;

SELECT CONCAT(first_name, ' ', last_name) AS full_name,
	salary, hire_date 
FROM employees
WHERE department_id = 50
UNION ALL
SELECT CONCAT(first_name, ' ', last_name) AS full_name,
	salary, hire_date
FROM employees
WHERE salary > 9000;
-- UNION ALL : 중복을 제거하지 않은 합집합

-- MySQL은 INTERSECT, EXCEPT는 지원하지 않음

--------------------
-- Simple Join or Equi Join
--------------------
SELECT * FROM employees;	--	107
SELECT * FROM departments;	--	27

SELECT first_name, department_name
FROM employees, departments;
--	카티전 프로덕트 (조합 가능한 모든 레코드의 쌍) - 107 * 27 

SELECT *
FROM employees, departments
WHERE employees.department_id 
		= departments.department_id;
-- 두 테이블을 연결(JOIN)해서 큰 테이블을 만듦
-- 이름, 부서 ID, 부서명
SELECT CONCAT(first_name, ' ', last_name) AS full_name,
	emp.department_id,
    dept.department_id,
    department_name
FROM employees emp, departments dept
WHERE emp.department_id 
	= dept.department_id;	-- 106
    
SELECT CONCAT(first_name, ' ', last_name) AS full_name,
	emp.department_id,
    dept.department_id,
    department_name
FROM employees emp JOIN departments dept
					USING (department_id); -- 조인 조건 필드

--------------------
-- OUTER JOIN
--------------------
-- 조건이 만족하는 짝이 없는 경우에도 NULL을 포함하여 결과를 출력
-- 모든결과를 표현할 테이블이 어느 위치에 있느냐에 따라
-- LEFT, RIGHT, FULL OUTER 조인으로 구분 

--------------------
-- LEFT OUTER JOIN
--------------------
SELECT first_name,
	emp.department_id,
    dept.department_id,
    department_name
FROM employees emp LEFT OUTER JOIN departments dept
						ON emp.department_id =
							dept.department_id;

--------------------
-- RIGHT OUTER JOIN
--------------------
SELECT first_name,
	emp.department_id,
    dept.department_id,
    department_name
FROM employees emp RIGHT OUTER JOIN departments dept
						ON emp.department_id =
							dept.department_id;
                            
--------------------
-- FULL OUTER JOIN
--------------------
-- MySQL은 FULL OUTER JOIN을 지원하지 않음
-- LEFT JOIN 결과와 RIGHT JOIN 결과를 UNION 연산해서
-- FULL OUTER JOIN을 구현할 수 있음
SELECT
	employee_id,
    CONCAT(first_name, ' ', last_name) AS full_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM
	employees emp LEFT OUTER JOIN departments dept
					ON emp.department_id =
						dept.department_id
UNION
SELECT
	employee_id,
    CONCAT(first_name, ' ', last_name) AS full_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM
	employees emp RIGHT OUTER JOIN departments dept
					ON emp.department_id =
						dept.department_id;
                        
--------------------
-- SELF JOIN
--------------------
-- 자기 자신과 JOIN
-- 자기 자신을 두번 이상 호출하므로, 별칭을 사용할 수 밖에 없음
SELECT emp.employee_id,
	emp.first_name,
    emp.manager_id,
    man.employee_id,
    man.first_name
FROM 
	employees emp JOIN employees man
				ON emp.manager_id = man.employee_id;

SELECT * FROM employees;

SELECT emp.employee_id,
	emp.first_name,
    emp.manager_id,
    man.employee_id,
    man.first_name
FROM employees emp
	LEFT OUTER JOIN employees man
		ON emp.manager_id = man.employee_id;

