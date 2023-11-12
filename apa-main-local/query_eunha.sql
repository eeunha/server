select * from tblHospital;

select to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss') from dual;

select * from tblMemo;

create table tblMemo (
    seq number primary key,
    name varchar2(30) not null,
    regdate date default sysdate not null
);

create SEQUENCE seqMemo; 

insert into tblMemo (seq, name, regdate) values (seqMemo.nextVal, '황은하', default);

select * from tblMemo where to_date(regdate, 'yyyy-mm-dd') = to_date((select sysdate from dual), 'yyyy-mm-dd');

------------------------------------------------
------------------------------------------------
--내원환자관리의 기타메모를 위한 테이블
--drop table tblPatientMemo;

create table tblPatientMemo(
  patientMemoSeq number,
  hospitalId varchar2(30) not null,
  userSeq number not null,
  userType varchar2(30) not null,
  memo varchar2(1000) not null,

  constraints tblPatientMemo_pk primary key(patientMemoSeq),
  constraints tblPatientMemo_fk_hs foreign key(hospitalId) references tblHospital(hospitalId),
  constraints tblPatientMemo_fk_us foreign key(userSeq) references tblUser(userSeq)
);

create sequence seqPatientMemo;

select * from tblPatientMemo;

-------------------------------------------------
--입점신청 날짜 테이블
--drop table tblEntryDate;

create table tblEntryDate (
    entryDateSeq number not null,
    entrySeq number not null,
    regdate date default sysdate not null,
    entryDate date,
    
    constraints tblentrydate_pk primary key(entryDateSeq),
    constraints tblentrydate_fk foreign key(entrySeq) references tblEntry(entrySeq)
);
create sequence seqEntryDate;

-------------------------------------------------
-------------------------------------------------
--예약-일반회원-의사 예약목록 (뷰)
create or replace view vwRegisterList
as
select r.mediSeq, u.userSeq, u.userName, r.hospitalId, r.treatmentDate, d.doctorName, r.symptom, r.regdate
from tblRegister r
  inner join tblUser u
  on r.userSeq = u.userSeq
    inner join tblDoctor d
    on r.doctorSeq = d.doctorSeq
order by r.regdate, r.treatmentDate, r.mediSeq;

select * from vwRegisterList;
-------------------------------------------------
--의사-진료과목 (뷰)

create or replace view vwDoctorDepartment
as
select d.doctorSeq, d.hospitalId, d.doctorName, d.departmentSeq, d.doctorImage, m.departmentName
from tblDoctor d
    inner join tblDepartment m
    on d.departmentSeq = m.departmentSeq;
    
--select * from vwdoctordepartment;

------------------------------------------------
--일반회원-자녀 (뷰)
create or replace view vwUserChild
as
select u.userSeq, u.userName, u.userSSN, u.userId, u.userPw,
    u.userTel, u.userAddress, u.userEmail, u.userChild,
    u.userCautionCount, u.registerDate, u.isUserUnregister,
    c.childSeq, c.childName, c.childSSN, c.childTel
from tblUser u
    left outer join tblChild c
    on u.userSeq = c.userSeq;
  
--select * from vwUserChild;

------------------------------------------
--입점신청목록-입점날짜 (뷰)
create or replace view vwEntry
as
select e.entrySeq, e.entryType, e.hospitalId, e.pharmacyId, e.status, d.entryDateSeq, d.regdate, d.entryDate
from tblEntry e
    inner join tblEntryDate d
    on e.entrySeq = d.entrySeq;
    
--select * from vwEntry;

------------------------------------------
-- 진료예약-진료대기환자 (뷰)
create or replace view vwRgstWtPtnt
as
select r.mediSeq, r.hospitalId, r.userSeq, r.childSeq, r.mediWay, r.doctorSeq, r.treatmentDate, r.regdate, r.symptom, r.dispenseSeq, w.waitingPatientSeq, w.waitingStatus
from tblRegister r
  inner join tblWatingPatientList w
  on r.mediSeq = w.mediSeq
