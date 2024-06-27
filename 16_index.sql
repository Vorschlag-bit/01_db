/*index*/
-- 우리가 지정한 col을 가지고 따로 별도의 공간을 마련 후 mapping한다 => 검색 속도 향상
-- pk는 알아서 idx가 부여된다 (고유식별자)
-- 단점: 별도의 저장공간이 필요하다(추가 공간 요구)
-- 원본 table이 수정되면 마찬가지로 수정되어야 한다(잦은 변동이 없어야 함)
SELECT * FROM tbl_menu; -- 이 명령문은 모든 행, 열을 다 뒤져 본다.

CREATE TABLE phone (
 phone_code INT PRIMARY KEY AUTO_INCREMENT,
 phone_name VARCHAR(255),
 phone_price DECIMAL(10,2)
);
 
INSERT
  INTO phone
VALUES
(NULL, 'galaxy24', 1200000),
(NULL, 'iphone15pro', 15000000),
(NULL, 'galaxyfold3', 30000000);

SELECT * FROM phone;

-- where절 활용해서 단순 조회
SELECT * FROM phone WHERE phone_name = 'iphone15pro';
EXPLAIN SELECT * FROM phone WHERE phone_name = 'iphone15pro';

-- phone_name에 idx 추가
CREATE INDEX idx_name ON phone(phone_name);
SHOW INDEX FROM phone;

-- index가 다시 추가된 col 조회해서 index를 태웠는지 확인
-- (바뀐 내용 기반으로 새로운 꼬리표를 달기)
SELECT * FROM phone WHERE phone_name = 'iphone15pro';
EXPLAIN SELECT * FROM phone WHERE phone_name = 'iphone15pro';
-- 주기적으로 한번씩 다시 index를 rebuild 해줘야 한다(mariadb는 optimize)
OPTIMIZE TABLE phone;

DROP INDEX idx_name ON phone;

SHOW INDEX FROM phone;
