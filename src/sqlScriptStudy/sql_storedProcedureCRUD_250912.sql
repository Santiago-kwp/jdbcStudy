use bookmarketdb;


select * from boardtable;

desc boardtable;
-- 글 생성 기능 createBoard() 프로시저 생성하기
drop procedure createBoard;

DELIMITER @@
CREATE PROCEDURE createBoard(IN title VARCHAR(40), content TEXT, writer VARCHAR(20), OUT outValue INT)
BEGIN
	-- 에러 발생 시 처리할 핸들러 선언
 	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
 	BEGIN
		-- 오류 메시지를 출력합니다.
 		SELECT '오류가 발생했습니다. 작업을 취소하고 롤백합니다.' AS message;
 		-- 오류에 대한 상세 정보를 출력합니다.
 		SHOW ERRORS;
 		-- 트랜잭션을 롤백(취소)합니다.
 		ROLLBACK;
 		 
 		-- 오류가 발생했을 경우 OUT 파라미터에 0을 할당
 		SET outValue = 0;
 	END;

	-- 트랜잭션 시작
 	START TRANSACTION; 	
	-- 데이터 입력하기
 	INSERT INTO boardtable(btitle, bcontent, bwriter, bdate) VALUES (title, content, writer, NOW());
	-- 오류가 발생하면 이 부분은 실행되지 않습니다.
 	SELECT '삽입 작업이 성공했습니다.' AS message;

	-- OUT 파라미터인 outValue에 값을 할당합니다.
 	SET outValue = 1; -- 성공 시 1을 할당
 	
	-- 정상적으로 모든 문장이 실행되었을 경우 커밋합니다.
 	COMMIT;
END @@
DELIMITER ;


call createBoard('title2','content2','writer2', @outValue);
call createBoard('title3','content3','writer3', @outValue);
call createBoard('title4','content4','writer4', @outValue);

select @outValue;
select * from boardtable;



truncate boardtable;



drop procedure searchAll;
delimiter @@
create procedure searchAll(IN tblName VARCHAR(50))
begin
	-- 에러 발생 시 처리할 핸들러 선언
 	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
 	BEGIN
		-- 오류 메시지를 출력합니다.
 		SELECT '오류가 발생했습니다. 작업을 취소합니다.' AS message;
 		-- 오류에 대한 상세 정보를 출력합니다.
 		SHOW ERRORS;
 	END;
    
	
	-- 변수 선언
    set @sqlQuery = CONCAT('SELECT * FROM ', tblName);
    PREPARE myQuery FROM @SqlQuery;
    execute myQuery;
    deallocate prepare myQuery;  -- 메모리 해제     
    
end @@
delimiter ;

call searchAll('boardtable');

drop procedure searchOne;
############ searchOne 함수
delimiter @@
create procedure searchOne(IN boardid int, out outValue int)
begin
	-- 에러 발생 시 처리할 핸들러 선언
 	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
 	BEGIN
		-- 오류 메시지를 출력합니다.
 		SELECT '오류가 발생했습니다. 작업을 취소합니다.' AS message;
 		-- 오류에 대한 상세 정보를 출력합니다.
 		SHOW ERRORS;
 	END;
    
	declare continue handler for 1054 select "존재하지 않는 데이터입니다." as '메시지';
    
    -- 수행문
    select * from boardtable where bno = boardid;
    set outValue = 1;
end @@
delimiter ;

call searchOne(1,@outOne);
select @outOne;


#### updateBoard




