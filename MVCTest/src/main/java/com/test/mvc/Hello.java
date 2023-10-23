package com.test.mvc;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Hello extends HttpServlet{
	
	@Override //브라우저가 호출하는 기본은 get이다.
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//서블릿 호출
		//업무 처리
		
		//HTML 페이지 생산 > 불편 > JSP 위임
//		resp.sendRedirect("/mvc/hello.jsp");
		
		//DB 작업 > select count(*)
		int count = 100;
		
		//서블릿 > 자신의 업무 완료 > 산출물 일부 > 출력 > JSP 페이지 전달
		req.setAttribute("count", count); // Hello.java를 보지만 /hello.do 주소로 보인다.
		
		//resp.sendRedirect("/mvc/hello.jsp");
		//pageContext.forward("/mvc/hello.jsp");
		
		// '/' > webapp 폴더
//		RequestDispatcher dispatcher = req.getRequestDispatcher("JSP 페이지 위치");
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/helo.jsp");
		dispatcher.forward(req, resp);
	}
}
