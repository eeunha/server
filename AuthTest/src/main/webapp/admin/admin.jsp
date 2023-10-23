<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//인증받지 못한 사용자가 직접 접근하면 내쫓기
	if (session.getAttribute("auth") == null || session.getAttribute("lv").toString().equals("1")) {
		
		out.println("<html>");
		out.println("<head>");
		out.println("<meta charset='UTF-8'>");
		out.println("</head>");
		out.println("<body>");
		out.println("<script>");
		out.println("alert('관리자만 접근 가능합니다.');");
		out.println("location.href='../index.jsp';");
		out.println("</script>");
		out.println("</body>");
		out.println("</html>");
		out.close(); 
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="http://pinnpublic.dothome.co.kr/cdn/example-min.css">

<style>
	
</style>
</head>
<body>
	<!--  -->
	<h1>관리자 페이지</h1>
	
	<p>이 페이지는 관리자만 접근이 가능합니다.</p>
	
	<script src="https://code.jquery.com/jquery-1.12.4.js" ></script>
	<script src="http://pinnpublic.dothome.co.kr/cdn/example-min.js"></script>
	<script>
			
	</script>
</body>
</html>