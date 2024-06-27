/*DDL(Data Definition Language*/
CREATE TABLE if NOT EXISTS tb1 (
 pk INT PRIMARY KEY,
 fk INT,
 col1 VARCHAR(255),            
 CHECK(col1 IN ('Y', 'N')) -- 제약조건
)ENGINE = INNODB;

-- 존재하는 table을 요약해서 보고 싶다면 describe 키워드 가능
DESC tb1;

INSERT
  INTO tb1
VALUES
(
  1, 2, 'Y'
);

/*auto_increment*/
-- 값을 기억하는 번호 발생기
-- DROP TABLE tb2; table 삭제구문
CREATE TABLE tb2 (
	pk INT PRIMARY KEY AUTO_INCREMENT,
	fk INT,
	col1 VARCHAR(255),
	CHECK(col1 IN ('Y', 'N'))	
) ENGINE = INNODB;

DESC tb2;

INSERT
  INTO tb2
VALUES
(
  NULL
, 2
, 'N'
);

SELECT * FROM tb2;  -- select해서 조회된다고 안심하면 안 된다, commit을 반드시 해야 진짜 db에 반영
ROLLBACK;

/*alter*/
-- 없던 col 만들고, 수정하고 새로운 제약조건까지 걸 수 있다.
-- 컬럼 건드리기
ALTER TABLE tb2 ADD col2 INT NOT NULL;
DESC tb2;

-- col 삭제
ALTER TABLE tb2 DROP COLUMN col2;

-- col 이름 및 col 정의 변경
ALTER TABLE tb2 CHANGE COLUMN fk change_fk INT NOT NULL;

-- 제약조건 제거(pk 제약조건 제거 연습)
ALTER TABLE tb2 DROP PRIMARY KEY;  -- auto incre있으면 pk삭제 불가

-- auto_increment부터 제거(drop이 아닌 modify)
ALTER TABLE tb2 MODIFY pk INT;

-- 다시 pk 제거
ALTER TABLE tb2 drop PRIMARY KEY;
DESC tb2;

/*truncate*/ -- 절삭(메모리 차지하는 걸 싹 비우기)
-- truncate vs delete
-- table의 데이터(데이터 및 관련 제약조건 등 다 제거)
-- table 초기화(table 을 처음 만들 때로 되돌림)
CREATE TABLE if NOT EXISTS tb3 (
  pk INT AUTO_INCREMENT,
  fk INT,
  col1 VARCHAR(255) CHECK(col1 IN ('Y','N')),
  PRIMARY KEY(pk)
);

DESC tb3;

SELECT * FROM tb3;

TRUNCATE TABLE tb3;


DROP TABLE tb3;

CREATE TABLE if NOT EXISTS tb3 (
  pk INT,
  fk INT,
  col1 VARCHAR(255) CHECK(col1 IN ('Y', 'N'))
);

INSERT
  INTO tb3
VALUES
(
  1, 2, 'Y'
);
SET autocommit = 0;
SELECT * FROM tb3;

TRUNCATE tb3;
ROLLBACK;
DELETE FROM tb3;