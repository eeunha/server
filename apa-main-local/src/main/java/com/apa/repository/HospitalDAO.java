package com.apa.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.apa.model.HospitalDTO;

public class HospitalDAO {
	private Connection conn;
	private Statement stat;
	private PreparedStatement pstat;
	private ResultSet rs;

	public HospitalDAO() {
//		conn = DBUtil.open(); 

		conn = DBUtil.open("localhost", "apa_test_2", "java1234");
	}

	public HospitalDTO login(HospitalDTO dto) {
		try {

			String sql = "select * from tblHospital where hospitalId = ? and hospitalPw = ? and isHospitalUnregister = 'n'";

			pstat = conn.prepareStatement(sql);
			pstat.setString(1, dto.getHospitalId());
			pstat.setString(2, dto.getHospitalPw());

			rs = pstat.executeQuery();

			if (rs.next()) {
				HospitalDTO result = new HospitalDTO();

				result.setHospitalId(rs.getString("hospitalId"));
				result.setHospitalName(rs.getString("hospitalName"));

				return result;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

}
