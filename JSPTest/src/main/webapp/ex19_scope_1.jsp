<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//첫번째 페이지(데이터 생성) > (전달) > 두번째 페이지(데이터 사용)
	
	//1. 지역 변수 > 실패 (따로 넘겨줘야 다른 페이지에서 사용 가능)
	int a = 10;
	
	//3. pageContext 객체 > 실패
	pageContext.setAttribute("c", 30);
	
	//4. requset 객체 > 실패(response로 페이지 이동 시)  성공(pageContext로 페이지 이동 시. 주고 받는 추가적 코드가 없어도 가능하다.)
	request.setAttribute("d", 40);
	
	//5. session 객체
	session.setAttribute("e", 50);
	
	//6. application 객체
	application.setAttribute("f", 60);
	
	
	// 페이지 이동(in Java) 1.
	//response.sendRedirect("ex19_scope_2.jsp");
	
	// 페이지 이동(in Java) 2.
	//pageContext.forward("ex19_scope_2.jsp");
	
	//request + forward (사용할 것)
	//5, 6 쓰면 안되는 이유
	//application: 다른 사람도 볼 수 있어서 수정 가능하다.
	//session: 내가 원하는 범위보다 길게 살아있다.
	
	
%>

<%!
	//2. 멤버 변수
	int b = 20;

	
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
	<!-- ex19_scope_1.jsp -->
	<h1>첫번째 페이지</h1>
	
	<!-- 페이지 이동 1. -->
	<a href="ex19_scope_2.jsp?a=<%=a%>">두번째 페이지</a>
	<hr>
	
	<!-- 페이지 이동 2. -->
	<input type="button" value="두번째 페이지" id="btn1">
	<hr>
	
	<!-- 페이지 이동 3. -->
	<form method="GET" action="ex19_scope_2.jsp">
		<input type="hidden" name="a" value="<%= a %>">
		<input type="submit" value="두번째 페이지">
	</form>
	
	<script src="https://code.jquery.com/jquery-1.12.4.js" ></script>
	<script src="http://pinnpublic.dothome.co.kr/cdn/example-min.js"></script>
	<script>
		$('#btn1').click(function() {
			location.href='ex19_scope_2.jsp?a=<%=a%>';
		});
	</script>
</body>
</html>