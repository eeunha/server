package com.test.jdbc;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;

import oracle.jdbc.OracleTypes;

public class Ex05_CallableStatement {

	public static void main(String[] args) {

		// Ex05_CallableStatement.java

//		m1();
//		m2();
//		m3();
//		m4();
		m5();

	}// main

	private static void m5() {

		Connection conn = null;
		CallableStatement stat = null;
		ResultSet rs = null;

		try {
			conn = DBUtil.open();

			String sql = "{call procM5(?)}";

			stat = conn.prepareCall(sql);

			stat.registerOutParameter(1, OracleTypes.CURSOR);

			stat.executeQuery();

			// 오라클 커서 == 결과 테이블 탐색하는 참조 객체 == 결과 테이블
			// ResultSet == 결과 테이블 탐색하는 참조 객체 == 결과 테이블
			// 오라클 커서 == ResultSet //동일한 구조
			rs = (ResultSet) stat.getObject(1);

			while (rs.next()) {
				System.out.println(rs.getString("name"));
				System.out.println(rs.getString("age"));
				System.out.println();
			}
			
			rs.close();
			stat.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private static void m4() {

		Connection conn = null;
		CallableStatement stat = null;
		ResultSet rs = null;

		try {
			conn = DBUtil.open();

			String sql = "{ call procM4(?, ?, ?) }";

			stat = conn.prepareCall(sql);

			stat.registerOutParameter(1, OracleTypes.VARCHAR);
			stat.registerOutParameter(2, OracleTypes.NUMBER);
			stat.registerOutParameter(3, OracleTypes.VARCHAR);

			stat.executeQuery();

			System.out.println(stat.getString(1));
			System.out.println(stat.getInt(2));
			System.out.println(stat.getString(3));

			stat.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private static void m3() {

		Connection conn = null;
		CallableStatement stat = null;
		ResultSet rs = null;

		try {
			conn = DBUtil.open();

			String sql = "{call procM3(?)}"; // out도 ? 사용하기
			stat = conn.prepareCall(sql);

			// out 매개변수
			stat.registerOutParameter(1, OracleTypes.NUMBER);

			// int result = stat.executeUpdate();
			stat.executeQuery(); // ResultSet 안받음. 이 문장 쓰는게 좋다.

			// rs.getInt(1) -> 첫번째 행
			int cnt = stat.getInt(1); // out 매개변수 읽기 -> 첫번째 등록한 out parameter 읽어라.

			System.out.println(cnt); // 10 -> 10명 있다.

			stat.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private static void m2() {

		Connection conn = null;
		CallableStatement stat = null;
		ResultSet rs = null;

		try {
			conn = DBUtil.open();

			String sql = "{ call procM2(?, ?, ?, ?) }";
			stat = conn.prepareCall(sql);

			stat.setString(1, "홍길동2");
			stat.setString(2, "20");
			stat.setString(3, "m");
			stat.setString(4, "서울시 강남구 역삼동");

			int result = stat.executeUpdate();

			System.out.println(result);

			stat.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private static void m1() {

		Connection conn = null;
		CallableStatement stat = null;
		ResultSet rs = null;

		try {
			conn = DBUtil.open();

			// db에 procedure 생성하고 오기

			String sql = "{ call procM1 }";
			stat = conn.prepareCall(sql);

			int result = stat.executeUpdate();

			System.out.println(result);

			stat.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
