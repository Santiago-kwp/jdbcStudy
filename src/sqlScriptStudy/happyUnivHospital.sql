create database happyUnivHospital;

use happyUnivHospital;

drop table doctor;
create table doctor(
    did varchar(4) primary key,
    mainSubject varchar(20) not null,
    name varchar(10) not null,
    sex char(1) not null,
    phone varchar(20),
    email varchar(20),
    position varchar(10)
);

drop table nurse;
create table nurse(
    nid varchar(5) primary key,
    mainTask varchar(20) not null,
    name varchar(10) not null,
    sex char(1) not null,
    phone varchar(20),
    email varchar(20),
    position varchar(10)
);

drop table patient;
create table patient(
    pid varchar(10) primary key,
    did varchar(4),
    nid varchar(5),
    registentNum char(14),
    name varchar(10) not null,
    sex char(1) not null,
    phone varchar(20),
    email varchar(20),
    job varchar(20)
);

alter table patient add foreign key (did) references doctor(did) ON DELETE CASCADE;
alter table patient add foreign key (nid) references nurse(nid) ON DELETE CASCADE;

drop table treatment;
create table treatment(
    did varchar(4),
    pid varchar(10),
    treatId varchar(20),
    treatContents text,
    treateDate date
);

alter table treatment add foreign key (did) references doctor(did) ON DELETE CASCADE;
alter table treatment add foreign key (pid) references patient(pid) ON DELETE CASCADE;
alter table treatment add constraint primary key (did, pid, treatId);

drop table chart;
create table chart(
    did varchar(4),
    pid varchar(10),
    nid varchar(5),
    treatId varchar(20),
    chartNum varchar(20),
    doctorOpinion text
);

alter table chart add foreign key (did,pid) references patient(did, pid) ON DELETE CASCADE;
alter table chart add foreign key (nid) references nurse(nid) ON DELETE CASCADE;

insert into doctor values('d01','피부과','홍길동','남','111-1111','hong@test.com','전문의');
insert into doctor values('d02','소아과','마장동','남','111-1122','ma@test.com','전문의');
insert into doctor values('d03','마취과','자장가','남','111-1133','jajang@test.com','전문의');
insert into doctor values('d04','흉부외과','김사부','남','222-1111','doctKim@test.com','일반의');
insert into doctor values('d05','이비인후과','알러지','남','333-1111','aleric@test.com','수련의');
insert into doctor values('d06','성형외과','마스크','남','444-1111','mask@test.com','수련의');
insert into doctor values('d07','정형외과','전기톱','여','555-1111','electric@test.com','전문의');
insert into doctor values('d08','소아과','김어른','남','666-1111','adult@test.com','일반의');
insert into doctor values('d09','정형외과','박타박','여','777-1111','tabak@test.com','전문의');
insert into doctor values('d10','마취과','수면제','여','888-1111','hong@test.com','일반의');

insert into nurse values('n01','응급처치','이수지','여','111-2222','lee@test.com','수간호사');
insert into nurse values('n02','간호진단','일수지','남','111-3332','one@test.com','일반간호사');
insert into nurse values('n03','간호수행','삼수지','여','111-4442','three@test.com','차지간호사');
insert into nurse values('n04','주사투약','사수지','남','111-5552','four@test.com','간호팀장');
insert into nurse values('n05','임상간호','임수지','여','111-6662','lim@test.com','간호부장');
insert into nurse values('n06','보건관리','건수지','남','111-7772','gun@test.com','간호부원장');
insert into nurse values('n07','산업간호','산수지','여','111-8882','san@test.com','일반간호사');
insert into nurse values('n08','응급처치','응수지','남','111-9992','eung@test.com','차지간호사');
insert into nurse values('n09','감염관리','감수지','여','222-2222','gam@test.com','일반간호사');
insert into nurse values('n10','중환자관리','중수지','남','333-3332','center@test.com','수간호사');

INSERT INTO patient (pid, did, nid, registentNum, name, sex, phone, email, job) VALUES
('p01', 'd01', 'n01', '900101-1234567', '김민준', 'M', '010-1234-5678', 'kmj@naver.com', '회사원'),
('p02', 'd02', 'n02', '920315-2345678', '박서연', 'F', '010-2345-6789', 'psy@gmail.com', '주부'),
('p03', 'd03', 'n03', '850720-1231234', '이하준', 'M', '010-3456-7890', 'lhj@hanmail.net', '학생'),
('p04', 'd04', 'n04', '981125-2456789', '정수아', 'F', '010-4567-8901', 'jsa@nate.com', '프리랜서'),
('p05', 'd05', 'n05', '750410-1567890', '최도윤', 'M', '010-5678-9012', 'cdy@daum.net', '자영업자'),
('p06', 'd06', 'n06', '880905-2678901', '고아라', 'F', '010-6789-0123', 'gar@gmail.com', '교사'),
('p07', 'd07', 'n07', '950228-1789012', '윤재현', 'M', '010-7890-1234', 'yjh@naver.com', '공무원'),
('p08', 'd08', 'n08', '930601-2890123', '임지은', 'F', '010-8901-2345', 'lje@hanmail.net', '간호사'),
('p09', 'd09', 'n09', '801212-1901234', '한승우', 'M', '010-9012-3456', 'hsw@daum.net', '의사'),
('p10', 'd10', 'n10', '970518-2012345', '오민서', 'F', '010-0123-4567', 'oms@gmail.com', '회사원');


