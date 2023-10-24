package com.test.memo.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.test.memo.DBUtil;
import com.test.memo.model.MemoDTO;

public class MemoDAO {

	private Connection conn = null;
	private Statement stat = null;
	private PreparedStatement pstat = null;
	private ResultSet rs;

	// 생성자에서 연결작업 진행
	public MemoDAO() {
		this.conn = DBUtil.open();
	}

	public int add(MemoDTO dto) {

		// DTO > insert

		try {
			String sql = "insert into tblMemo (seq, name, pw, memo, regdate) values (seqMemo.nextval, ?, ?, ?, default)";

			pstat = conn.prepareStatement(sql);
			pstat.setString(1, dto.getName());
			pstat.setString(2, dto.getPw());
			pstat.setString(3, dto.getMemo());

			return pstat.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

	public ArrayList<MemoDTO> list() {
		
		ArrayList<MemoDTO> list = new ArrayList<>();
		
		try {
			String sql = "select * from tblMemo order by seq desc";

			stat = conn.createStatement();

			rs = stat.executeQuery(sql);

			// rs == 메모 목록

			while(rs.next()) {
				
				//레코드 1줄 > MemoDTO 1개
				MemoDTO dto = new MemoDTO();
				
				dto.setSeq(rs.getString("seq"));
				dto.setName(rs.getString("name"));
				dto.setPw(rs.getString("pw"));
				dto.setMemo(rs.getString("memo"));
				dto.setRegdate(rs.getString("regdate"));
				
				list.add(dto);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	public MemoDTO get(String seq) {
		try {
			String sql = "select * from tblMemo where seq = ?";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, seq);
			
			rs = pstat.executeQuery();
			
			if (rs.next()) {
				MemoDTO dto = new MemoDTO();
				
				dto.setSeq(rs.getString("seq"));
				dto.setName(rs.getString("name"));
				dto.setPw(rs.getString("pw"));
				dto.setMemo(rs.getString("memo"));
				dto.setRegdate(rs.getString("regdate"));
			
				return dto;
			}
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return null;
	}

	public int edit(MemoDTO dto) {
		try {
			String sql = "update tblMemo set name = ?, memo = ? where seq = ?";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, dto.getName());
			pstat.setString(2, dto.getMemo());
			pstat.setString(3, dto.getSeq());
			
			return pstat.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return 0;
	}

	public boolean check(MemoDTO dto) {
		try {
			String sql = "select count(*) as cnt from tblMemo where seq = ? and pw = ?";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, dto.getSeq());
			pstat.setString(2, dto.getPw());
			
			
			rs = pstat.executeQuery();
			
			if (rs.next()) {
				return rs.getInt("cnt") == 1 ? true : false;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}

	public int del(String seq) {
		try {
			String sql = "delete from tblMemo where seq = ?";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, seq);
			
			return pstat.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return 0;
	}
}
