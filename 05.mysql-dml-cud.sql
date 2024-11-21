--------------------
-- CUD
--------------------
USE test_db;
DESC author;

-- 테이블 비우기
TRUNCATE author;

-- INSERT : 테이블에 새 데이터를 추가 (CREATE)
-- 데이터를 넣을 컬럼을 지정하지 않으면 전체 데이터를 제공해야 함
INSERT INTO author 
VALUES(1, '박경리', '토지 작가');

SELECT * FROM author;

-- 특정 컬럼의 내용만 입력할 때는 컬럼 목록 지정
-- author의 author_id는 PK AUTO_INCREMENT기 때문에 직접 입력하지 않아도 된다
INSERT INTO author (author_id, author_name)
VALUES(2, '김영하'); 

SELECT * FROM author;

INSERT INTO author 
VALUES(3, '무명씨', '그냥 작가');

-- UPDATE
UPDATE author SET author_desc='알쓸신잡 출연'
WHERE author_id=2;

SELECT * FROM author;

-- 주의: UPDATE, DELETE는 WHERE절을 이용 변경 조건을 부여해야 한다