/*DML(Datat Manipulation Language*/
-- 여기선 select을 제외한 기준을 배운다. (select은 DQL이라고 정의하자)
-- cqrs를 배운다. 조회와 조회가 아닌 나머지를 구분하는 방식

-- insert, update, delete, select(DQL)

/*insert*/
-- 새로운 행을 추가하는 구문이다.
-- 테이블의 행의 수가 증가한다.
SELECT * FROM tbl_menu;
INSERT
  INTO tbl_menu
( -- 컬럼이 너무 많을 경우 몇 개씩 나눠서 쓰기, 행을 생성하고 나면 values만 써도 괜찮다. 다만 유지보수 측면에선 계속 써주는 게 좋다
  menu_name
, menu_price
, category_code         
, orderable_status
)
VALUES
(
  '초콜릿죽'
, 6500
, 7
, 'Y'
);
SELECT * FROM tbl_menu ORDER BY 1 DESC;

/*multi insert*/
-- 이렇게 db스크립트화하는 것은 좋다.
INSERT
  INTO tbl_menu
VALUES
(NULL, '참치맛 아이스크림', 1700, 12, 'Y'),
(NULL, '멸치맛 아이스크림', 1500, 11, 'Y'),
(NULL, '소시지맛 커피', 2500, 8, 'Y');


/*update*/
-- table에 기록된 col값을 수정하는 구문이다.
-- 전체 col 개수에는 변화가 없다.

SELECT * FROM tbl_menu WHERE menu_name = '소시지맛 커피';

UPDATE tbl_menu  -- 내용을 바꿀 table
	SET category_code = 7    -- 커밋을 쓰지 않으면 가상으로만 수정한 것이다. rollback을 쓰면 수정가능한 상태라는 뜻.
 WHERE menu_code = 25;
 
-- subquery를 활용한 update
UPDATE tbl_menu
	SET category_code = 6
 WHERE menu_code = (SELECT menu_code  -- 단일행 서브쿼리(메뉴코드)
  							 FROM tbl_menu
 							WHERE menu_name = '소시지맛 커피');
 							
/*delete*/
-- table col을 삭제하는 구문이다.
-- table col 총 개수는 감소한다.
SELECT * FROM tbl_menu ORDER BY menu_price; -- 수정 전 col: 25개

-- commit 하면 안 된다는 미친 구문
-- DELETE  FROM tbl_menu;

-- ROLLBACK을 입력하면 commit 전까지는 복구가능하다.   elte 
SET autocommit = OFF;  -- autocommit 끄는 구문, 마리아db는 기본적으로 'on'이라
-- insert, update, delete 시에 base table(메모리에) 바로 반영된다.
-- 다시 살리고 싶다면 끄자

DELETE
  FROM tbl_menu
 ORDER BY menu_price  -- menu가격을 기준으로 오름차순
 LIMIT 2;  -- 정렬된 첫 행부터 두 개의 행
 
/*replace*/
-- insert 시 primary key(null x, 중복 x, 이후 수정도 x) 또는 unique key(중복 x)가
-- 충돌이 발생하지 않도록 replace를 통해 중복된 data를 덮어 씌운다.
-- 중복되지 않은 pk에 대해서 자동으로 내용을 update한다고 생각
REPLACE 
   INTO tbl_menu
 values
(
  17
, '참기름소주'
, 5000
, 10
, 'Y'
);
-- result
SELECT * FROM tbl_menu WHERE menu_code = 17;
  

 