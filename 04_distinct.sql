-- distinct

SELECT
		 category_code
  FROM tbl_menu
 ORDER BY category_code;
 
 SELECT
 		  DISTINCT category_code
   FROM tbl_menu
 ORDER BY category_code;
 
--  상위 카테고리 조회하기 (카테고리값이 nuill인)
--  where절 사용
SELECT
		  *
  FROM tbl_category
 WHERE ref_category_code IS NULL;
 
--  2) 아래 코드를 통해 카테고리의 상위 카테고리 번호를 알 수 있다.
 SELECT
 		  DISTINCT ref_category_code
--  	  ,  category_name AS '카테고리명'
   FROM tbl_category
  WHERE ref_category_code IS NOT NULL;
  
--  추후 배울 예정이지만 서브 쿼리를 활용하면 하나의
--  쿼리를 작성할 수 있다.

SELECT
		 *
  FROM tbl_category
 WHERE ref_category_code IN (SELECT DISTINCT ref_category_code
 										 FROM tbl_category
										WHERE ref_category_code IS NOT NULL
										);
										
--  다중열 distinct

SELECT
		  category_code
	  ,  orderable_status
  FROM tbl_menu;
  
-- 카테고리값과 주문상태가 모두 같은 애들을 중복 제거 처리
SELECT
		  DISTINCT
		  category_code
	  ,  orderable_status
  FROM tbl_menu