order by regdate;
  
--select * from vwRgstWtPtnt;

---------------------------------------------
-- 진료예약-약제조 (뷰)
create or replace view vwRgstDsps
as
select r.mediSeq, r.hospitalId, r.childSeq, r.mediWay, r.doctorSeq, r.treatmentDate,
    r.regdate as mediRegdate, r.symptom, r.dispenseSeq, d.pharmacyId, d.pickUpWay, d.regdate as dspsFinishedDate, d.dispenseStatus
from tblRegister r 
    inner join tblDispense d
    on r.dispenseSeq = d.dispenseSeq
order by r.mediSeq;

--select * from vwRgstDsps;


---------------------------------------------------------------
-- 입점요청서(뷰)
--병원회원, 대표 의사, 의사, 병원운영정보, 병원-진료과목번호, 진료과목, 병원휴게시간, 병원휴무일, 운영시간
create or replace view vwEntryFormHspt
as
select h.hospitalId, h.hospitalName, h.hospitalSSN, h.hospitalAddress, h.hospitalEmail,
    h.hospitalTel, hd.doctorSeq, d.doctorName, dp.departmentName, o.face, o.unface, o.houseCall, o.vaccination,
    o.isHealthCheck, o.isHospitalNightCare, o.isHospitalHoliday, ot.openTime, ot.closeTime,
    f.hospitalDayOff, r.openTime as restStartTime, r.closeTime as restEndTime
from tblHospital h
    inner join tblHeadDoctor hd
    on h.hospitalId = hd.hospitalId
        inner join tblDoctor d
        on hd.doctorSeq = d.doctorSeq
            inner join tblHospitalOperation o
            on h.hospitalId = o.hospitalId
                inner join tblHospitalTreatment t
                on h.hospitalId = t.hospitalId
                    inner join tblDepartment dp
                    on t.departmentSeq = dp.departmentSeq
                        inner join tblRestTime r
                        on h.hospitalId = r.hospitalId
                            inner join tblHospitalDayOff f
                            on h.hospitalId = f.hospitalId
                                inner join tblOperatingTime ot
                                on h.hospitalid = ot.hospitalId;
 
------------------------------------------------
--예약상세보기 뷰
create or replace view vwRegisterDetail
as
select r.mediSeq, r.hospitalId, r.userSeq, r.childSeq, r.mediWay, r.doctorSeq, r.treatmentDate, r.regdate, r.symptom, r.dispenseSeq, 
    u.userName, u.userSSN, u.userID, u.userTel, u.userAddress, u.userEmail, u.userChild, c.childName, 
    c.childSSN, c.childTel, d.doctorName, d.doctorImage, d.departmentName
from tblRegister r
    inner join tblUser u
    on r.userSeq = u.userSeq
        left outer join tblChild c
        on r.childSeq = c.childSeq
            inner join vwDoctorDepartment d
            on r.doctorSeq = d.doctorSeq;
    
select * from vwRegisterDetail;
------------------------------------------------
------------------------------------------------
--예약목록 (병원 아이디 필요)
--1. 오늘 접수된 예약
--번호, 접수자번호, 접수자이름, 예약일시, 의사이름, 상세증상, 신청일시
select *
from vwRegisterList
where to_date(regdate, 'yyyy-mm-dd') = to_date((select sysdate from dual), 'yyyy-mm-dd')
    and mediSeq not in (select mediSeq from tblWatingPatientList)
    and hospitalId = 'yonse';

--select r.mediSeq, r.userSeq, u.userName, r.treatmentDate, d.doctorName, r.symptom, r.regdate 
--from tblRegister r
--  inner join tblUser u
--  on r.userSeq = u.userSeq
--    inner join tblDoctor d
--    on r.doctorSeq = d.doctorSeq
--where to_date(r.regdate, 'yyyy-mm-dd') = to_date((select sysdate from dual), 'yyyy-mm-dd')
--order by r.regdate;

