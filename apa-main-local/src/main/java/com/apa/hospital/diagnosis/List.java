package com.apa.hospital.diagnosis;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.apa.model.hospital.DiagnosisRgstDTO;
import com.apa.repository.hospital.DiagnosisDAO;

@WebServlet("/hospital/diagnosis/list.do")
public class List extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// 병원의 오늘의 예약 내역 가져오기

		// 1.
		String hospitalId = req.getSession().getAttribute("id").toString();
		//System.out.println(hospitalId);

		// 2.
		DiagnosisDAO dao = new DiagnosisDAO();
		
		ArrayList<DiagnosisRgstDTO> list = dao.getRegisterList(hospitalId);
		
		// 3.
		req.setAttribute("list", list);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/hospital/diagnosis/list.jsp");
		dispatcher.forward(req, resp);
	}
}
