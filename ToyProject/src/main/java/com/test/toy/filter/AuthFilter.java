package com.test.toy.filter;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AuthFilter implements Filter {

	@Override
	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
			throws IOException, ServletException {

		// 권한 체크
//		System.out.println("권한 체크 필터");

		// 인증 받지 못한 사용자 내쫓기
		HttpServletRequest httpReq = (HttpServletRequest) req;
		HttpServletResponse httpResp = (HttpServletResponse) resp;

		HttpSession session = httpReq.getSession();

//		if (session.getAttribute("id") == null) {
//			System.out.println("비회원");
//		} else {
//			System.out.println("회원: "+ session.getAttribute("id"));
//		}
//		System.out.println();

		// 익명 사용자 > 배제
//		System.out.println(httpReq.getRequestURI()); // 현재 페이지 주소

		if (session.getAttribute("id") == null) {
			if (httpReq.getRequestURI().endsWith("add.do") || httpReq.getRequestURI().endsWith("edit.do")
					|| httpReq.getRequestURI().endsWith("del.do") || httpReq.getRequestURI().endsWith("info.do")) {

				// httpResp.sendRedirect("/toy/index.do"); // 안내메시지 주자.

				PrintWriter writer = httpResp.getWriter();
				writer.print("<script>alert('unauthorized');location.href='/toy/index.do';</script>");
				writer.close();

				return; // 아래 페이지 이동 구문이 겹쳐서 오류 발생.
			}
		}

		chain.doFilter(req, resp);
	}

}
