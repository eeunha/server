package com.test.toy.board;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.test.toy.board.model.BoardDTO;
import com.test.toy.board.repository.BoardDAO;

@WebServlet("/board/list.do") // 가상주소 바로 생성
public class List extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// List.java

		// 1. DB 작업 > select
		// 2. 반환 > jsp 호출

		// 1.
		BoardDAO dao = new BoardDAO();

		ArrayList<BoardDTO> list = dao.list();

		// 1.5. 데이터 가공
		for (BoardDTO dto : list) {

			// 날짜 자르기
//			String regdate = dto.getRegdate();
//			dto.setRegdate(regdate.substring(0, 10));
			
		}

		// 3.
		req.setAttribute("list", list);

		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/board/list.jsp");
		dispatcher.forward(req, resp);

	}
}
