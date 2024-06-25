-- join 없이 별칭 작성
-- alias(별칭)
-- 별칭은 알파벳처럼 순서가 있는 이름으로 달아서 조인의 순서를 파악할 수 있게 한다.
-- 컬럼에 별칭을 다는 것 외에도 from절에 작성되는 것들에도 별칭 추가 가능.
-- 테이블 또는 from 절에 별칭을 추가할 때는 싱글퀘테이션 AS는 생략이 가능하다!!
-- 하나의 테이블을 조회하더라도 별칭달기 > 다른 테이블이라도 같은 속성이 있을 수 있으니까

SELECT
		 a.category_code
	  , a.menu_name
  FROM tbl_menu AS a   
 ORDER BY category_code, menu_name;
 
--  inner join
-- 1) on을 활용
SELECT
		 a.menu_name
	  , b.category_name
	  , a.category_code
  FROM tbl_menu a
--  INNER JOIN tbl_category b ON a.category_code = b.category_code; -- join순서: 나는 메뉴를 보고 싶은데 카테고리도 보고 싶어(만약 반대라면 from이 카테고리)
-- inner join은 워낙 자주 쓰이는 조인이기 때문에 inner를 생략해도 된다.
 INNER JOIN tbl_category b ON a.category_code = b.category_code;

-- 2) using을 활용
-- join할 테이블들의 매핑 속성명이 동일할 경우에만 사용 가능한 문법.
SELECT
		 a.menu_name
	  , b.category_name
	  , a.category_code
  FROM tbl_menu a
 INNER JOIN tbl_category b USING (category_code);  -- 