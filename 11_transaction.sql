/*transaction*/

-- autocommit 비활성화
SET autocommit = 0;
SET autocommit = OFF;

-- autocommit 활성화
SET autocommit = 1;
SET autocommit = ON;

-- 데이터를 삭제, 추가, 수정할 때마다 history가 쌓이고 이는 유지보수 및 백업에 매우 중요하다.
-- transaction 시작점을 히스토리에서 지정하면 그 포인터 이후가 하나의 transaction 단위가 된다.

-- 현장에서 가장 중요한 transaction = 'order'이다
-- 1. 주문이 들어옴 2. 이커머스에 결제회사(pg사)로 결제내용 보냄 3. 물류회사에 물품 이력 및 내역을 조회
-- 4. 배송업체에 배송 가능여부 조회
-- 위 모든 게 하나의 transaction 단위가 된다. '논리적 일의 단위'라고도 한다.
-- 타 회사의 api와도 연동하므로 transaction은 거대한 하나의 작업이므로 매우 중요하다.


START TRANSACTION;
INSERT
  INTO tbl_menu
VALUES
(
 NULL, '바나나 해장국', 8500     -- 이력
, 4, 'Y'
);

UPDATE tbl_menu
	SET menu_name = '수정된 메뉴'
 WHERE menu_code = 5;
 
 SELECT * FROM tbl_menu;
 
-- ROLLBACK;
-- COMMIT;
 
SELECT * FROM tbl_menu;