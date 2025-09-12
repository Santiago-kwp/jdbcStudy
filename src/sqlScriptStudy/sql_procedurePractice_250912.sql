use employees;

-- employees 테이블에서 직원번호가 10001인 
-- 직원의 입사일이 5년이 넘었는지 확인하는 프로시저를 작성

-- ifProc2()

desc employees;

delimiter @@
create procedure ifProc2()
begin
	-- 사용할 변수
    declare hireDate date; -- 입사일
    declare curDate date;  -- 오늘
    declare days int;       -- 계산된 근무일수
    
    
    -- 처리해야 할 쿼리문
    select hire_date into hireDate
    from employees where emp_no = 10001;
    
    -- 변수 저장
    set curDate = current_date();  -- 시스템으로부터 현재 날짜 받아오기
    set days = datediff(curDate, hireDate); -- 날짜의 차이, 일 단위
    
    -- 결과 담을 변수 출력
    if (days/365) >= 5 then
		select concat('입사한지', days, ' 일이 지났습니다. 축하합니다.');
	else
		select concat('입사한지', days, ' 일 밖에 안 지났습니다. 5년이 지나면 특별상여가 지급됩니다.');
    end if;
	
end @@
delimiter ;

call ifProc2();

/**
	IF ELSE 이용하여 70점 이상은 SUCCESS, 70점 미만은 Fail 출력하는 ScoreTest 프로시저를 구현하세요.
*/

drop procedure if exists ScoreTest;
delimiter @@
create procedure ScoreTest()
begin
	declare score int;
    set score = 66;
    
    if score >= 70 then
		select 'SUCCESS';
	else
		select 'Fail';
	end if;
    
end @@
delimiter ;

call ScoreTest();

/**
	CASE 문을 이용하여 다중분기문, IF문 사용 가능
    SCORE = 77
    90 점 이상은 'A'
    80 점 이상은 'B'
    70 점 이상은 'C'
    60 점 이상은 'D'
    60 점 미만은 'F'
    출력조건 '취득점수 ==>' 77 학점 ==> C
*/

drop procedure Grade;
delimiter @@
create procedure Grade()
begin
	-- 변수 선언
	declare score int;
    declare grade char;
    
    set score = 77;
    
    -- 수행문
    SET grade = (
    CASE
		when score >= 90 then 'A'
        when score >= 80 then 'B'
        when score >= 70 then 'C'
        when score >= 60 then 'D'
        else 'F'
	END
    );
    select concat('취득점수 ==> ', score, ' 학점 ==> ', grade);
    
end @@
delimiter ;

call Grade();


use sqldb;

-- 구매테이블(buytbl)에 구매액 (price * amount)가 1500원 이상인 고객은 'VIP' 1000원 이상인 고객은 'GOLD'
-- 500원 이상인 고객은 'silver' 500원 미만인 고객은 'customer', 가입은 되었지만 구매실적이 없는 고객은 'Ghost'
-- 분류하여 결과를 출력하세요.

desc buytbl;
desc usertbl;


select u.userid, u.name, sum(b.price * b.amount) as total from buytbl b right join usertbl u on b.userID = u.userID
group by userid
order by sum(b.price * b.amount) desc;

drop procedure userRanking;    
delimiter @@
create procedure userRanking()
begin
	
    select u.userid, u.name, sum(b.price * b.amount) as total,
    ( 
		CASE
			WHEN sum(b.price * b.amount) >= 1500 then 'VIP'
			WHEN sum(b.price * b.amount) >= 1000 then 'GOLD'
			WHEN sum(b.price * b.amount) >= 500  then 'SILVER'
			WHEN sum(b.price * b.amount) < 500  then 'CUSTOMER'
			ELSE 'Ghost'
		END
	) AS userRank
    from buytbl b right join usertbl u on b.userID = u.userID
	group by userid
	order by total desc;
    
end @@
delimiter ;


call userRanking();


###########################################
-- WHILE (loop), iterate, leave

/*
	WHILE <부울식> DO
		SQL문;
	END WHILE;
*/

-- 1부터 100까지의 값을 모두 더하는 기능을 프로시저로 구현 : whileProc
delimiter @@
create procedure whileProc() 
begin
	-- 변수 선언
    declare i int;
    declare total int;
    
    -- 값 할당
    set i = 1;
    set total = 0;
    
    -- 수행문
    while ( i <= 100) DO
		set total = total + i;
		set i = i + 1;
    END WHILE;
    
    -- 출력문
    select total as '1-100 누적 총합';
    
end @@
delimiter ;

call whileProc();


