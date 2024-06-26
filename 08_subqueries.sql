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

/*범위주석*/

/*상관 서브쿼리*/
-- 메뉴별 각 메뉴가 속한 카테고리의 평균보다 높은 가격의 메뉴들만 조회(메인쿼리와 서브쿼리의 상관관계 활용)
-- 메인쿼리를 활용한 서브쿼리라면 상관서브쿼리라고 한다.
-- 1) 함수 이용해서 풀기
SELECT
		 AVG(menu_price)
  FROM tbl_menu
 WHERE category_code = 4;
-- 2)
SELECT
		 a.menu_code
	  , a.menu_name
	  , a.menu_price
	  , a.category_code
	  , a.orderable_status
  FROM tbl_menu a
 WHERE menu_price > (SELECT AVG(b.menu_price)
 							  FROM tbl_menu b
							 WHERE b.category_code = a.category_code);  -- 서브쿼리를 쓰는 이유, 안 그러면 일일이 카테고리 코드를 입력
-- 해석: 1번 테이블에서 첫 번째 메뉴를 하나 끄집어내고
--  그 메뉴의 가격이 서브쿼리 조건문에 알맞는지 확인
-- 조건문: 테이블 메뉴 1번째 행부터 코드를 확인하고 그 코드를 가진 메뉴들의
-- 평균 가격을 구하고 그 가격보다 비싼 메뉴의 '코드', '이름', '가격' 등을 조회해라

/*EXISTS*/
-- 키워드의 일종, 서브쿼리의 결과가 존재하는지 매번 체크할 수 있게 한다.
-- 결과가 하나라도 존재하면(한 행이라도 존재하면) true, 아니면 false
-- 카테고리 중에 메뉴에 부여된 카테고리들의 카테고리 이름 조회 후 오름차순 정렬
SELECT
		 category_name
  FROM tbl_category a
 WHERE EXISTS (SELECT menu_code
 					  FROM tbl_menu b
 					 WHERE b.category_code = a.category_code)
ORDER BY 1;