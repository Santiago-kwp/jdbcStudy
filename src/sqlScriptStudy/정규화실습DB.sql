#######################################################
# 정규화실습 
# 서유미
# 실습 DATABASE
# 작성일:2024-07-31
#######################################################

DROP DATABASE IF EXISTS 정규화;

CREATE DATABASE 정규화 DEFAULT CHARSET  utf8mb4 COLLATE  utf8mb4_general_ci;

USE 정규화;

drop table 동아리가입학생학과;

CREATE TABLE 동아리가입학생학과(
  동아리번호 CHAR(2),
  동아리명 varchar(50) not null,
  동아리창립일 date not null,
  학번 varchar(20),
  학생이름 varchar(30) not null,
  동아리가입일 date not null,
  학과번호 CHAR(2),
  학과명 varchar(30),
  primary key(동아리번호,학번)
 ) DEFAULT CHARSET=utf8mb4;
 
 
 insert into 동아리가입학생학과 values('c1','지구한바퀴여행','2000-02-01',231001,'문지영','2023-04-01','D1','화학공학과');
 insert into 동아리가입학생학과 values('c1','지구한바퀴여행','2000-02-01',231002,'배경민','2023-04-03','D4','경영학과');
 insert into 동아리가입학생학과 values('c2','클래식연주동아리','2010-06-05',232001,'김명희','2023-03-22','D2','통계학과');
 insert into 동아리가입학생학과 values('c3','워너비골퍼','2020-03-01',232002,'천은정','2023-03-07','D2','통계학과');
 insert into 동아리가입학생학과 values('c3','워너비골퍼','2020-03-01',231002,'배경민','2023-04-02','D2','경영학과');
 insert into 동아리가입학생학과 values('c4','쉘위댄스','2021-07-01',231001,'문지영','2023-04-30','D1','화학공학과');
 insert into 동아리가입학생학과 values('c4','쉘위댄스','2021-07-01',233001,'이현경','2023-03-27','D3','역사학과');

select * from 동아리가입학생학과;

create table 동아리(
    동아리번호 char(2),
    동아리명 varchar(50) not null,
    동아리창립일 date not null
);

drop table 동아리가입학생학과;

CREATE TABLE 동아리가입학생학과(
                          학번 varchar(20),
                          학생이름 varchar(30) not null,
                          동아리가입일 date not null,
                          학과번호 CHAR(2),
                          학과명 varchar(30)
) DEFAULT CHARSET=utf8mb4;

alter table 동아리 add primary key(동아리번호);


insert into 동아리가입학생학과 values(231001,'문지영','2023-04-01','D1','화학공학과');
insert into 동아리가입학생학과 values(231002,'배경민','2023-04-03','D4','경영학과');
insert into 동아리가입학생학과 values(232001,'김명희','2023-03-22','D2','통계학과');
insert into 동아리가입학생학과 values(232002,'천은정','2023-03-07','D2','통계학과');
insert into 동아리가입학생학과 values(231002,'배경민','2023-04-02','D4','경영학과');
insert into 동아리가입학생학과 values(231001,'문지영','2023-04-30','D1','화학공학과');
insert into 동아리가입학생학과 values(233001,'이현경','2023-03-27','D3','역사학과');

alter table 동아리가입학생학과 add 동아리번호 char(2) not null;
alter table 동아리가입학생학과 add primary key(동아리번호, 학번);

########### 3정규화
drop table 학과;
create table 학과(
                   학과번호 CHAR(2) primary key ,
                   학과명 varchar(30)
);

insert into 학과 values('D1','화학공학과');
insert into 학과 values('D2','통계학과');
insert into 학과 values('D4','경영학과');
insert into 학과 values('D3','역사학과');

drop table 학생;
create table 학생(
                   학번 varchar(20) primary key,
                   학생이름 varchar(30) not null
);
alter table 학생 add 학과번호 char(2) not null;
alter table 학생 add foreign key (학과번호) references 학과(학과번호);


insert into 학생 values(231001,'문지영', 'D1');
insert into 학생 values(231002,'배경민', 'D4');
insert into 학생 values(232001,'김명희', 'D2');
insert into 학생 values(232002,'천은정', 'D2');
insert into 학생 values(233001,'이현경','D3');

drop table 동아리;
create table 동아리(
                    동아리번호 char(2),
                    동아리명 varchar(50) not null,
                    동아리창립일 date not null
);
alter table 동아리 add primary key(동아리번호);

insert into 동아리 values('c1','지구한바퀴여행', '2000-02-01');
insert into 동아리 values('c2','클래식연주동아리','2010-06-05');
insert into 동아리 values('c3','워너비골퍼','2020-03-01');
insert into 동아리 values('c4','쉘위댄스','2021-07-01');


drop table 동아리가입;
create table 동아리가입(
    동아리가입일 date
);

alter table 동아리가입 add 동아리번호 char(2) not null;
alter table 동아리가입 add 학번 varchar(20) not null;

alter table 동아리가입 add foreign key (동아리번호) references 동아리(동아리번호);
alter table 동아리가입 add foreign key (학번) references 학생(학번);
alter table 동아리가입 add constraint primary key (동아리번호, 학번);

insert into 동아리가입 values('2023-04-01','c1', 231001);
insert into 동아리가입 values('2023-04-03','c1', 231002);
insert into 동아리가입 values('2023-03-22','c2', 232001);
insert into 동아리가입 values('2023-03-07','c3', 232002);
insert into 동아리가입 values('2023-04-02','c3', 231002);
insert into 동아리가입 values('2023-04-30','c4', 231001);
insert into 동아리가입 values('2023-03-27','c4', 233001);


select * from 동아리가입;


-- 문제1) 동아리 'c1', '지구한바퀴여행'에 가입한 학생의 학번, 이름, 학과명을 출력하세요.
select 학생.학번, 학생.학생이름, 학과.학과명
from 학생
join 학과 on 학생.학과번호 = 학과.학과번호
join 동아리가입 on 동아리가입.학번 = 학생.학번
where 동아리가입.동아리번호 = 'c1';

-- 문제2) '경영학과'에 다니고 있는 학생 명단을 출력하세요.
select 학생.학번, 학생.학생이름, 학과.학과명
from 학생
join 학과 on 학생.학과번호 = 학과.학과번호
where 학과.학과명 = '경영학과';

-- 문제3) 동아리 쉘위 댄스에 가입한 학생 중 화학공학과에 다니고 있는 학생의 (학번,  이름 , 동아리가입일)을 출력하세요
select 학생.학번, 학생.학생이름, T.동아리가입일
from 학생
join 학과 on 학생.학과번호 = 학과.학과번호
join (select 동아리가입.학번, 동아리가입.동아리가입일
    from 동아리가입
    join 동아리 on 동아리.동아리번호 = 동아리가입.동아리번호
    where 동아리.동아리명 = '쉘위댄스') as T on T.학번 = 학생.학번
where 학과.학과명 = '화학공학과';















