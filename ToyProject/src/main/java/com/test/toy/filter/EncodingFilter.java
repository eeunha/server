package com.test.toy.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class EncodingFilter implements Filter {
	private String encoding;

	// web.xml 수정

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
//		System.out.println("필터 생성");

		this.encoding = filterConfig.getInitParameter("encoding");
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
			throws IOException, ServletException {
//		System.out.println("필터 동작");

		//인코딩 처리
		req.setCharacterEncoding(this.encoding);
//		req.setCharacterEncoding("UTF-8");
		
		chain.doFilter(req, resp); // == forward()의 역할
	}

	@Override
	public void destroy() {
//		System.out.println("필터 소멸");

	}
}
