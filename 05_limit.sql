-- limit
-- 전체 행 조회(특정 행만 자르고 싶을 때, 예시) 커뮤니티 페이지를 나누고 시간순에 따라 내림차순으로 배치할 때)
-- limit이 포함된  ordre by랑 단순 order by는 정렬 기준 컬럼의 값이 같으면
-- 약간의 순서 차이가 있을 수도 있다.
SELECT
		 menu_code
	  , menu_name
	  , menu_price
  FROM tbl_menu
 ORDER BY menu_price DESC;
 
 SELECT
 		  menu_code
 	  ,  menu_name
 	  ,  menu_price
   FROM tbl_menu
  ORDER BY menu_price DESC, menu_code DESC  -- limit은 사실 order by절에 해당되는'키워드'이다
  LIMIT 4, 3; -- 처음에는 시작인덱스, 원하는 자르고 싶은 개수(5번째 이후 3개를 자르기)
  
-- tmi) index 체계 설명: 10진법 = 0 - 9니까 10개의 데이터를 한 자리수로 표현. 예제)컴퓨터는 1-12월을 0-11월이라고 받아들임.

SELECT
		 *
  FROM tbl_menu
 ORDER BY menu_code LIMIT 10; -- 하나의 수치만 주면 length의미만 갖는다.mysqlmysql