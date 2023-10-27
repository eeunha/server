package com.test.ajax.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.test.ajax.model.AddressDTO;
import com.test.ajax.repository.AjaxDAO;

@WebServlet("/list.do") // 가상주소 바로 생성
public class List extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// List.java
		// 1. DB 작업 > select
		// 2. 반환 > json 변환 > ajax에게 반환

		// 1.
		AjaxDAO dao = new AjaxDAO();

		ArrayList<AddressDTO> list = dao.listAddress();

		// 2.
		// list > json 변환

		/*
		 * [ { "seq": "10", "name": "홍길동", "age": "20" }, { "seq": "10", "name": "홍길동",
		 * "age": "20" } ]
		 */

		// HashMap 성질
//		JSONObject obj = new JSONObject();
//		
//		obj.put("name", "홍길동");
//		obj.put("age", "20");
//		
//		//{"address":"홍길동","gender":"20"}
//		System.out.println(obj.toString());
//
//		JSONObject obj2 = new JSONObject();
//		obj2.put("name", "아무개");
//		obj2.put("age", "22");
//		
//		JSONArray arr = new JSONArray();
//		arr.add(obj);
//		arr.add(obj2);
//		
//		System.out.println(arr.toString());

		// ArrayList<AddressDTO> list > JSONArray
		// AddressDTO > JSONObject

		JSONArray arr = new JSONArray();

		for (AddressDTO dto : list) {

			// AddressDTO 1개 > JSONObject 1개
			JSONObject item = new JSONObject();

			item.put("seq", dto.getSeq());
			item.put("name", dto.getName());
			item.put("age", dto.getAge());
			item.put("gender", dto.getGender());
			item.put("address", dto.getAddress());
			item.put("regdate", dto.getRegdate());

			arr.add(item);
		}

//		System.out.println(arr.toString());

		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");

		PrintWriter writer = resp.getWriter();

		writer.print(arr.toString());

		writer.close();
	}
}
