package com.test.toy.user.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import com.test.toy.DBUtil;
import com.test.toy.user.model.UserDTO;

public class UserDAO {
	private Connection conn;
	private Statement stat;
	private PreparedStatement pstat;
	private ResultSet rs;

	public UserDAO() {
		conn = DBUtil.open();
	}

	public int register(UserDTO dto) {
		/*
		 * 매개변수 유/무 반환값 유/무 > 단일값, DTO, List<DTO>
		 * 
		 * queryNoParamNoReturn queryParamNoReturn
		 * 
		 * queryNoParamTokenReturn queryParamTokenReturn
		 * 
		 * queryNoParamDTOReturn queryParamDTOReturn
		 * 
		 * queryNoParamListReturn queryParamListReturn
		 * 
		 * 
		 */

		return 0;
	}

}
