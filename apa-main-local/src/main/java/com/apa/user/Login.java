package com.apa.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.apa.model.HospitalDTO;
import com.apa.repository.HospitalDAO;

@WebServlet("/user/login.do")
public class Login extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/user/login.jsp");
		dispatcher.forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String id = req.getParameter("id");
		String pw = req.getParameter("pw");
		
		HospitalDAO dao = new HospitalDAO();

		HospitalDTO dto = new HospitalDTO();
		dto.setHospitalId(id);
		dto.setHospitalPw(pw);

		HospitalDTO result = dao.login(dto);

		if (result != null) {
			// 로그인 성공

			req.getSession().setAttribute("id", id); // 인증 티켓
			req.getSession().setAttribute("name", result.getHospitalName());
			req.getSession().setAttribute("lv", "병원");

			resp.sendRedirect("/apa/main.do");

		} else {
			// 로그인 실패
			PrintWriter writer = resp.getWriter();
			writer.print("<script>alert('failed');history.back();</script>");
			writer.close();
		}

	}
}
