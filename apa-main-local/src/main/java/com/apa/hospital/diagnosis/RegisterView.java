package com.apa.hospital.diagnosis;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.apa.model.hospital.DiagnosisRgstDTO;
import com.apa.repository.hospital.DiagnosisDAO;

@WebServlet("/hospital/diagnosis/register-view.do")
public class RegisterView extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String mediSeq = req.getParameter("mediSeq");
		
		DiagnosisDAO dao = new DiagnosisDAO();
		
		DiagnosisRgstDTO dto = dao.getRegisterDetail(mediSeq);
		
		req.setAttribute("dto", dto);
		req.setAttribute("mediSeq", mediSeq);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/hospital/diagnosis/register-view.jsp");
		dispatcher.forward(req, resp);
	}
}
