--예약목록 (병원 아이디 필요)
--1. 오늘 접수된 예약
--번호, 접수자번호, 접수자이름, 예약일시, 의사이름, 상세증상, 신청일시
select *
from vwRegisterList
where to_date(regdate, 'yyyy-mm-dd') = to_date((select sysdate from dual), 'yyyy-mm-dd')
    and mediSeq not in (select mediSeq from tblWatingPatientList)
    and hospitalId = ?;



-- 예약 상세보기 (진료예약번호 필요)
-- mediSeq, hospitalId, userSeq, childSeq, mediWay, doctorSeq, treatmentDate, regdate, symptom, dispenseSeq, userName, userSSN, userID, userTel,
-- userAddress, userEmail, userChild, childSSN, childTel, doctorName, doctorImage, departmentName
select * from vwRegisterDetail where mediSeq = 321;


-- 예약 승인
--진료대기환자목록에 추가
insert into tblWatingPatientList (waitingPatientSeq, mediSeq, waitingStatus) values (seqWatingPatientList.nextVal, ?, default);


--예약 거부
insert into tblWatingPatientList (waitingPatientSeq, mediSeq, waitingStatus) values (seqWatingPatientList.nextVal, ?, '예약거부');


select * from tblWatingPatientList where mediseq = 321;
delete from tblWatingPatientList where mediseq = 321;
commit;