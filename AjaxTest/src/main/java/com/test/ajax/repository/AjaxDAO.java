package com.test.ajax.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class AjaxDAO {
	private Connection conn = null;
	private Statement stat = null;
	private PreparedStatement pstat = null;
	private ResultSet rs = null;

	public AjaxDAO() {
		conn = DBUtil.open();
	}

	public int getMemoCount() {

		try {
			String sql = "select count(*) as cnt from tblMemo";

			stat = conn.createStatement();

			rs = stat.executeQuery(sql);

			if (rs.next()) {
				return rs.getInt("cnt");
			}

		} catch (Exception e) {
			System.out.println("AjaxDAO.getMemoCount()");
			e.printStackTrace();
		}

		return 0;
	}

	public int getMemoCount(String name) {

		try {
			String sql = String.format("select count(*) as cnt from tblMemo where name = '%s'", name);

			stat = conn.createStatement();

			rs = stat.executeQuery(sql);

			if (rs.next()) {
				return rs.getInt("cnt");
			}

		} catch (Exception e) {
			System.out.println("AjaxDAO.getMemoCount()");
			e.printStackTrace();
		}

		return 0;
	}
}
