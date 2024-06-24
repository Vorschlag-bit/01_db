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
 
 
 SELECT 
        *
  FROM tbl_menu
 WHERE menu_price <= 5000
    OR menu_price > 10000;
  
-- 10000원보다 크거나 5000원 이하인 메뉴 조회(OR)

