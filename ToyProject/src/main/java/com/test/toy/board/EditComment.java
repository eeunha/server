package com.test.toy.board;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.test.toy.board.model.CommentDTO;
import com.test.toy.board.repository.BoardDAO;

@WebServlet("/board/editcomment.do") // 가상주소 바로 생성
public class EditComment extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//1. 데이터 가져오기(content, seq)
		//2. DB 작업 > update
		//3. 결과 반환
		
		String content = req.getParameter("content");
		String seq = req.getParameter("seq");
		
		BoardDAO dao = new BoardDAO();
		
		CommentDTO dto = new CommentDTO();
		dto.setContent(content);
		dto.setSeq(seq);
		
		int result = dao.editComment(dto);
		
		JSONObject obj = new JSONObject();
		obj.put("result", result);
		
		PrintWriter writer = resp.getWriter();
		writer.write(obj.toString());
		writer.close();
	}
}

