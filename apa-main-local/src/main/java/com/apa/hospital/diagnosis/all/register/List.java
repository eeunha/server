package com.apa.hospital.diagnosis.all.register;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.apa.model.hospital.DiagnosisRgstDTO;
import com.apa.repository.hospital.DiagnosisDAO;

@WebServlet("/hospital/diagnosis/all/register/list.do")
public class List extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//1.
		HttpSession session = req.getSession();
		
		String hospitalId = session.getAttribute("id").toString();
		//System.out.println(hospitalId);
		
		//2.
		DiagnosisDAO dao = new DiagnosisDAO();
		ArrayList<DiagnosisRgstDTO> list = dao.getAllRegisterList(hospitalId);
		
		
		//3.
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/hospital/diagnosis/all/register/list.jsp");
		dispatcher.forward(req, resp);
	}

}