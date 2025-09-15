use bookmarketdb;

-- 샘플테이블 생성
create table CODE1 (
    CID int, cName varchar(50)
);

DESC CODE1;

-- select 문으로 데이터 집어넣는 방법

INSERT INTO CODE1(cid, cname)
select ifnull(max(cid), 0)+1 as cid2, 'TEST' as cName2 -- ifnull(a,b) 는 a가 null 일 경우 b 반환, a가 null이 아니면 a 반환
FROM CODE1;

select * from code1;

truncate code1;

drop procedure P_INSERTCODES;
-- 프로시저 생성 P_INSERTCODES()
delimiter @@
create procedure P_INSERTCODES(IN cData VARCHAR(255),
                                IN cTname VARCHAR(255),
                                OUT resultMsg VARCHAR(255))
begin
    set @strsql = CONCAT(
                  'INSERT INTO ', cTname, '(cid, cname)',
                  'SELECT COALESCE(MAX(cid), 0)+1, ? FROM ', cTname
                  );
    -- COALESCE : 병합한다. 여러 인수 중 null 이 아닌 첫번째 값을 반환 -> 모든 인수가 NULL 이면 NULL 반환

    -- 바인딩 할 변수 지정
    set @cData = cData;
    set resultMsg = 'INSERT Success!';

    -- 동적 SQL 실행
    prepare stmt FROM @strsql;
    execute stmt using @cData;

    -- 자원 해제 및 트랜잭션 확정
    DEALLOCATE prepare stmt;
    commit;
end @@
delimiter ;

CALL P_INSERTCODES('프론트디자이너','CODE1',@resultMsg);

select * from code1;

#######################################################

CREATE TABLE TB_MEMBER (
                           m_seq INT AUTO_INCREMENT PRIMARY KEY,  -- 자동 증가 시퀀스
                           m_userid VARCHAR(20) NOT NULL,
                           m_pwd VARCHAR(20) NOT NULL,
                           m_email VARCHAR(50) NULL,
                           m_hp VARCHAR(20) NULL,
                           m_registdate DATETIME DEFAULT NOW(),  -- 기본값: 현재 날짜와 시간
                           m_point INT DEFAULT 0
);

select * from TB_MEMBER;

-- 반드시 중복 사용자는 예외처리 (이미 존재하는 사용자라고 검사)
-- 만약 성공적이면 숫자 200리턴, 이미 가입된 회원이라면 숫자 100 리턴
delimiter @@
CREATE PROCEDURE SP_MEMBER_INSERT(
    IN V_USERID VARCHAR(20),
    IN V_PWD VARCHAR(20),
    IN V_EMAIL VARCHAR(50),
    IN V_HP VARCHAR(20),
    OUT RTN_CODE INT
)
begin
    declare v_count int;

    select count(m_seq) into v_count from tb_member where m_userid = V_USERID;

    if v_count > 0 then
        set RTN_CODE = 100;
    else
        insert into tb_member(m_userid, m_pwd, m_email, m_hp) values (v_userid, v_pwd, v_email, v_hp);
        set RTN_CODE = 200;
    end if;

    commit;

end @@
delimiter ;

call sp_member_insert('apple','1111','apple@sample.com','010-222-4333',@result);

select @result;

show create procedure SP_MEMBER_INSERT;

select * from tb_member;

call sp_member_insert('apple','1111','apple@sample.com','010-222-4333',@result);
select @result;


#######################
-- 1. SP_MEMBER_LIST() 프로시저를 생성 : 전체 회원들의 정보를 출력하는 기능입니다.
-- 2. MEMBERList 클래스에서 callableStatement 방식으로 회원들의 리스트를 출력하는 기능을 구현하세요.

delimiter @@
CREATE PROCEDURE SP_MEMBER_LIST()
begin
    select * from tb_member;

end @@
delimiter ;

call SP_MEMBER_LIST();


-- 회원 1명의 정보 조회 - USER_ID를 통해서
delimiter @@
create procedure SP_MEMBER_SHOW(IN v_userid varchar(20))
begin
    select * from tb_member where m_userid = v_userid;

end @@

call SP_MEMBER_SHOW('jenny');

-- 회원 정보 수정 : 다중 분기 -> 비밀번호 수정, 이메일 수정, 연락처를 수정할지
DROP PROCEDURE IF EXISTS SP_MEMBER_UPDATE;

delimiter @@
create procedure SP_MEMBER_UPDATE(IN v_userid varchar(20), IN choice int, IN updatedString varchar(255))
begin

    set @cName = (
        CASE choice
            WHEN 1 then 'm_pwd'
            WHEN 2 then 'm_email'
            WHEN 3 then 'm_hp'
            END
    );

    set @sqlQuery = CONCAT('UPDATE TB_MEMBER SET ', @cName, ' = ? WHERE m_userid = ?');

    -- 파라미터 바인딩용 변수 설정
    SET @param1 = updatedString;
    SET @param2 = v_userid;

    prepare stmt from @sqlQuery;
    execute stmt using @param1, @param2; -- This line needs a semicolon to work correctly in all MySQL versions and clients.
    deallocate prepare stmt;
    commit;

end @@
delimiter ;

