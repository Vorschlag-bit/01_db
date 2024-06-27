/*contraint*/
/*1. not null 제약 조건*/
-- null값을 포함할 수 없는 col에 대한 제약조건이자 col level에서만
-- 제약조건 추가 가능
DROP TABLE if EXISTS user_notnull;
CREATE TABLE if NOT EXISTS user_notnull (
  user_no INT NOT NULL,
  user_id VARCHAR(255) NOT NULL,
  user_pw VARCHAR(255) NOT NULL,
  user_name VARCHAR(255) NOT NULL,
  gender VARCHAR(3),   -- 기본 default로 nullable로 되어있다.
  phone VARCHAR(255) NOT NULL,
  email VARCHAR(255),
) ENGINE = INNODB;

INSERT
  INTO user_notnull
(user_no, user_id, user_pw, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
(2, 'user02', 'pass02', '유관순', 'du', '010-777-7777', 'yu77@gmail.com');

INSERT
  INTO user_notnull
(user_no, user_id, user_pw, user_name, gender, phone, email)
VALUES
(3, 'user03', 'pass03', null, '남', '010-1234-5578', 'go123@gmail.com');

/*2. unique 제약 조건*/
-- 중복값이 들어가지 않도록 하는 제약조건
-- col level 및 table level 모두 가능
CREATE TABLE if NOT EXISTS user_unique (
  user_no INT NOT NULL unique,
  user_id VARCHAR(255) NOT NULL,
  user_pw VARCHAR(255) NOT NULL,
  user_name VARCHAR(255) NOT NULL,
  gender VARCHAR(3),
  phone VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  UNIQUE(phone)
) ENGINE = INNODB;

INSERT
  INTO user_unique
(user_no, user_id, user_pw, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
(2, 'user02', 'pass02', '유관순', 'du', '010-777-7777', 'yu77@gmail.com');

INSERT
  INTO user_unique
(user_no, user_id, user_pw, user_name, gender, phone, email)
VALUES
(3, 'user03', 'pass03', null, '남', '010-1234-5578', 'go123@gmail.com');

/*3. primary key 제약조건*/
-- not null + unique 제약조건이라고 볼 수 있다
-- 모든 table은 반드시 primary key를 가진다(식별자)(pk는 2개 이상의 constarint를 가지지 못 한다)
CREATE TABLE if NOT EXISTS user_pk (
  user_no INT,
  user_id VARCHAR(255) NOT NULL,
  user_pw VARCHAR(255) NOT NULL,
  user_name VARCHAR(255) NOT NULL,
  gender VARCHAR(3),
  phone VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  UNIQUE(phone),
  PRIMARY KEY(user_no)
) ENGINE = INNODB;
DESC user_pk;
INSERT
  INTO user_pk
(user_no, user_id, user_pw, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
(2, 'user02', 'pass02', '유관순', 'du', '010-777-7777', 'yu77@gmail.com');

-- pk 테스트
INSERT
  INTO user_pk
(user_no, user_id, user_pw, user_name, gender, phone, email)
VALUES
(1, 'user032', 'pass032', 'pk', '남', '010-1234-5578', 'go123@gmail.com');


/*4. foreign key constraint*/
-- 4-1. 회원 등급 부모 table 먼저 생성
-- 부모 테이블은 1, 자식 테이블은 n으로 일 대 다 카디널리티가 생성되야 한다
-- 부모 테이블은 항상 자식 테이블보다 선행해야 한다
-- 부모의 pk는 항상 자식의 fk로 작동해야 한다.
-- 다 대 다(m:n)관계는 일 대 다 혹은 다 대 일로 바꿔야 한다
-- 해결법: 두 테이블을 합쳐서 새로운 테이블을 형성한다. 그렇게 되면 합친 테이블이 n이 되고 각 테이블은 1이 된다.
DROP TABLE if EXISTS user_grade;
CREATE TABLE if NOT EXISTS user_grade (
  grade_code INT NOT NULL UNIQUE,
  grade_name VARCHAR(255) NOT NULL
);

-- 4-2. 회원용 자식 테이블을 이후에 생성
CREATE TABLE if NOT EXISTS user_fk1 (
  user_no INT PRIMARY KEY,
  user_id VARCHAR(255) NOT NULL,
  user_pw VARCHAR(255) NOT NULL,
  user_name VARCHAR(255) NOT NULL,
  gender VARCHAR(3),
  phone VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  grade_code INT,     -- 위 부모테이블과 반드시 일치해야 한다(user_fk1.grade_code)
  FOREIGN KEY(grade_code) REFERENCES user_grade(grade_code)  -- 반드시 다른 table의 pk를 참조해야 한다.
) ENGINE = INNODB;

INSERT
  INTO user_grade
VALUES
(10, '일반회원'),
(20, '우수회원'),
(30, '특별회원');  -- 참조 안 한 부모의 pk는 지우기 가능

INSERT
  INTO user_fk1
VALUES
(1, 'user01', 'pass01', '고경표', '남', '010-447-7775', 'go774@naver.com', 10),
(2, 'user02', 'pass02', '김연아', '여', '010-445-5555', 'kim24@naver.com', 30);

-- 등급이 null일 경우 통과가 되는지 테스트 (부모의 pk값 혹은 null값이 들어갈 수 있다)
INSERT
  INTO user_fk1
VALUES
(3, 'user01', 'pass01', '고경표', '남', '010-447-7775', 'go774@naver.com', NULL);
SELECT * FROM user_fk1;

-- 부모 table에 없는 값을 줄 때 통과가 되는지 테스트 (못 들어간다)
INSERT
  INTO user_fk1
VALUES
(4, 'user02', 'pass02', '김연아', '여', '010-445-5555', 'kim24@naver.com', 50);
-- 만약 등급이 사라지면 1. 등급값을 null로 바꾼다 2. 자식테이블 칼럼을 삭제한다

-- 참조 중인 pk 지우기(못 함)
DELETE
  FROM user_grade
 WHERE grade_code = 10;
 
-- 참조 안 하는 pk 지우기(가능) 20지움
 DELETE
  FROM user_grade
 WHERE grade_code = 20;
 
--  4-3. 삭제rule을 적용한 fk 제약조건 연습
CREATE TABLE if NOT EXISTS user_fk2 (
  user_no INT PRIMARY KEY,
  user_id VARCHAR(255) NOT NULL,
  user_pw VARCHAR(255) NOT NULL,
  user_name VARCHAR(255) NOT NULL,
  gender VARCHAR(3),
  phone VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  grade_code INT,     
  FOREIGN KEY(grade_code) REFERENCES user_grade(grade_code)
  ON DELETE SET NULL -- on delete: 만약 참조하던 게 사라지면 null값으로 설정
) ENGINE = INNODB;

-- 부모 테이블을 참조하는 컬럼값 추가
INSERT
  INTO user_fk2
VALUES
(1, 'user02', 'pass02', '김연아', '여', '010-445-5555', 'kim24@naver.com', 10);

-- 현재 회원 참조 컬럼값 확인
SELECT * FROM user_fk2;

-- 삭제되면 grade_code가 null로 바뀌었는지 확인(DELETE RULE)
DELETE FROM user_grade WHERE grade_code = 10;
SELECT * FROM user_fk2;


-- 참조하는 부모 테이블의 행 삭제 후 참조 컬럼 값 확인
DELETE FROM user_grade WHERE grade_code = 10;
SELECT * FROM user_fk2;

/*check 제약조건(조건식 활용)*/
DROP TABLE if EXISTS user_check;
CREATE TABLE if NOT EXISTS user_check (
  user_no INT AUTO_INCREMENT PRIMARY KEY,
  user_name VARCHAR(255) NOT NULL,
  gender VARCHAR(3) CHECK(GENDER IN ('남', '여')),
  age INT CHECK(age >= 19)
) ENGINE = INNODB;

INSERT
  INTO user_check
VALUES
(NULL, '홍길동', '남', 25),
(NULL, '고길동', '남', 45);

SELECT * FROM user_check;

-- 성별에 잘못된 값 입력
INSERT
  INTO user_check
VALUES
(NULL, '아메바', '?', 19);

INSERT
  INTO user_check
VALUES
(NULL, '유관순', '여', 16);

/*default 제약조건*/
CREATE TABLE if NOT EXISTS tbl_country (
  country_code INT AUTO_INCREMENT PRIMARY KEY,
  country_name VARCHAR(255) DEFAULT '한국',
  population VARCHAR(255) DEFAULT '0명',
  add_day DATE DEFAULT (CURRENT_DATE),
  add_time DATETIME DEFAULT (current_time)
) ENGINE = INNODB;

INSERT
  INTO tbl_country
VALUES
(NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

SELECT * FROM tbl_country; -- 여기서 시간의 기본값은 데이터서버가 있는 곳 기준이다.

-- DDL의 내용과 비슷(constraint)
