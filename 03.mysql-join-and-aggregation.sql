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

--------------------
-- Aggregation (집계)
--------------------
-- 여러 행의 데이터를 입력으로 받아서 하나의 행을 반환
-- NULL이 포함된 데이터는 NULL을 제외하고 집계

-- 갯수 세기 : count
SELECT COUNT(*), COUNT(commission_pct), 
	COUNT(department_id)
FROM employees;

-- *로 카운트하면 모든 행의 수, 특정 컬럼에 null 포함여부는 
-- 중요하지 않음
SELECT COUNT(commission_pct)
FROM employees;

-- 위 쿼리는 아래와 같은 의미
SELECT COUNT(*)
FROM employees
WHERE commission_pct IS NOT NULL;

-- 합계 함수 : SUM
-- 사원들의 월급의 총합은 얼마?
SELECT SUM(salary) 
FROM employees;

-- 평군 함수 : AVG
-- 사원들의 월급의 평균은 얼마?
SELECT AVG(salary)
FROM employees;	--	22.2%

-- 사원들이 받는 커미션 비율의 평균치는?
SELECT AVG(commission_pct)
FROM employees;

SELECT COUNT(commission_pct)
FROM employees;
-- 집계 함수는 null을 제외하고 집계
-- NULL을 변환하여 사용해야 할지의 여부를 정책적으로 결정하고 수행해야 함 

SELECT AVG(IFNULL(commission_pct, 0))
FROM employees;	--	7%

-- min / max
-- 월급의 최소값, 최대값, 평균
SELECT MIN(salary), MAX(salary), AVG(salary)
FROM employees;

-- 부서별로 평균 급여를 확인
SELECT department_id, AVG(salary)
FROM employees;

-- 안됨 : Why?
SELECT department_id FROM employees
ORDER BY department_id;

SELECT AVG(salary) FROM employees;

-- 수정된 쿼리
SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id
ORDER BY department_id;

SELECT department_id, salary
FROM employees
ORDER BY department_id ASC;

-- 평균 급여가 7000 이상인 부서만 출력
SELECT department_id, AVG(salary)
FROM employees
WHERE AVG(salary) >= 7000
GROUP BY department_id;	--	Error! Why?
-- 집계 함수 실행 이전에 Where 절을 이용한 Selection이 이루어짐
-- 집계 함수는 WHERE 절에서 활용할 수 없는 상태
-- 집계 이후에 조건 검사를 하려면 HAVING 절을 활용

SELECT department_id, AVG(salary)	-- (5)
FROM employees						-- (1)
GROUP BY department_id				-- (2)
	HAVING AVG(salary) >= 7000		-- (3)
ORDER BY department_id;				-- (4)