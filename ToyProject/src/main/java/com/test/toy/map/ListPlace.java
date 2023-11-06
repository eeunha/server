package com.test.toy.map;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/map/listplace.do") // 가상주소 바로 생성
public class ListPlace extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//ListPlace.java
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/map/listplace.jsp");
		dispatcher.forward(req, resp);

	}
}
