-- type casting
-- 명시적 형변환

-- 1) 숫자 -> 숫자 avg를 as 이하 타입으로 형변환
SELECT CAST(AVG(menu_price) AS UNSIGNED INTEGER) AS '가격평균'
  FROM tbl_menu;
  
DESC tbl_menu;

-- 소수점 이하 한 자리까지만 표기 가능, cast 자리에는 다양한 값이 들어갈 수 있으므로 응용 가능
SELECT CAST(AVG(menu_price) AS FLOAT) AS '가격평균'
  FROM tbl_menu;
  
SELECT CAST(AVG(menu_price) AS double) AS '가격평균'
  FROM tbl_menu;


-- 2) 문자 -> 날짜
-- 2024.06.27을 date형으로 변환, 특수기호가 들어가면 자동으로 구분자로(delim) 변환한다
SELECT CAST('2024%6%27' AS DATE);
SELECT CAST('2024/6/27' AS DATE);

-- 3) 숫자 -> 문자(묵시적 형변환을 활용한)
SELECT CONCAT(1000, '원');  -- 숫자 문자를 동시에 주고 concat을 갈기면 원래는 안 되는 게 맞지만 db가 알아서 변환한다

SELECT 1 + '2'; -- mariadb가 연산 시 치환하기 힘든 문자열은 0으로 치환하여 적용한다(예) '김' + 1 = 1)
--  문자 2를 cast('2' as int)처리해서 숫자로 처리함

SELECT 2 + '100rla'; -- 이렇게 쓰면 코드 문법상 왼쪽부터 읽어서 자신이 형변환 처리할 수 있는 건 바꾸고 나머지는 0처리한다
SELECT 2 + 'ref2220'; -- 이 경우는 ref먼저 인식하기 때문에 2가 나온다


SELECT RAND(), FLOOR(RAND() * (45 - 6) + 6);