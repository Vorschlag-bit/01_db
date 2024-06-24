--  where 절
-- 주문 가능한 메뉴만 조회(메뉴이름, 메뉴가격, 주문가능상태)
SELECT * FROM tbl_menu;

SELECT
       menu_name
     , menu_price
     , orderable_status
  FROM tbl_menu
  WHERE orderable_status = 'Y';
--  where orderable_status = 'n';
-- 보고자 하는 속성이 매우 많을 때(desc를 통해 column 명 빠르게 확인)
DESC tbl_menu;  -- 속성 종류를 한 번에 보여준다(자료형, 키 등등)

-- -----------------------------------------------------------------------
-- '기타' 카테고리에 해당하지 않는 메뉴를 조회
-- 1) 카테고리명이 '기타'인 카테고리는 카테고리 코드가 10번이다.
SELECT
       *
  FROM tbl_category
  WHERE category_name = '기타'; -- !=을 쓰거나 <> <- 같지 않음
  
-- 2) 카테고리 코드가 10번이 아닌 메뉴 조회
SELECT
       *
  FROM tbl_menu
 WHERE category_code != 10;
-- where절은 조건을 나타내는데, 같은지(=), 같지 않은지(!=, <>)을 활용할 수 있다.
-- 뿐만 아니라 대소 비교(>, <, >=, <=)를 통해서 where절에 활용 가능

SELECT
       *
  FROM tbl_menu
 WHERE menu_price >= 5000 
   AND menu_price < 7000 -- python을 제외한 프로그래밍 언어는 '2항' 연산만 가능하다! 따라서 sql문법도 2항 연산.
 ORDER BY menu_price;  -- 메뉴테이블에서 메뉴 가격이 5000원 이상이면서 7000원 미만인 값을 오름차순으로 정렬.
 
 -- 10000원보다 크거나 5000원 이하인 메뉴 조회(OR)
SELECT 
        *
  FROM tbl_menu
 WHERE menu_price <= 5000
    OR menu_price > 10000;
  
-- --------------------------------------------------------------------
SELECT
       menu_code
     , menu_name
	  , menu_price
	  , category_code
	  , orderable_status 
  FROM tbl_menu
 WHERE menu_price > 5000
    OR category_code = 10
 ORDER BY menu_price;
 
--  -------------------------------------------------------------------
-- between 연산자 활용하기
-- 가격이 5000원 이상이면서 9000원 이하인 메뉴 절체 column 조회
SELECT
       *
  FROM tbl_menu
 WHERE menu_price BETWEEN 5000 AND 9000 -- 5000 이상 9000 이하(초과, 미만은 between 문법 사용 불가)
 ORDER BY menu_price;                   -- 굳이 굳이 한다면 between 5000 and 9000 and menu_price != 9000(아님 그냥 8999)
 
--  반대범위 테스트
SELECT
       *
  FROM tbl_menu
 WHERE menu_price NOT BETWEEN 5000 AND 9000;  -- 5000미만 9000 초과 not 위치는 'menu_price' 앞에 붙여도 상관은 없다.
 
--  ------------------------------------------------------------------

-- like문(토글 버튼을 형성하고 검색어를 입력할 때 완전히 데이터와 일치하지 않아도(검색어가 포함만 되도) 결과로 나오게끔 하는 것.
-- 제목, 작성자 등을 검색할 때 사용
SELECT
       *
  FROM tbl_menu
 WHERE menu_name LIKE '%밥%'; -- (와일드카드, %밥: ~~~밥, 밥%: 밥~~~) <= 조건절 핵심 명령어
 
--  ----------------------------------------------------------------
SELECT
       *
  FROM tbl_menu
 WHERE menu_name NOT LIKE '%밥%'; -- 반대상황: '밥' 안 들어가는 메뉴만
 
-- -----------------------------------------------------------------
-- in 연산자(조건절을 돕는 연산자)
SELECT
       *
  FROM tbl_menu
 WHERE category_code = 5
    OR category_code = 8
	 OR category_code = 10;  -- 9행
-- 위 쿼리를 단순화시킬 수 있게 해준다
 SELECT
       *
  FROM tbl_menu
 WHERE category_code IN (5, 8, 10); -- 9행, 괄호 값 중 하나라도 만족한다면 select해라
-- where category_code not in (5, 8, 10); 5 8 10빼고 다 조회하자 = 12행

-- -----------------------------------------------------------------
-- 컬럼 안이 null인 값만 조회하는 방법(= null로 쓸 수 없음)
-- is null 연산자 활용
SELECT 
       *
  FROM tbl_category
--  WHERE ref_category_code = NULL; -- 안 나온다
 WHERE ref_category_code IS NULL;   -- is not null이면 채워진 컬럼만 조회