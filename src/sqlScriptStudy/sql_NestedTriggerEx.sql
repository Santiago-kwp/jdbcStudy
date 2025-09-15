drop database if exists triggerDB;
create database if not exists triggerDB;
use triggerDB;

-- 중첩 트리거 작동 실습
drop table orderTbl;
drop table prodTbl;
drop table deliverTbl;


create table orderTbl -- 구매 테이블
(
    orderNo INT AUTO_INCREMENT PRIMARY KEY, -- 구매 일련번호
    userID VARCHAR(5),   -- 구매한 회원 아이디
    prodName VARCHAR(5), -- 구매한 물건
    orderAmount INT      -- 구매한 개수
);

create table prodTbl -- 물품 테이블
(
    prodName VARCHAR(5), -- 물건 이름
    account INT          -- 남은 물건 수량
);

create TABLE deliverTbl -- 배송 테이블
(
    deliverNo INT AUTO_INCREMENT PRIMARY KEY, -- 배송 일련번호
    prodName VARCHAR(5),                      -- 배송할 물건
    account INT UNIQUE                        -- 배송할 물건 개수
);

INSERT INTO prodTbl VALUES('사과', 100);
INSERT INTO prodTbl VALUES('배',100);
INSERT INTO prodTbl VALUES('귤', 100);

select * from prodTbl;
-- 구매 테이블과 물품 테이블에 트리거 부착

-- 주문테이블에 주문이 INSERT되면, 물품 테이블에서 해당 물품의 개수를 감소시키는 트리거
DROP TRIGGER IF EXISTS orderTrg;
delimiter @@
create trigger orderTrg
    AFTER INSERT
    ON orderTbl -- 트리거를 부착할 테이블
    FOR EACH ROW
BEGIN
    UPDATE prodTbl SET account = account - NEW.orderAmount
    where prodName = NEW.prodName; -- 주문한 수량만큼 해당하는 상품의 수량을 줄인다.
end @@
delimiter ;

-- 배송 테이블에 새 배송 건을 입력하는 트리거
DROP TRIGGER IF EXISTS prodTrg;
DELIMITER @@
CREATE TRIGGER prodTrg
    AFTER UPDATE
    ON prodTbl
    FOR EACH ROW
BEGIN
    DECLARE orderAmount INT;
    -- 주문 개수 = (변경 전의 개수 - 변경 후의 개수)
    SET orderAmount = OLD.account - NEW.account;
    INSERT INTO deliverTbl(prodName, account)
        VALUES(NEW.prodName, orderAmount);
end @@
delimiter ;


-- 고객이 구매한 데이터 입력
INSERT INTO orderTbl(userID, prodName, orderAmount) VALUES ('JOHN', '배', 5);

desc orderTbl;


select * from orderTbl;
select * from prodTbl;
select * from deliverTbl;

alter table deliverTbl change prodName productName VARCHAR(5);

insert into orderTbl values (null, 'DANG','사과',9);

select * from orderTbl;
select * from prodTbl;
select * from deliverTbl;
