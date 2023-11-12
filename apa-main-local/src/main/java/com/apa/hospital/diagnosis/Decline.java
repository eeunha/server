package com.apa.hospital.diagnosis;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.apa.repository.hospital.DiagnosisDAO;

@WebServlet("/hospital/diagnosis/decline.do")
public class Decline extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String mediSeq = req.getParameter("mediSeq");
		
		DiagnosisDAO dao = new DiagnosisDAO();
		
		int result = dao.declineRegister(mediSeq);
		
		resp.setContentType("application/json");

		JSONObject obj = new JSONObject();
		obj.put("result", result);
		
		PrintWriter writer = resp.getWriter();
		writer.write(obj.toString());
		writer.close();
	}
}