--2. 전체 예약
select *
from vwRegisterList
where hospitalId = 'yonse';

--select r.mediSeq, r.userSeq, u.userName, r.treatmentDate, d.doctorName, r.symptom, r.regdate
--from tblRegister r
--  inner join tblUser u
--  on r.userSeq = u.userSeq
--    inner join tblDoctor d
--    on r.doctorSeq = d.doctorSeq
--order by r.regdate;



------------------------------------------------
-- 예약 상세보기 (진료예약번호 필요)
--1. 접수자 != 환자  접수자 == 자녀
-- r.회원 번호, u.접수자 이름, 접수자 전화번호, r.자녀 번호, 진료대상자 이름, 진료대상자 주민등록번호, r.진료방식, r.진료과목, r.예약일시, 의사이름, 상세증상, 처방약 사후처리, 신청일시

--select r.mediSeq, r.hospitalId, r.userSeq, u.userName, u.userTel, u.childSeq, u.childName, u.childSSN, r.mediway, d.departmentname, r.treatmentdate, d.doctorName, r.symptom, r.dispenseseq, r.regdate
--from tblRegister r
--  inner join vwUserChild u
--  on r.userSeq = u.userSeq
--    inner join vwDoctorDepartment d
--    on r.doctorSeq = d.doctorSeq
--where r.mediSeq = 321;

--예약상세보기 뷰
create or replace view vwRegisterDatail
as
select r.mediSeq, r.hospitalId, r.userSeq, r.childSeq, r.mediWay, r.doctorSeq, r.treatmentDate, r.regdate, r.symptom, r.dispenseSeq, 
    u.userName, u.userSSN, u.userID, u.userTel, u.userAddress, u.userEmail, u.userChild, c.childName, 
    c.childSSN, c.childTel, d.doctorName, d.doctorImage, d.departmentName
from tblRegister r
    inner join tblUser u
    on r.userSeq = u.userSeq
        left outer join tblChild c
        on r.childSeq = c.childSeq
            inner join vwDoctorDepartment d
            on r.doctorSeq = d.doctorSeq;

-- 예약 상세보기 테이블 > 값은 다 가져오고 보여주는건 자바에서 필터링 후 보여준다.
select * from vwRegisterDetail
where mediSeq = ?;

--2. 접수자 == 환자
-- r.회원 번호, u.접수자 이름, 접수자 전화번호, r.진료방식, r.진료과목, r.예약일시, 의사이름, 상세증상, 처방약 사후처리, 신청일시

select r.mediSeq, r.hospitalId, r.userSeq, u.userName, u.userTel, r.mediway, d.departmentname, r.treatmentdate, d.doctorName, r.symptom, r.dispenseseq, r.regdate
from tblRegister r
  inner join vwUserChild u
  on r.userSeq = u.userSeq
    inner join vwDoctorDepartment d
    on r.doctorSeq = d.doctorSeq
where r.mediSeq = 1
order by r.regdate;

select * from tblRegister;
-- 예약 승인
--진료대기환자목록에 추가
insert into tblWatingPatientList (waitingPatientSeq, mediSeq, waitingStatus) values (seqWatingPatientList.nextVal, ?, default);

select * from tblWatingPatientList where mediseq = 321;
delete from tblWatingPatientList where mediseq = 321;
commit;

select * 
from vwRegisterList 
where to_date(regdate, 'yyyy-mm-dd') = to_date((select sysdate from dual), 'yyyy-mm-dd') 
    and mediSeq not in (select mediSeq from tblWatingPatientList) 
    and hospitalId = 'yonse' 
order by regdate desc;


--예약 거부
insert into tblWatingPatientList (waitingPatientSeq, mediSeq, waitingStatus) values (seqWatingPatientList.nextVal, ?, '예약거부');

select * 
from vwRegisterList 
where to_date(regdate, 'yyyy-mm-dd') = to_date((select sysdate from dual), 'yyyy-mm-dd') 
    and mediSeq not in (select mediSeq from tblWatingPatientList) 
    and hospitalId = 'yonse' 
