-- group by절
-- 메뉴가 존재하는 카테고리 그룹 조회
SELECT
		 category_code
  FROM tbl_menu
 GROUP BY category_code;
-- COUNT 함수 활용
SELECT
		 COUNT(*)   -- null값 상관없이 메뉴에 몇 개의 행이 있는지 알려줘
  FROM tbl_menu;
  
-- 그룹으로 묶지 않으면 전체 테이블에 해당되지 떄문에 하나의 행만 나온다.
-- 그룹을 묶고 그룹별 그룹함수를 적용시킨 값을 보여준다.

SELECT
		 COUNT(*)
	  , concat(a.category_code, '번 카테고리') AS '카테고리 번호'  -- concat은 단일행 함수이다
  FROM tbl_menu a
 GROUP BY a.category_code;  -- 그룹함수를 사용하고 select으로 그룹이 아닌 단일 컬럼을 보여주는 값을 넣으면 무의미하다.
 
-- count 함수
-- count(컬럼명 또는 *)
-- count(컬럼명) 해당 컬럼에 null이 아닌 행의 개수
-- count(*) 모든 행의 개수

SELECT
		 COUNT(*) AS '모든 카테고리 행'
	  , COUNT(ref_category_code) AS '상위 카테고리가 존재하는 카테고리'
  FROM tbl_category;
  

-- sum 함수 활용
SELECT
		 category_code
	  , SUM(menu_price)
  FROM tbl_menu
  GROUP BY category_code;
  
-- avg 함수 활용
SELECT
		 category_code
	  , floor(AVG(menu_price))  -- floor 바닥이라는 뜻, 소수점 버리기
  FROM tbl_menu
  GROUP BY category_code;
  
  
-- having 절
-- 그룹에 대한 조건 
SELECT
		 SUM(menu_price)
	  , category_code
  FROM tbl_menu
 GROUP BY category_code
--  having category_code BETWEEN 5 AND 9;
HAVING SUM(menu_price) >= 20000; -- 보통 이런 식으로 더 많이 씀

-- 하나 실습용
SELECT
		 SUM(menu_price) AS '메뉴합계'
 	  , a.category_code
  FROM tbl_menu a
  JOIN tbl_category b
 GROUP BY a.category_code
--  having category_code BETWEEN 5 AND 9;
HAVING SUM(menu_price) >= 20000 -- 보통 이런 식으로 더 많이 씀, having절은 주로 그룹 함수 또는 그룹 단위 조건
 ORDER BY '메뉴합계' DESC;
 
--  -----------------------------------------------
-- roll up(키워드)
-- group을 묶을 때 하나의 기준(하나의 컬럼)으로 그룹화하여 rollup을 하면
-- 총 합계의 개념이 나온다.
SELECT
		sum(menu_price)
	  , category_code
  FROM tbl_menu
 GROUP BY category_code
  WITH ROLLUP;
  
--  group을 묶을 때 여러 개의 기준(여러 개의 컬럼)으로 그룹화하여 roll up
SELECT
		 SUM(menu_price)
	  , menu_price
	  , category_code
  FROM tbl_menu
 GROUP BY menu_price, category_code
  WITH ROLLUP;