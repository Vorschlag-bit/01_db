-- order by(정렬)

-- 오름차순(ascending, ASC)
SELECT
       menu_code    --1행
     , menu_name    --2행 
     , menu_price   --3행
  FROM tbl_menu
--   ORDER BY 3 ASC, 2 DESC; -- 정렬을 우선순위를 나누어 정렬, select절의 컬럼 순번으로 정렬
  ORDER BY 3, 2 DESC;        -- asc는 생략가능(order by절의 default가 asc기 떄문이다!)
  
  

-- 별칭을 이용한 정렬
SELECT 
       menu_code AS '메뉴코드'
     , menu_name AS 'mn'
     , menu_price AS 'mp'
  FROM tbl_menu
  ORDER BY '메뉴코드' DESC;  -- 싱글쿼테이션 생략 불가(별칭에 특수기호 없을 경우)
  
--   --------------------------------------------------
-- 마리아db는 field 함수를 활용햇 ㅓ정렬이 가능하다.
SELECT FIELD('a', 'b', 'a', 'd');    -- 우측에 있는 값 중에 좌측의 값이 몇 번째에 있는지 보여줘 (2번 이상부터 같은 값 인덱스 알려주는 함수)

SELECT
       orderable_status
     , field(orderable_status, 'N', 'Y')
  FROM tbl_menu;
  
  -- field를 활용한 order by
  -- 주문 가능한 것부터 보이게 정렬하기! << 이 문장을 보고 쿼리를 짜내는 게 진짜 능력이다. 언어능력과 똑같다.
  SELECT
         menu_name
      ,  orderable_status
    FROM tbl_menu
    ORDER BY FIELD(orderable_status, 'N', 'Y') DESC; -- 2번부터인 Y부터 내림차순으로 정리하겠다.
    
-- column이 비어있다 = 'null', null값에 대한 정렬은 어떻게 할까?
-- 1) 오름차순 시: null 값이 먼저 나옴
SELECT
      *
  FROM tbl_category
  ORDER BY ref_category_code ASC;  -- asc는 null이 먼저 나오도록 세팅
  
-- 2)내림차순 시: null값이 나중에 나옴
SELECT
      *
  FROM tbl_category
  ORDER BY ref_category_code DESC;  -- null 저 밑에 처박힌다
  
--  3) 오름차순에서 null이 나중에 나오도록 바꿈
SELECT
       *
  FROM tbl_category
  ORDER BY -ref_category_code DESC; -- 마리아 전용 문법, desc는 null에 국한되서 적용하고, 나머지는 반대로(= 오름차순) 정리
                                    -- desc를 통해 null을 나중으로 보내고 '-'로 desc와 반대로 진행(=asc)
-- ---------------------------------------------------

-- 4)내림차순에서 null이 먼저 오도록 바꿈
SELECT
       *
  FROM tbl_category
  ORDER BY -ref_category_code; -- asc는 뭐다? null값만 asc로 나머진 '-'라 반대로