package com.apa.repository.hospital;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

import com.apa.model.hospital.DiagnosisHistoryDTO;
import com.apa.model.hospital.DiagnosisRgstDTO;
import com.apa.repository.DBUtil;

public class DiagnosisDAO {
	private Connection conn;
	private Statement stat;
	private PreparedStatement pstat;
	private ResultSet rs;

	public DiagnosisDAO() {
//		conn = DBUtil.open(); 

		conn = DBUtil.open("localhost", "apa_test_2", "java1234");
	}

	public ArrayList<DiagnosisRgstDTO> getRegisterList(String hospitalId) {
		try {
			String sql = "select * from vwRegisterList where to_date(regdate, 'yyyy-mm-dd') = to_date((select sysdate from dual), 'yyyy-mm-dd') and mediSeq not in (select mediSeq from tblWatingPatientList) and hospitalId = ? order by regdate desc";
//			String sql = "select * from vwRegisterList where to_date(regdate, 'yyyy-mm-dd') = to_date((select sysdate from dual), 'yyyy-mm-dd') and hospitalId = ? order by regdate desc";
//			String sql = "select * from vwRegisterList where to_date(treatmentDate, 'yyyy-mm-dd') = to_date((select sysdate from dual), 'yyyy-mm-dd') and hospitalId = ?";
//			String sql = "select * from vwRegisterList where hospitalId = ?";
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, hospitalId);

			rs = pstat.executeQuery();

			ArrayList<DiagnosisRgstDTO> list = new ArrayList<>();

			
			while (rs.next()) {
				DiagnosisRgstDTO dto = new DiagnosisRgstDTO();
				
				dto.setMediSeq(rs.getString("mediSeq"));
				dto.setUserSeq(rs.getString("userSeq"));
				dto.setUserName(rs.getString("userName"));
				dto.setHospitalId(hospitalId);
				dto.setTreatmentDate(rs.getString("treatmentDate"));
				dto.setDoctorName(rs.getString("doctorName"));
				dto.setSymptom(rs.getString("symptom"));
				dto.setRegdate(rs.getString("regdate"));

				list.add(dto);
			}

			return list;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	public ArrayList<DiagnosisHistoryDTO> getHistoryList(HashMap<String, String> map) {
		try {

			String where = "";

//			String sql = "select r.mediSeq, u.userName, u.childName, r.symptom, d.departmentName, d.doctorName, to_char(r.treatmentDate, 'hh24:mi') as treatmentTime, r.waitingStatus from vwRgstWtPtnt r inner join vwUserChild u on r.userSeq = u.userSeq inner join vwDoctorDepartment d on r.doctorSeq = d.doctorSeq where to_date(r.treatmentDate, 'yyyy-mm-dd') = to_date((select sysdate from dual), 'yyyy-mm-dd') and r.hospitalId = ? order by mediSeq desc, treatmentTime desc";
//			String sql = "select r.mediSeq, u.userName, u.childName, r.symptom, d.departmentName, d.doctorName, to_char(r.treatmentDate, 'hh24:mi') as treatmentTime, r.waitingStatus from vwRgstWtPtnt r inner join vwUserChild u on r.userSeq = u.userSeq inner join vwDoctorDepartment d on r.doctorSeq = d.doctorSeq where to_date(r.treatmentDate, 'yyyy-mm-dd') = to_date((select sysdate from dual), 'yyyy-mm-dd') and r.hospitalId = ? order by treatmentTime desc, mediSeq desc";
//			String sql = "select r.mediSeq, u.userName, u.childName, r.symptom, d.departmentName, d.doctorName, to_char(r.treatmentDate, 'hh24:mi') as treatmentTime, r.waitingStatus from vwRgstWtPtnt r inner join vwUserChild u on r.userSeq = u.userSeq inner join vwDoctorDepartment d on r.doctorSeq = d.doctorSeq where r.hospitalId = ? order by treatmentTime desc, mediSeq desc";
//			String sql = String.format("select r.mediSeq, u.userName, u.childName, r.symptom, d.departmentName, d.doctorName, to_char(r.treatmentDate, 'hh24:mi') as treatmentTime, r.waitingStatus from vwRgstWtPtnt r inner join vwUserChild u on r.userSeq = u.userSeq inner join vwDoctorDepartment d on r.doctorSeq = d.doctorSeq where r.hospitalId = %s order by treatmentTime desc, mediSeq desc",);
			String sql = String.format(
					"select * from (select a.*, rownum as rnum from vwDiagnosisHistory a where to_date(a.treatmentDate, 'yyyy-mm-dd') = to_date((select sysdate from dual), 'yyyy-mm-dd') and a.hospitalId = '%s') where rnum between %s and %s",
					map.get("hospitalId"), map.get("begin"), map.get("end"));
//			String sql = String.format(
//					"select * from (select a.*, rownum as rnum from vwDiagnosisHistory a) where rnum between %s and %s",
//					map.get("begin"), map.get("end"));

			pstat = conn.prepareStatement(sql);

			rs = pstat.executeQuery();

			ArrayList<DiagnosisHistoryDTO> list = new ArrayList<>();

			while (rs.next()) {
				DiagnosisHistoryDTO dto = new DiagnosisHistoryDTO();

				dto.setMediSeq(rs.getString("mediSeq"));
				dto.setUserName(rs.getString("userName"));
				dto.setChildName(rs.getString("childName"));
				dto.setSymptom(rs.getString("symptom"));
				dto.setDepartmentName(rs.getString("departmentName"));
				dto.setDoctorName(rs.getString("doctorName"));
				dto.setTreatmentDate(rs.getString("treatmentDate"));
				dto.setWaitingStatus(rs.getString("waitingStatus"));

				list.add(dto);
			}

			return list;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public int approvalRegister(String mediSeq) {
		try {

			String sql = "insert into tblWatingPatientList (waitingPatientSeq, mediSeq, waitingStatus) values (seqWatingPatientList.nextVal, ?, default)";

			pstat = conn.prepareStatement(sql);
			pstat.setString(1, mediSeq);

			return pstat.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

	public int declineRegister(String mediSeq) {
		try {

			String sql = "insert into tblWatingPatientList (waitingPatientSeq, mediSeq, waitingStatus) values (seqWatingPatientList.nextVal, ?, '예약거부')";

			pstat = conn.prepareStatement(sql);
			pstat.setString(1, mediSeq);

			return pstat.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return 0;
	}

	public DiagnosisRgstDTO getRegisterDetail(String mediSeq) {
		try {
			
			String sql = "select * from vwRegisterDetail where mediSeq = ?";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, mediSeq);
			
			rs = pstat.executeQuery();
			
			if (rs.next()) {
				DiagnosisRgstDTO dto = new DiagnosisRgstDTO();
				
				dto.setMediSeq(mediSeq);
				dto.setUserSeq(rs.getString("userSeq"));
				dto.setChildSeq(rs.getString("childSeq"));
				dto.setMediWay(rs.getString("mediWay"));
				dto.setDoctorSeq(rs.getString("doctorSeq"));
				dto.setTreatmentDate(rs.getString("treatmentDate"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setSymptom(rs.getString("symptom"));
				dto.setDispenseSeq(rs.getString("dispenseSeq"));
				dto.setUserName(rs.getString("userName"));
				dto.setUserSSN(rs.getString("userSSN"));
				dto.setUserId(rs.getString("userId"));
				dto.setUserTel(rs.getString("userTel"));
				dto.setUserAddress(rs.getString("userAddress"));
				dto.setUserEmail(rs.getString("userEmail"));
				dto.setUserChild(rs.getString("userChild"));
				dto.setChildName(rs.getString("childName"));
				dto.setChildSSN(rs.getString("childSSN"));
				dto.setChildTel(rs.getString("childTel"));
				dto.setDoctorName(rs.getString("doctorName"));
				dto.setDoctorImage(rs.getString("doctorImage"));
				dto.setDepartmentName(rs.getString("departmentName"));
				
				return dto;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}

	public ArrayList<DiagnosisRgstDTO> getAllRegisterList(String hospitalId) {
		try {
			
			String sql = "select * from vwRegisterList where hospitalId = ?";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, hospitalId);
			
			rs = pstat.executeQuery();
			
			List<DiagnosisRgstDTO> list = new ArrayList<>();
			
			while (rs.next()) {
				DiagnosisRgstDTO dto = new DiagnosisRgstDTO();
				
				setter
				
				list.add(dto);
			}
			
			return list;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}