order by regdate desc;
----------------------------------------------
select * from vwRgstWtPtnt;

--진료순서 (병원아이디 필요)
--목록 조회
--1. 오늘자의 목록 전체 출력
-- 번호,  접수자 이름, 자녀 이름, 상세증상, 진료과목, 의사이름, 예약시간, 진행상태(대기중/진료중/진료완료)
select r.mediSeq, u.userName, u.childName, r.symptom, d.departmentName, 
    d.doctorName, to_char(r.treatmentDate, 'hh24:mi') as treatmentTime, r.waitingStatus
from vwRgstWtPtnt r
    inner join vwUserChild u
    on r.userSeq = u.userSeq
        inner join vwDoctorDepartment d
        on r.doctorSeq = d.doctorSeq
--where to_date(r.treatmentDate, 'yyyy-mm-dd') = to_date((select sysdate from dual), 'yyyy-mm-dd')
where to_date(r.treatmentDate, 'yyyy-mm-dd') = to_date('2023-11-16', 'yyyy-mm-dd')
    and r.hospitalId = 'yonse'
    and r.waitingStatus not like '예약거부'
order by treatmentTime desc, mediSeq desc;


select *
from (select a.*, rownum as rnum 
    from vwDiagnosisHistory a 
    where to_date(a.treatmentDate, 'yyyy-mm-dd') = to_date((select sysdate from dual), 'yyyy-mm-dd') 
    and a.hospitalId = 'yonse')
where rnum between 1 and 10;

select * from (select a.*, rownum as rnum from vwDiagnosisHistory a where hospitalId= 'yonse');

--create or replace view vwDignosisHistory
--as
--select r.mediSeq, u.userName, u.childName, r.symptom, d.departmentName, 
--    d.doctorName, to_char(r.treatmentDate, 'hh24:mi') as treatmentTime, r.waitingStatus
--from vwRgstWtPtnt r
--    inner join vwUserChild u
--    on r.userSeq = u.userSeq
--        inner join vwDoctorDepartment d
--        on r.doctorSeq = d.doctorSeq
--where to_date(r.treatmentDate, 'yyyy-mm-dd') = to_date((select sysdate from dual), 'yyyy-mm-dd')
--    and r.hospitalId = 'yonse'
--order by treatmentTime desc, mediSeq desc;

--create or replace view vwDiagnosisHistory
--as
--select r.mediSeq, u.userName, u.childName, r.symptom, d.departmentName, 
--    d.doctorName, to_char(r.treatmentDate, 'hh24:mi') as treatmentTime, r.waitingStatus
--from vwRgstWtPtnt r
--    inner join vwUserChild u
--    on r.userSeq = u.userSeq
--        inner join vwDoctorDepartment d
--        on r.doctorSeq = d.doctorSeq
--order by treatmentTime desc, mediSeq desc;

--진료내역 뷰
create or replace view vwDiagnosisHistory
as
select r.mediSeq, r.hospitalId, u.userName, u.childName, r.symptom, d.departmentName, 
    d.doctorName, r.treatmentDate, r.waitingStatus
from vwRgstWtPtnt r
    inner join vwUserChild u
    on r.userSeq = u.userSeq
        inner join vwDoctorDepartment d
        on r.doctorSeq = d.doctorSeq
order by treatmentDate desc, mediSeq desc;

select * from vwDiagnosisHistory;


--2. 전체 목록 전체 출력
-- 번호, 접수자 이름, 자녀 이름, 상세증상, 진행상태(대기중/진료중/진료완료), 진료일시, 의사이름, 진행상태(대기중/진료중/진료완료) -> '예약거절'은 거르기
select r.mediSeq, u.userName, u.childName, r.symptom, d.departmentName, 
    d.doctorName, r.treatmentDate, r.waitingStatus
