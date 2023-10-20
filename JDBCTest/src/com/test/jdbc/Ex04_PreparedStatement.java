package com.test.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;

public class Ex04_PreparedStatement {
	public static void main(String[] args) {
		// Ex04_PreparedStatement.java
		m1();

	}// main

	private static void m1() {

		// Statement vs PreparedStatement
		// - Statement > 정적 SQL(매개변수 X)
		// - PreparedSatement > 동적 SQL(매개변수 O)
		
		//PreparedStaement 장점
		//1. 매개변수 관리 용이
		//2. 매개변수 유효성 처리
		
		// => 전달할 값 없음 > Statement, 값 있음 > PreparedStatement 사용
		

		// 정적 SQL
		String sql = "insert into tblAddress (seq, name, age, gender, address, regdate) values (seqAddress.nextVal, '아무개', 22, 'm', '서울시 강남구 대치동', default)";

		// 정적 SQL
		sql = "insert into tblAddress (seq, name, age, gender, address, regdate) values (seqAddress.nextVal, '%s', %s, '%s', '%s', default)";

		// 동적 SQL - ? 는 오라클 변수다. '%s'의 역할이다.
		sql = "insert into tblAddress (seq, name, age, gender, address, regdate) values (seqAddress.nextVal, ?, ?, ?, ?, default)";

		// insert + 사용자 입력 + Scanner
		String name = "하하하";
		String age = "20";
		String gender = "m";
		String address = "서울시 강남구 역삼동's 아파트";

		// 1.
		// ' -> ''
//		name = name.replace("'", "''");
//		address = address.replace("'", "''");

		Connection conn = null;
		Statement stat = null;
		PreparedStatement pstat = null;

		try {
			conn = DBUtil.open();

//			// 1. Statement
//			sql = String.format(
//					"insert into tblAddress (seq, name, age, gender, address, regdate) values (seqAddress.nextVal, '%s', %s, '%s', '%s', default)",
//					name, age, gender, address);
//
//			//insert into tblAddress (seq, name, age, gender, address, regdate) 
//			//	values (seqAddress.nextVal, '하하하', 20, 'm', '서울시 강남구 역삼동's 아파트', default) -> oracle에서는 \'아니고 ''다.
//			System.out.println(sql); 
//			
//			stat = conn.createStatement();
//			
//			int result = stat.executeUpdate(sql);
//			
//			System.out.println(result);

			//
			// 2. PreparedStatement
			sql = "insert into tblAddress (seq, name, age, gender, address, regdate) values (seqAddress.nextVal, ?, ?, ?, ?, default)";

			pstat = conn.prepareStatement(sql); // 생성 + 쿼리 입력
			
			//pstat > 매개변수를 관리하는 역할 겸함
			pstat.setString(1, name);
			pstat.setString(2, age);
			pstat.setString(3, gender);
			pstat.setString(4, address);

			int result = pstat.executeUpdate(); // 인덱스에서 누락된 IN 또는 OUT 매개변수:: 1 -> 1번 매개변수 값이 없다.
			
			System.out.println(result);

			pstat.close(); //2.
//			stat.close(); //1.
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}// m1
}
