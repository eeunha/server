package com.test.ajax.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.test.ajax.model.CatDTO;
import com.test.ajax.repository.AjaxDAO;

@WebServlet("/ex07.do") // 가상주소 바로 생성
public class Ex07 extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//Ex07.java
		
		AjaxDAO dao = new AjaxDAO();
		
		ArrayList<CatDTO> list = dao.listCat();
		
		req.setAttribute("list", list);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/ex07.jsp");
		dispatcher.forward(req, resp);

	}
}

