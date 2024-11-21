--------------------
-- DCL and DDL
--------------------
-- root 계정으로 수행

-- 사용자 생성
CREATE USER 'testuser'@'localhost' IDENTIFIED BY 'test';

-- 사용자 수정
ALTER USER 'testuser'@'localhost'
	IDENTIFIED BY 'abcd';
    
-- 사용자 삭제
DROP USER 'testuser'@'localhost';

-- 사용자 생성(다시)
CREATE USER 'testuser'@'localhost' 
	IDENTIFIED BY 'test';
    
-- 접속 후 계정 정보 확인
SELECT CURRENT_USER;

--------------------
-- GRANT / REVOKE
--------------------
-- 권한 (Privilege)
-- 특정 작업을 수행할 수 있는 권리

-- 권한을 부여하는 작업을 GRANT
-- 권한을 회수하는 작업을 REVOKE