from vwRgstWtPtnt r
    inner join vwUserChild u
    on r.userSeq = u.userSeq
        inner join vwDoctorDepartment d
        on r.doctorSeq = d.doctorSeq
where r.hospitalId = 'yonse'
order by r.treatmentDate, r.mediSeq;


--상세보기 (진료예약번호 필요)
-- 번호,  접수자 이름, 접수자 주민등록번호, 접수자 전화번호, 자녀 이름, 자녀 주민등록번호, 상세증상, 진료과목, 의사이름, 예약시간, 접수일시, 진행상태(대기중/진료중/진료완료)
select r.mediSeq, u.userName, u.userSSN, u.userTel, u.childName, u.childSSN, r.symptom, d.departmentName, 
    d.doctorName, to_char(r.treatmentDate, 'hh24:mi') as treatmentTime, r.regdate, r.waitingStatus
from vwRgstWtPtnt r
    inner join vwUserChild u
    on r.userSeq = u.userSeq
        inner join vwDoctorDepartment d
        on r.doctorSeq = d.doctorSeq
where r.mediSeq = 56
order by treatmentTime, mediSeq;


--진료대기 상태 수정
--1. 진행상태 -> 진료중
update tblWatingPatientList set waitingStatus = '진료중' where mediSeq = 117;

--2. 진행상태 -> 진료완료
update tblWatingPatientList set waitingStatus = '진료완료' where mediSeq = 117;


--진료내역
--작성하기
insert into tblMediHistory (mediHistorySeq, mediSeq, mediName, mediCode, mediContent) values (seqMediHistory.nextVal, ?, ?, ?, ?);

select * 
from tblmediHistory h
    inner join vwRgstWtPtnt r
    on h.mediSeq = r.mediSeq;

--전체 진료내역 보기 ..?
--select * 
--from tblmediHistory h
--    inner join vwRgstWtPtnt r
--    on h.mediSeq = r.mediSeq;

-- 부모와 자녀의 추가 정보와 의사의 추가 정보 필요하다면 조인하기. 아니면 더 크게 뷰로 만들어서 사용하기.
select h.mediHistorySeq, r.mediSeq, r.userSeq, r.childSeq, r.doctorSeq, r.treatmentDate, r.regdate, r.symptom, r.dispenseSeq, r.waitingPatientSeq, h.mediName, h.mediCode, h.mediContent
from tblmediHistory h
    inner join vwRgstWtPtnt r
    on h.mediSeq = r.mediSeq
order by mediHistorySeq;


--약 제조 테이블에 상태 변경
update tblDispense set dispenseStatus = '대기' where dispenseSeq = ?;


-------------------------------------------------
--내원환자 관리
--환자 목록 보기 (병원 아이디 필요)
--1. 전체 목록 보기

-- userSeq가 겹치는데 상관없으면 그대로 써도 된다. 자녀 주소가 필요하면 부모 주소 가져와서 넣으면 된다.
select *
from (select userSeq, userName, userSSN, userTel, userAddress, userEmail, userChild, registerDate
from tblUser
where userSeq in (select userSeq
    from tblRegister
    where hospitalId = 'yonse')
union
select childSeq as userSeq, childName as userName, childSSN as userSSN, childTel as userTel, 
    null as userAddress,
    null as userEmail, '자녀' as userChild, null as registerDate
from tblChild
where childSeq in (select childSeq
    from tblRegister
    where hospitalId = 'yonse' and childSeq is not null));




--select *
--from vwUserChild
--where userSeq in (select userSeq
--    from vwRgstWtPtnt
--    where hospitalId = 'yonse') or childSeq in (select childSeq
--    from vwRgstWtPtnt
--    where hospitalId = 'yonse' and childSeq is not null);

병원에 방문한 본인회원
+ 병원에 방문한 자녀회원
회원번호, 회원이름, 회원 주민번호, 회원 전화번호, 회원 주소, 회원 이메일, userChild, 자녀번호?, 등록일
부모면 그대로, 자녀라면
번호, 이름, 주민번호, 전화번호는 그대로. 주소와 이메일은 부모값, userChild는 null, 등록일은 부모의 등록일

