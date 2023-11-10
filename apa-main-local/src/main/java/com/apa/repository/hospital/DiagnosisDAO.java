package com.apa.repository.hospital;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

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

//			String sql = "select * from vwRegisterList where to_date(regdate, 'yyyy-mm-dd') = to_date((select sysdate from dual), 'yyyy-mm-dd') and hospitalId = ?";
			String sql = "select * from vwRegisterList where hospitalId = ?";
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

//			System.out.println(list.size());
			return list;

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
}
