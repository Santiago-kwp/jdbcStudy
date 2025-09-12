use sqldb;

delimiter $$
create procedure userProc()
begin
	select * from usertbl;
end $$
delimiter ;

call userProc(); -- 전체 조회 기능 

-- 1. 조건 (if ...else) 조건에 따라 분기할 수 있다.

-- 프로시저 지우는 방법
drop procedure if exists ifProc;

delimiter @@
create procedure ifProc()
begin
	declare var1 int; -- 정수형 var1 변수 선언
    set var1 = 100;	  -- var1에 100 값 할당
    
    if (var1 = 100) then
		select 'var1의 값은 100입니다.';
    else
		select 'var1의 값은 100이 아니다.';
    end if;
end @@
delimiter ;

call ifProc();


drop procedure nameTableProc;
delimiter @@
create procedure nameTableProc(IN tblName VARCHAR(50))
begin
	-- 변수 선언
    
    -- 값 할당
    
    -- 수행문
    
    -- 출력문
end @@
delimiter ;


