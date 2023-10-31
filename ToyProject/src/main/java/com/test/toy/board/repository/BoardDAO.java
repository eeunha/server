package com.test.toy.board.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.test.toy.DBUtil;
import com.test.toy.board.model.BoardDTO;

public class BoardDAO {
	private Connection conn;
	private Statement stat;
	private PreparedStatement pstat;
	private ResultSet rs;

	public BoardDAO() {
		conn = DBUtil.open();
	}

	public int add(BoardDTO dto) {
		try {

			String sql = "insert into tblBoard (seq, subject, content, regdate, readcount, id) values (seqBoard.nextVal, ?, ?, default, default, ?)";

			pstat = conn.prepareStatement(sql);
			pstat.setString(1, dto.getSubject());
			pstat.setString(2, dto.getContent());
			pstat.setString(3, dto.getId());

			return pstat.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

	public ArrayList<BoardDTO> list() {
		try {

			String sql = "select * from vwBoard";

			stat = conn.createStatement();
			rs = stat.executeQuery(sql);

			ArrayList<BoardDTO> list = new ArrayList<>();

			while (rs.next()) {
				BoardDTO dto = new BoardDTO();

				dto.setSeq(rs.getString("seq"));
				dto.setSubject(rs.getString("subject"));
				dto.setId(rs.getString("id"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setName(rs.getString("name"));
				dto.setIsnew(rs.getInt("isnew"));

				list.add(dto);
			}

			return list;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}
