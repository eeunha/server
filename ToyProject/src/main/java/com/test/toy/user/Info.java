package com.test.toy.user;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.test.toy.user.model.UserDTO;
import com.test.toy.user.repository.UserDAO;

@WebServlet("/user/info.do") // 가상주소 바로 생성
public class Info extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//Info.java
		
		//1. 
		String id = req.getSession().getAttribute("id").toString();
		
		UserDAO dao = new UserDAO();
		
		UserDTO dto = dao.get(id);
		
		dto.setIntro(dto.getIntro().replace("\r\n", "<br>"));
		
		//3.
		req.setAttribute("dto", dto);		
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/user/info.jsp");
		dispatcher.forward(req, resp);

	}

}