테이블 두개 만들어서 union 하기

--select *
--from tblUser
--where userSeq in (select userSeq
--    from tblRegister
--    where hospitalId = 'yonse');


--select c.childSeq, c.userSeq, u.userAddress
--from tblChild c
--    inner join tblUser u
--    on c.userSeq = u.userSeq
--where childSeq in (select childSeq
--    from tblRegister
--    where hospitalId = 'yonse' and childSeq is not null);

--기타의견 작성
insert into tblPatientMemo (patientMemoSeq, hospitalId, userSeq, userType, memo) values (seqPatientMemo.nextVal, ?, ?, ?, ?, ?); 

--select * 
--from tblPatientMemo
--where userSeq = ? and type = ?;


--서류요청
--목록 (병원 아이디 필요)
--날짜 타입 확인하기
select r.mediSeq, r.userSeq, r.childSeq, to_char(r.treatmentDate, 'yyyy-mm-dd hh24:mi:ss') as treatmentDate, d.reqDocumentContent, d.status
from tblRegister r
    inner join tblMediHistory h
    on r.mediSeq = h.mediSeq
        inner join tblRequestDocument d
        on h.mediHistorySeq = d.mediHistorySeq
where r.hospitalId = 'yonse';

--상세보기 (보류)

--상태 변경 (서류요청번호 또는 진료내역번호 필요)
--1. 승인
update tblRequestDocument set status = '승인' where mediHistorySeq = ?;

--2. 거절
update tblRequestDocument set status = '거절' where mediHistorySeq = ?;


--------------------------------------------------------------------
--건강검진 (병원아이디 필요)
--전체 내역
--번호, 예약일시, 아이디, 예약자 이름, (회원번호) 주민등록번호, 신청일시, 문진표 현황(요청/미작성/작성완료)
-- -> 날짜 타입 확인하기
select r.mediCheckupSeq, to_char(r.reservationDate, 'yyyy-mm-dd hh24:mi:ss') as reservationDate, r.userSeq, u.userId, u.userName, u.userSSN, r.regdate, w.isCheckUp
from tblMediCheckupReservation r
    inner join tblCheckupWaiting w
    on r.mediCheckupSeq = w.mediCheckupSeq
        inner join tblUser u
        on u.userSeq = r.userSeq
where hospitalId = 'yonse';

--건강검진 예약이랑 진료 대기랑 합쳐서 뷰로 만들까?


--문진표보기 (건강검진번호 필요)
select *
from tblMediCheckupReservation f
    inner join tblOnlineFormResult r
    on f.mediCheckupSeq = r.mediCheckupSeq
        inner join tblOnlineFormAnswer a
        on r.formAnswerSeq = a.formAnswerSeq
where r.mediCheckupSeq = 1;

--문진표도 뷰로 만들어버릴까?
select q.formSeq, q.formQuestionContent, a.formAnswerSeq, a.answerNumber, a.formAnswer
from tblOnlineFormQuestion q
    inner join tblOnlineFormAnswer a
    on q.formSeq = a.formSeq;


--기타의견 작성 (검진예약번호 필요)
update tblCheckupWaiting set checkupEtc = ? where mediCheckupSeq = ?;

-------------------------
--의학상담
--의사 선택(병원 아이디 필요)
--의사번호, 아이디, 이름, 진료과목, 사진
select doctorSeq, doctorName, departmentName, doctorImage
from vwDoctorDepartment
where hospitalId = 'yonse';

--의사가 작성한 상담 목록(의사번호 필요)
--번호, 게시글 제목, 게시글 작성자 아이디, 답변작성일
select q.mediCounselQuestionSeq, q.counselTitle, u.userId, q.regdate
from tblMediCounselingAnswer a
    inner join tblMediCounselingQuestion q
    on a.mediCounselQuestionSeq = q.mediCounselQuestionSeq
        inner join tblUser u
        on q.userSeq = u.userSeq
