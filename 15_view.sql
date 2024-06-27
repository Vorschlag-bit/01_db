/*view*/
-- view는 쿼리이며, 원본 table을 참조해서 보여주는 용도이며 자주 쓰이는 view는 query cached에 저장되어 나중에 그 쿼리가 똑같이 입력되면 풀스캔하지 않고 저장된 view를 보여준다
-- 보이는 건 실제 table(base table)의 값이다
-- DBA가 개발자에게 원본을 줄 수 없을 때, 별칭을 set할 때
-- object는 create와 drop 혹은 delete로 삭제한다.
-- table은 원본이므로 DBMS는 웬만하면 건들지 않는다.
-- 따라서 table을 활용한 가상의 table을 생성해서 사용자에게 보여주는 것이 view이다.
-- table은 실제 데이터를 갖고 있다면, view는 우리가 요구한 query만 갖고 있는 게 특징

SELECT
		 menu_name
	  , menu_price
  FROM tbl_menu;
-- view는 밑의 query만 저장하고 있다
-- 
CREATE OR REPLACE VIEW v_menu
AS
SELECT
		 menu_name '메뉴명'
	  , menu_price AS '메뉴단가'
  FROM tbl_menu;
DROP VIEW v_menu;
-- view의 목적 1. dba가 개발자에게 보여주고 싶은 데이터만 추출해서 보여주고 싶을 떄(DBA와 권한 차이를 둠)
-- 예) 신입 개발자한테 원본 table을 주는 위험을 피할 수 있다
-- 2. 보여지는 col을 쉽게 구분할 수 있다
-- view를 수정할 때마다 삭제하고 재생성하기 번거로우니 option을 제공한다(= replace)

-- 결과
SELECT *FROM v_menu;
  
-- oracle의 경우 with read only 구문을 마지막에 달아서 view를 통해 base table을 수정핤 수 없게 하지만
-- mariadb는 제공하지 않는다.

/*view를 통한 DML(연습으로만 쓸 것, 현업에선 매우 비추)*/
-- base table(tbl_menu) 조회
SELECT * FROM tbl_menu;

-- view crete
CREATE OR REPLACE VIEW hansik
AS
SELECT
		 menu_code
	  , menu_name
	  , menu_price
	  , category_code
	  , orderable_status
  FROM tbl_menu
WHERE category_code = 4;

-- 한식만 있는 가상 테이블 생성
SELECT * FROM hansik;

-- hansik이라는 view를 통해 tbl_menu라는 base table에 영향을 줌
INSERT
  INTO hansik
VALUES
(NULL, '식혜국밥', 5500, 4, 'N');

-- 진짜로 넣었는지 확인
SELECT * FROM tbl_menu ORDER BY menu_code desc; 

UPDATE hansik
   SET menu_name = '버터맛국밥'
     , menu_price = 6000
 WHERE menu_name = '식혜국밥';
 
-- view를 통해서 dml에 영향을 주지 않게 하는 방법
-- view는 subquery에 연산작업을 통해 차이를 줘서 오류를 유도해서 막을 수 있다
-- 3. 산술표현식이 정의된 경우
-- ex) create or replace view 'test'
-- 	 as select avg(menu_price) from tbl_menu;

-- dml 영향 안 주는 연습, 가공처리해서 원본이 모르게 하는 방법
CREATE OR REPLACE VIEW v_test
AS
SELECT
		 AVG(menu_price) + 3
  FROM tbl_menu;
  
SELECT * FROM v_test;

INSERT INTO v_test VALUES(10);