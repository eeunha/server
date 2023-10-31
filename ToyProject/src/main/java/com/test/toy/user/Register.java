package com.test.toy.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.test.toy.user.model.UserDTO;
import com.test.toy.user.repository.UserDAO;

@WebServlet("/user/register.do") // 가상주소 바로 생성
public class Register extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// Register.java

		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/user/register.jsp");
		dispatcher.forward(req, resp);

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// RegisterOk.java 역할
		// 1. 데이터 가져오기
		// 2. DB 작업 > insert
		// 3. 피드백

		// req.getParameter() 동작 불가능 > MultipartRequest 대체

		try {

			MultipartRequest multi = new MultipartRequest(req, req.getRealPath("/asset/pic"), 1024 * 1024 * 10, "UTF-8",
					new DefaultFileRenamePolicy());

			// System.out.println(req.getRealPath("/asset/pic"));
			// C:\class\code\server\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\ToyProject\asset\pic

			String id = multi.getParameter("id");
			String pw = multi.getParameter("pw");
			String name = multi.getParameter("name");
			String email = multi.getParameter("email");
			String pic = multi.getFilesystemName("pic"); // 주의
			String intro = multi.getParameter("intro");

			UserDTO dto = new UserDTO();

			dto.setId(id);
			dto.setPw(pw);
			dto.setName(name);
			dto.setEmail(email);
			
			if (pic != null && !pic.equals("") ) {
				dto.setPic(pic);
			} else {
				dto.setPic("pic.png");
			}
			
			dto.setIntro(intro);

			UserDAO dao = new UserDAO();

			int result = dao.register(dto);

			if (result == 1) {
				resp.sendRedirect("/toy/index.do");
			}
		} catch (Exception e) {
			System.out.println("Register.doPost()");
			e.printStackTrace();
		}

		PrintWriter writer = resp.getWriter();
		writer.print("<script>alert('failed');history.back();</script>");
		writer.close();
	}
}
