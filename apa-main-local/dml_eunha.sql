--예약목록 (병원 아이디 필요)
--1. 오늘 접수된 예약
--번호, 접수자번호, 접수자이름, 예약일시, 의사이름, 상세증상, 신청일시
select * from vwRegisterList where to_date(regdate, 'yyyy-mm-dd') = to_date((select sysdate from dual), 'yyyy-mm-dd') and mediSeq not in (select mediSeq from tblWatingPatientList) and hospitalId = ? order by regdate;

--select *
--from vwRegisterList
--where to_date(regdate, 'yyyy-mm-dd') = to_date((select sysdate from dual), 'yyyy-mm-dd')
--    and mediSeq not in (select mediSeq from tblWatingPatientList)
--    and hospitalId = ?;    



-- (대기) 예약 상세보기 (진료예약번호 필요)
-- mediSeq, hospitalId, userSeq, childSeq, mediWay, doctorSeq, treatmentDate, regdate, symptom, dispenseSeq, userName, userSSN, userID, userTel,
-- userAddress, userEmail, userChild, chidlName, childSSN, childTel, doctorName, doctorImage, departmentName
select * from vwRegisterDetail where mediSeq = 321;


-- 예약 승인
--진료대기환자목록에 추가
insert into tblWatingPatientList (waitingPatientSeq, mediSeq, waitingStatus) values (seqWatingPatientList.nextVal, ?, default);


--예약 거부
insert into tblWatingPatientList (waitingPatientSeq, mediSeq, waitingStatus) values (seqWatingPatientList.nextVal, ?, '예약거부');


select * from tblWatingPatientList where mediseq = 321;
delete from tblWatingPatientList where mediseq = 321;
commit;


--2. 전체 예약 목록
select *
from (
select a.*, rownum as rnum
from (
select r.mediSeq, userSeq, userName, treatmentDate, doctorName, symptom, regdate, waitingPatientSeq, 
    case 
        when waitingStatus = '예약거부' then '거부'
        when waitingStatus is null then '대기'
        else '승인'
    end as waitingStatus
from vwRegisterList r left outer join tblWatingPatientList p on r.mediSeq = p.mediSeq where hospitalId = 'yonse'
order by regdate desc, treatmentDate desc) a)
where rnum between 1 and 10;

--select r.mediSeq, userSeq, userName, treatmentDate, doctorName, symptom, regdate, waitingPatientSeq, 
--    case 
--        when waitingStatus = '예약거부' then '거부'
--        when waitingStatus is null then '대기'
--        else '승인'
--    end as waitingStatus
--from vwRegisterList r left outer join tblWatingPatientList p on r.mediSeq = p.mediSeq where hospitalId = 'yonse'
--order by treatmentDate desc, regdate desc;

--해당 병원의 총 예약 개수
select count(*)
from vwRegisterList r left outer join tblWatingPatientList p on r.mediSeq = p.mediSeq where hospitalId = 'yonse';



-- 전체 예약 상세보기
-- (대기) 예약 상세보기 (진료예약번호 필요)
-- mediSeq, hospitalId, userSeq, childSeq, mediWay, doctorSeq, treatmentDate, regdate, symptom, dispenseSeq, userName, userSSN, userID, userTel,
-- userAddress, userEmail, userChild, childSSN, childTel, doctorName, doctorImage, departmentName
select r.mediSeq, userSeq, childSeq, mediWay, doctorSeq, treatmentDate, regdate, symptom, dispenseSeq, userName, userSSN, userId, userTel, userAddress,
    userEmail, userChild, chidlName, childSSN, childTel, doctorName, doctorImage, departmentName, waitingPatientSeq, 
    case
        when waitingStatus is null then '대기'
        when waitingStatus = '예약거부' then '거부'
        else '승인'
    end as waitingStatus
from vwRegisterDetail r 
    left outer join tblWatingPatientList p 
    on r.mediSeq = p.mediSeq 
where r.mediSeq = 321;


select r.mediSeq, userSeq, childSeq, mediWay, doctorSeq, treatmentDate, regdate, symptom, dispenseSeq, userName, userSSN, userId, userTel, userAddress, userEmail, userChild, childName, childSSN, childTel, doctorName, doctorImage, departmentName, waitingPatientSeq, case when waitingStatus is null then '대기' when waitingStatus = '예약거부' then '거부' else '승인' end as waitingStatus from vwRegisterDetail r left outer join tblWatingPatientList p on r.mediSeq = p.mediSeq where r.mediSeq = 321;

--select r.mediSeq, userSeq, userName, treatmentDate, doctorName, symptom, regdate, waitingPatientSeq, 
--    case 
--        when waitingStatus = '예약거부' then '거부'
--        when waitingStatus is null then '대기'
--        else '승인'
--    end as waitingStatus
--from vwRegisterList r left outer join tblWatingPatientList p on r.mediSeq = p.mediSeq where r.mediSeq = 410
--order by treatmentDate desc, regdate desc;

--오늘의 진료기록
select a.*, rownum as rnum
from (
select * from vwDiagnosisHistory where to_date(treatmentDate, 'yyyy-mm-dd') = to_date((select sysdate from dual), 'yyyy-mm-dd') order by treatmentDate, mediSeq) a
where rownum between 1 and 10;

select a.*, rownum as rnum
from (
select * from vwDiagnosisHistory order by treatmentDate, mediSeq) a
where rownum between 1 and 10;

--오늘의 진료기록 병원 아이디 필요
select a.*, rownum as rnum
from (select * 
    from vwDiagnosisHistory 
    where to_date(treatmentDate, 'yyyy-mm-dd') = to_date((select sysdate from dual), 'yyyy-mm-dd') 
        and hospitalId = ? 
    order by treatmentDate) a
where rownum between ? and ?;

--오늘의 진료 내역 개수 (병원 아이디 필요)
select count(*) as cnt
from vwDiagnosisHistory 
where to_date(treatmentDate, 'yyyy-mm-dd') = to_date((select sysdate from dual), 'yyyy-mm-dd') and hospitalId = ?;


select count(*) 
from vwRegisterList r left outer join tblWatingPatientList p on r.mediSeq = p.mediSeq where hospitalId = 'yonse';

select * from tblWatingPatientList where mediseq = 313;
delete from tblWatingPatientList where mediseq = 313;
commit;