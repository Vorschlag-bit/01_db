/*set operator*/
-- set = 집합: 공통 부분을 제거한다는 의미
-- join과 operator의 차이 반드시 알아두기
/*UNION*/
-- 교집합을 제외하고 합집합을 표현
-- 교집합 = intersaction
SELECT
		 menu_code
	  , menu_name
	  , menu_price
	  , category_code
	  , orderable_status
  FROM tbl_menu
 WHERE category_code = 10
UNION -- all 붙이면 교집합 중복되게 표현(5행 중복되서 15행)
SELECT
   	 menu_code
	  , menu_name
	  , menu_price
	  , category_code
	  , orderable_status
  FROM tbl_menu
 WHERE menu_price < 9000;

/*intersect*/
-- mysql과 mariadb는 intersact가 공식적으로 지원되지 않는다.
-- 1) inner join 활용
-- 내 해석: a테이블(카테고리 코드가 10)과 c테이블(가격이 9000초과)을 join한다.
-- join 기준을 메뉴코드이며
SELECT
		 a.menu_code
	  , a.menu_name
	  , a.menu_price
	  , a.category_code
	  , a.orderable_status
  FROM tbl_menu a
 INNER JOIN (SELECT b.menu_code
	               , b.menu_name
	               , b.menu_price
	               , b.category_code
	               , b.orderable_status
	            FROM tbl_menu b
	           WHERE b.menu_price < 9000) c ON (a.menu_code = c.menu_code)
 WHERE a.category_code = 10; -- 인라인뷰
 
-- 2) in 연산자 활용
SELECT
       a.menu_code
	  , a.menu_name
	  , a.menu_price
	  , a.category_code
	  , a.orderable_status
  FROM tbl_menu a
 WHERE a.category_code = 10
   AND a.menu_code IN (SELECT b.menu_code    -- 여기서 in은 사실상 '='의 의미를 갖는다.
								 FROM tbl_menu b
								WHERE b.menu_price < 9000);
								
/*minus*/
SELECT
		 a.menu_code
	  , a.menu_name
	  , a.menu_price
	  , a.category_code
	  , a.orderable_status
  FROM tbl_menu a
 LEFT JOIN (SELECT b.menu_code
	               , b.menu_name
	               , b.menu_price
	               , b.category_code
	               , b.orderable_status
	            FROM tbl_menu b
	           WHERE b.menu_price < 9000) c ON (a.menu_code = c.menu_code)
 WHERE a.category_code = 10
   AND c.menu_code IS NULL;  -- a테이블(카테고리 코드가 10))과 c테이블(가격 9000미만)
									  -- a테이블 기준으로 조인한다. 조인 기준은 메뉴코드
									  -- 단 맵핑되지 않은 행들(= c테이블에 없는 코드를 갖는 a테이블행)만 조회