INSERT INTO treatment (did, pid, treatId, treatContents, treateDate) VALUES
('d01', 'p01', 't001', '경미한 감기로 인한 진료 및 약 처방', '2023-10-26'),
('d02', 'p02', 't002', '고혈압 초기 증상 진료, 식이요법 상담', '2023-10-27'),
('d03', 'p03', 't003', '운동 중 발생한 발목 염좌 치료', '2023-10-28'),
('d04', 'p04', 't004', '피부 발진으로 인한 알레르기 검사 및 연고 처방', '2023-10-29'),
('d05', 'p05', 't005', '만성 두통 진료, 정밀 검사 권유', '2023-10-30'),
('d06', 'p06', 't006', '위염 증상 진료, 내시경 검사 예약', '2023-10-31'),
('d07', 'p07', 't007', '허리 통증으로 인한 물리치료 및 주사 요법', '2023-11-01'),
('d08', 'p08', 't008', '단순 건강 검진', '2023-11-02'),
('d09', 'p09', 't009', '스트레스로 인한 수면 장애 상담', '2023-11-03'),
('d10', 'p10', 't010', '치과 정기 검진 및 스케일링', '2023-11-04');


INSERT INTO chart (did, pid, nid, treatId, chartNum, doctorOpinion) VALUES
('d01', 'p01', 'n01', 't001', 'C-20231026-001', '환자의 일반적인 감기 증상으로, 해열제 및 진통제 처방. 3일 후 재방문 권고.'),
('d02', 'p02', 'n02', 't002', 'C-20231027-002', '고혈압 초기 단계. 저염식 및 규칙적인 운동을 통한 생활 습관 개선을 교육함.'),
('d03', 'p03', 'n03', 't003', 'C-20231028-003', '발목 염좌로 인한 부종 확인. 깁스 처치 및 소염제 처방. 1주간 휴식 권장.'),
('d04', 'p04', 'n04', 't004', 'C-20231029-004', '피부 알레르기 반응. 항히스타민제와 스테로이드 연고를 처방함. 추가 검사 필요.'),
('d05', 'p05', 'n05', 't005', 'C-20231030-005', '만성 두통의 원인을 파악하기 위해 CT 촬영을 권유. 진통제 처방.'),
('d06', 'p06', 'n06', 't006', 'C-20231031-006', '속쓰림과 복통 호소. 위염 가능성 있음. 내시경 검사를 위해 금식 안내.'),
('d07', 'p07', 'n07', 't007', 'C-20231101-007', '요통에 대한 물리치료 시행. 근육 이완제 및 진통제 주사 처방.'),
('d08', 'p08', 'n08', 't008', 'C-20231102-008', '정기 건강 검진 결과 특이사항 없음. 건강한 생활 유지 권고.'),
('d09', 'p09', 'n09', 't009', 'C-20231103-009', '스트레스성 수면 장애로 진단. 심리 상담 및 가벼운 수면 유도제 처방.'),
('d10', 'p10', 'n10', 't010', 'C-20231104-010', '치아 상태 양호. 잇몸 출혈 경미. 스케일링 완료 후 올바른 양치질법 교육.');

-- 예)홍길동 의사가 맡고 있던 담당 진료과목이 피부과에서 소아과로 변경되어
-- 내일부터 진료를 시작할 예정이다. 해당 정보를 변경하세요
update doctor set mainSubject = '소아과' where name='홍길동';
select * from doctor where name = '홍길동';

-- 이수지 간호사는 대학원 진학으로 오늘까지만 근무하고 퇴사하게 되었습니다.
-- 해당 정보에 대한 테이블 정보를 변경하세요
delete from nurse where name = '이수지';

select * from patient;

select * from treatment;

-- 담당진료과목이 '소아과' 의사에 대한 정보를 출력하세요
select * from doctor where doctor.mainSubject='소아과';

-- 홍길동 의사에게 진료받은 환자에 대한 정보를 출력하세요

select patient.name, treatment.treatContents from patient
join treatment on patient.pid = treatment.pid
join doctor on doctor.did = treatment.did
where doctor.name='홍길동';

-- 진료날짜가 2023년 11월에서 2023년 12월에
-- 진료받은 환자에 대한 모든 정보를 오름차순 정렬하여 출력하세요
select patient.* from patient
join treatment t on patient.did = t.did
where t.treateDate between str_to_date('2023-11-01', '%Y-%m-%d') and str_to_date('2023-12-31','%Y-%m-%d')
order by patient.pid;