-- 1에서 100까지의 합계에서 만약에 7의 배수 제외시키면서 총합을 구하려면?
-- 더하는 도중에 중간에 총합계가 1000이 넘으면 총합을 멈추고 현재 총합값을 출력하고 싶으면?
drop procedure whileProc;
delimiter @@
create procedure whileProc()
begin
	-- 변수 선언
    declare i int;
    declare total int;
    
    -- 값 할당 (변수 초기화)
    set i = 1;
    set total = 0;
    
    -- 수행문
    myWhile : while ( i <= 100) DO -- while문에 label 지정
		if (i%7 = 0) then
			set i = i +1;
            ITERATE myWhile; -- 지정한 label문으로 가서 계속 진행
		end if;
        
		set total = total + i;
        if (total > 1000) then
			leave myWhile; -- 지정한 label문을 떠나라! while 종료
		end if;
        
        set i = i + 1;
    END WHILE;
    
    -- 출력문
    select total as '1-100 누적 총합';
    
end @@
delimiter ;

call whileProc();

-- 1부터 1000 까지의 숫자 중에 3의 배수 또는 8의 배수만 더하는 프로시저 구현 whileProc2
delimiter @@
create procedure whileProc2()
begin
	declare i int;
    declare sum int;
    
    set i = 1;
    set sum = 0;
    while ( i < 1000) DO
		if (i % 3 = 0 or i % 8 = 0 ) then
			set sum = sum + i;
		end if;
        set i = i + 1;
	end while;
    
    -- 출력문
    select sum;


end @@
delimiter ;

call whileProc2();

-- 오류 처리 : MySQL은 오류가 발생하면 직접 오류를 처리한다.
-- DECLARE 액션 handler FOR 오류조건 처리할 문장;

Drop procedure ErrorTest;
Delimiter @@
create procedure ErrorTest()
begin
	-- 변수 선언
    declare continue handler for 1146 select "존재하지 않는 테이블입니다." as '메시지';
    
    -- 수행문
    select * from noTable;
    
end @@
delimiter ;

call ErrorTest();

select * from notable;

drop procedure ErrorProc2;

delimiter @@
create procedure errorProc2()
begin
	-- 변수 선언
    declare continue handler for sqlexception
    begin
    -- 수행문
	show errors; -- 오류에 대한 코드와 메시지를 출력하라
    select '오류가 발생했습니다. 작업은 취소시켰습니다.' as 메시지;
    rollback;  -- 진행중인 INSERT 문을 취소하라
    end;
    insert into usertbl values('LSG','이덕구', 1988, '서울', NULL, NULL, 180, current_date()); -- Duplicate entry 'LSG' for key 'usertbl.PRIMARY'
    
    -- 출력문
end @@
delimiter ;

call errorProc2();


-- user table의 모든 사용자의 정보를 출력하는 프로시저 userlistPrint()
delimiter @@
create procedure userlistPrint()
begin
	select * from usertbl;
end @@
delimiter ;
call userlistPrint();



-- 수정 삭제 가능한 프로시저 만들기
-- ALTER PROCEDURE
-- DROP PROCEDURE
-- 매개변수 사용
/*
	입력매개변수: IN 입력매개변수명 데이터형식
    CALL 프로시저이름(전달값); 
    
    출력매개변수 : OUT 출력매개변수명 데이터형식    SELECT ... INTO 출력매개변수
				CALL 프로시저이름(@변수명)
				SELECT @변수명;
*/

-- 1개의 입력매개변수가 있는 저장프로시저

delimiter @@
create procedure userProc5(IN userName VARCHAR(50))
begin
    SELECT * FROM usertbl WHERE NAME = userName;
end @@
delimiter ;

CALL userProc5('조관우');
CALL userProc5('바비킴');

desc usertbl;

-- usertbl에서 출생년도 (birthdate)가 1970년 이후에 태어나고 키가 170 이상인 회원들의 리스트를 프로시저로 구현 하시오
drop procedure userProc6;
delimiter @@
create procedure userProc6(IN year int, hgt int)
begin
    SELECT * FROM usertbl WHERE birthYear >= year AND height >= hgt;
end @@
delimiter ;

call userProc6(1970, 170);



#######################################################################################alter
-- 프로시저를 통해 테스트로 사용할 테이블 생성해보자

drop procedure userProc6;
delimiter @@
create procedure userProc6(IN txtValue char(10), OUT outValue INT)
begin
    INSERT INTO testTbl values(null, txtValue);
    select max(id) into outValue FROM testTbl;
    
end @@
delimiter ;

drop table testTbl;
create table testTbl (
	id int primary key auto_increment,
	txt char(10) not null
);

call userProc6('테스트', @myValue2);
select CONCAT('ID =>', @myValue2);
select * from testTbl;

-- 테이블의 이름을 넘겨주면 테이블의 모든 정보가 출력되는 프로시저를 만들고 싶다. : nameTableProc
-- 동적SQL을 PREPARE , EXECUTE


delimiter @@
create procedure nameTableProc(IN tblName VARCHAR(50))
begin
	-- 변수 선언
    set @sqlQuery = CONCAT('SELECT * FROM ', tblName);
    PREPARE myQuery FROM @SqlQuery;
    execute myQuery;
    deallocate prepare myQuery;  -- 메모리 해제     
    -- 값 할당
    
    -- 수행문
    
    -- 출력문
end @@
delimiter ;

call nameTableProc('buyTbl');
call nameTableProc('userTbl');
