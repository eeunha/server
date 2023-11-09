package com.apa.repository;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {
	private static Connection conn;

	public static Connection open() {
		String url = "jdbc:oracle:thin:@192.168.10.53:1521:xe";
		String id = "apa";
		String pw = "java1234";

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");

			conn = DriverManager.getConnection(url, id, pw);

			return conn;
		} catch (Exception e) {
			System.out.println("DBUtil.open()");
			e.printStackTrace();
		}

		return null;
	}

	public static Connection open(String server, String id, String pw) {
		String url = "jdbc:oracle:thin:@" + server + ":1521:xe";

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, id, pw);
			return conn;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
