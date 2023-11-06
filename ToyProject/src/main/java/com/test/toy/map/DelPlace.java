package com.test.toy.map;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/map/delplace.do") // 가상주소 바로 생성
public class DelPlace extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//DelPlace.java
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/map/delplace.jsp");
		dispatcher.forward(req, resp);

	}
}
