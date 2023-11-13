package com.apa.hospital.diagnosis.all.register;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.apa.model.hospital.DiagnosisRgstDTO;
import com.apa.repository.hospital.DiagnosisDAO;

@WebServlet("/apa/hospital/diagnosis/all/register/get-data.do") // 가상주소 바로 생성
public class GetData extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// 1.
		HttpSession session = req.getSession();

		String hospitalId = session.getAttribute("id").toString();
		// System.out.println(hospitalId);

		// 2.
		DiagnosisDAO dao = new DiagnosisDAO();
		ArrayList<DiagnosisRgstDTO> list = dao.getAllRegisterList(hospitalId);

		// 긴 상세증상 줄이기
		for (DiagnosisRgstDTO dto : list) {
			String symptom = dto.getSymptom();
			if (symptom != null && symptom.length() > 25) {
				symptom = symptom.substring(0, 25) + "..";
			}
			dto.setSymptom(symptom);
		}

		JSONArray arr = new JSONArray();

		for (DiagnosisRgstDTO dto : list) {

			// DiagnosisRgstDTO 1개 > JSONObject1개
			JSONObject obj = new JSONObject();

			obj.put("mediSeq", dto.getMediSeq());
			obj.put("userSeq", dto.getUserSeq());
			obj.put("userName", dto.getUserName());
			obj.put("treatmentDate", dto.getTreatmentDate());
			obj.put("doctorName", dto.getDoctorName());
			obj.put("symptom", dto.getSymptom());
			obj.put("regdate", dto.getRegdate());

			arr.add(obj);
		}

		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");

		PrintWriter writer = resp.getWriter();
		writer.write(arr.toString());
		writer.close();

	}
}