where doctorSeq = 2;


--상담 답변 상세보기(의사번호, 게시글번호 필요)
--게시글 번호, 제목, 내용, 작성자아이디, 작성일시, 답변글, 답변작성일시, 의사이름, 병원이름
select q.mediCounselQuestionSeq, q.counselTitle, q.counselContent, u.userId, a.counselAnswerContent, a.answerTime, d.doctorName, h.hospitalName
from tblMediCounselingAnswer a
    inner join tblMediCounselingQuestion q
    on a.mediCounselQuestionSeq = q.mediCounselQuestionSeq
        inner join tblUser u
        on q.userSeq = u.userSeq
            inner join tblDoctor d
            on d.doctorSeq = a.doctorSeq
                inner join tblHospital h
                on d.hospitalId = h.hospitalId
where a.doctorSeq = 2 and q.mediCounselQuestionSeq = 1;

--------------------------
--요청/신청
--병원 입점
--현재 입점 여부 (병원 아이디 필요)
--결과가 1이면 입점. 0이면 미입점
select count(*)
from tblEntry
where hospitalId = 'yonse';


--입점 요청 테이블(병원아이디 필요)
--번호, 입점요청일시, 입점요청서(보기), 처리현황(신청완료/심사 중/승인or거절), 입점일시
select e.entrySeq, d.regdate, e.status, d.entryDate
from tblEntry e
    inner join tblEntryDate d
    on e.entrySeq = d.entrySeq
where hospitalId = 'yonse'; 


--입점요청서
--요청서 화면 출력 (조회만 하기)
-- 병원아이디, 병원명, 사업자등록번호, 주소, 이메일, 연락처, 대표의사번호, 대표의사이름, 
-- 진료과목, 운영정보(대면가능여부, 비대면가능여부, 왕진가능여부, 예방접종가능여부, 
-- 건강검진가능여부, 야간진료여부, 휴일진료여부), 운영시간, 휴무일, 휴게시간

--select *
--from 병원회원, 대표 의사, 의사, 병원운영정보, 병원-진료과목번호, 진료과목, 병원휴게시간, 
--    병원휴무일, 운영시간

select *
from vwEntryFormHspt
where hospitalId = 'yonse';

--select h.hospitalId, h.hospitalName, h.hospitalSSN, h.hospitalAddress, h.hospitalEmail,
--    h.hospitalTel, hd.doctorSeq, d.doctorName, dp.departmentName, o.face, o.unface, o.houseCall, o.vaccination,
--    o.isHealthCheck, o.isHospitalNightCare, o.isHospitalHoliday, ot.openTime, ot.closeTime,
--    f.hospitalDayOff, r.openTime as restStartTime, r.closeTime as restEndTime
--from tblHospital h
--    inner join tblHeadDoctor hd
--    on h.hospitalId = hd.hospitalId
--        inner join tblDoctor d
--        on hd.doctorSeq = d.doctorSeq
--            inner join tblHospitalOperation o
--            on h.hospitalId = o.hospitalId
--                inner join tblHospitalTreatment t
--                on h.hospitalId = t.hospitalId
--                    inner join tblDepartment dp
--                    on t.departmentSeq = dp.departmentSeq
--                        inner join tblRestTime r
--                        on h.hospitalId = r.hospitalId
--                            inner join tblHospitalDayOff f
--                            on h.hospitalId = f.hospitalId
--                                inner join tblOperatingTime ot
--                                on h.hospitalid = ot.hospitalId
--where h.hospitalId = 'yonse';


--작성
--tblEntry와 tblEntryDate에 insert
insert into tblEntry (entrySeq, entryType, hospitalId, pharmacyId, status) values (seqEntry.nextVal, '병원', ?, null, default);
insert into tblEntryDate (entryDateSeq, entrySeq, regdate, entryDate) values (seqEntryDate.nextVal, ?, default, null);


--예방접종가능신청
--안해.

commit;