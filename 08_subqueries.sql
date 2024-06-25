-- subqueries

-- '민트 미역국'의 카테고리 번호 조회(서브쿼리 개념)
SELECT * FROM tbl_menu;

SELECT
		 category_code
  FROM tbl_menu
 WHERE menu_name = '민트미역국';
 
--  '민트 미역국'과 같은 카테고리의 메뉴를 조회(메인쿼리 개념)
SELECT
		 menu_name
-- 	  , category_code
  FROM tbl_menu
 WHERE category_code = (SELECT category_code    -- from절에 쓰는 서브 쿼리 = 인라인 뷰
 								  FROM tbl_menu
 								 WHERE menu_name = '민트미역국');
--  WHERE category_code = 4; 위 쿼리문을 통해 알고 두 번 째 쿼리를 통해 해결하는 방법


-- 서브쿼리의 종류
-- 1) 다중행 다중열 서브쿼리
SELECT
		 *
  FROM tbl_menu;
-- 2) 다중행 단일열 서브쿼리
SELECT
		 menu_name
  FROM tbl_emnu;
-- 3) 단일행 다중열 서브쿼리
SELECT
		 *
  FROM tbl_menu
 WHERE menu_name = '우럭스무디';
-- 4) 단일행 단일열 서브쿼리
SELECT
		 category_code
  FROM tbl_menu
 WHERE menu_name = '우럭스무디';
 
-- 가장 많은 메뉴가 포함된 카테고리에 메뉴 개수(count(), max())
-- 1. 카테고리별 메뉴개수 추출
-- 2. '별'을 본 순간 group by + count를 사용해서 해결
-- 아래가 서브 쿼리다
SELECT
-- 		 category_code AS '카테고리 종류'
	    COUNT(*) AS '카테고리별 메뉴 개수'
  FROM tbl_menu
 GROUP BY category_code;
 
 SELECT
 		 MAX(a.count) -- group by 안 써도 쓸 수 있다. from 전체를 하나로 보고 쓴다고 생각
 	  , a.category_code
   FROM (SELECT COUNT(*) AS count
   			  , category_code
    		  FROM tbl_menu
 			 GROUP BY category_code) a;
 			 
-- 선행해서 쿼리에서 동작해야 할 쿼리를 서브쿼리로 작성한다.
-- mariadb에선 서브쿼리를 from절에서 사용 시 '인라인 뷰'라고 하며 
-- 반드시 별칭을 달아야 함(서브 쿼리를 하나의 테이블로 취급하려면) (-> a)
-- 서브쿼리의 그룹함수의 결과를 메인쿼리에서 쓰기 위해선 마찬가지로 별칭을 써야한다. (-> count)