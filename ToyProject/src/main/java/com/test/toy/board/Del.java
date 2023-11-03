package com.test.toy.board;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.test.toy.board.repository.BoardDAO;

@WebServlet("/board/del.do") // 가상주소 바로 생성
public class Del extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//Del.java
		//- del.do?seq=5
		
		if (Auth.check(req, resp)) {
			return;
		}
		
		//1.
		String seq = req.getParameter("seq");
		
		//2.
		req.setAttribute("seq", seq); // 전달용
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/board/del.jsp");
		dispatcher.forward(req, resp);

	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//DelOk.java 역할
		//1. 데이터 가져오기(seq)
		//2. DB 작업 > delete
		//3. 피드백
		
		//1.
		String seq = req.getParameter("seq");
		
		//2.
		BoardDAO dao = new BoardDAO();
		
		//딸린 댓글들 삭제
		dao.delCommentAll(seq);
		
		int result = dao.del(seq); // 댓글이 있으면 문제 발생
		
		if (result == 1) {
			resp.sendRedirect("/toy/board/list.do");
		} else {
			PrintWriter writer = resp.getWriter();
			writer.print("<script>alert('failed');history.back();</script>");
			writer.close();
		}
		
	}
}

