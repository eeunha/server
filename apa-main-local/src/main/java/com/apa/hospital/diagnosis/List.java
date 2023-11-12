package com.apa.hospital.diagnosis;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.apa.model.hospital.DiagnosisHistoryDTO;
import com.apa.model.hospital.DiagnosisRgstDTO;
import com.apa.repository.hospital.DiagnosisDAO;

@WebServlet("/hospital/diagnosis/list.do")
public class List extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// 인증 티켓
		req.getSession().setAttribute("id", "yonse");
		req.getSession().setAttribute("name", "연세위드의원");
		req.getSession().setAttribute("lv", "병원");
		
		
		// 병원의 오늘의 진료(예약, 순서) 내역 가져오기

		// 진료내역 페이징
		HashMap<String, String> map = new HashMap<>();

		int nowPage = 0; // 현재 페이지 번호
		int totalCount = 0; // 총 게시물 수
		int pageSize = 10; // 한 페이지에서 출력할 게시물 수
		int totalPage = 0; // 총 페이지 수
		int begin = 0; // 페이징 시작 위치
		int end = 0; // 페이징 끝 위치
		int n = 0;
		int loop = 0;
		int blockSize = 10; // 한번에 보여줄 페이지 개수

		String page = req.getParameter("page");

		if (page == null || page.equals("")) {
			nowPage = 1;
		} else {
			nowPage = Integer.parseInt(page);
		}
		//System.out.println(nowPage);

		begin = ((nowPage - 1) * pageSize) + 1;
		end = begin + pageSize - 1;

		map.put("begin", begin + "");
		map.put("end", end + "");

		// 1.
		String hospitalId = req.getSession().getAttribute("id").toString();
		// System.out.println(hospitalId);

		map.put("hospitalId", hospitalId);
		
		// 2.
		DiagnosisDAO dao = new DiagnosisDAO();

		// 오늘자 예약 내역 가져오기
		ArrayList<DiagnosisRgstDTO> registerList = dao.getRegisterList(hospitalId);

		//긴 상세증상 줄이기
		for (DiagnosisRgstDTO dto : registerList) {
			String symptom = dto.getSymptom();
			if (symptom != null && symptom.length() > 25) {
				symptom = symptom.substring(0, 25) + "..";
			}
			dto.setSymptom(symptom);
		}

		// 오늘자 진료(순서) 내역 가져오기
		ArrayList<DiagnosisHistoryDTO> mediList = dao.getHistoryList(map);
		
		//System.out.println("mediList.size(): " + mediList.size());

		//긴 상세증상 줄이기
		for (DiagnosisHistoryDTO dto : mediList) {
			String symptom = dto.getSymptom();
			if (symptom != null && symptom.length() > 25) {
				symptom = symptom.substring(0, 25) + "...";
			}
			dto.setSymptom(symptom);
		}

		// 총 게시물 수
		totalCount = mediList.size();
//		System.out.println(totalCount);

		totalPage = (int) Math.ceil((double) totalCount / pageSize);

		// 페이지바
		StringBuilder sb = new StringBuilder();

		loop = 1; // 루프 변수(10바퀴)
		n = ((nowPage - 1) / blockSize) * blockSize + 1; // 출력 페이지 번호

		// 이전 10페이지
		if (n == 1) {
			sb.append(String.format(" <a href='#!';>[이전 %d페이지]</a> ", blockSize));
		} else {
			sb.append(String.format(" <a href='/apa/hospital/diagnosis/list.do?page=%d';>[이전 %d페이지]</a> ", n - 1,
					blockSize));
		}

		while (!(loop > blockSize || n > totalPage)) {

			if (n == nowPage) {
				sb.append(String.format(" <a href='#!' style='color:tomato;'>%d</a> ", n));
			} else {
				sb.append(String.format(" <a href='/apa/hospital/diagnosis/list.do?page=%d'>%d</a> ", n, n));
			}

			loop++;
			n++;
		}

		// 다음 10페이지
		if (n > totalPage) {
			sb.append(String.format(" <a href='#!';>[다음 %d페이지]</a> ", blockSize));
		} else {
			sb.append(
					String.format(" <a href='/apa/hospital/diagnosis/list.do?page=%d';>[다음 %d페이지]</a> ", n, blockSize));
		}

		// 3.
		req.setAttribute("registerList", registerList);
		req.setAttribute("mediList", mediList);

		req.setAttribute("map", map);

		req.setAttribute("totalCount", totalCount);
		req.setAttribute("totalPage", totalPage);
		req.setAttribute("nowPage", nowPage);

		req.setAttribute("pagebar", sb.toString());

		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/hospital/diagnosis/list.jsp");
		dispatcher.forward(req, resp);
	}
}
