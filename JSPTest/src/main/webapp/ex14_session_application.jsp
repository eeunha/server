<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 세션 변수 라고도 부르나 사실은 map이다. > 사이트 전역 변수(페이지간에 주고 받을 필요가 없다.)
	session.setAttribute("a", 10); //세션 객체에 a 변수 저장
	
	// 어플리케이션 변수 > 사이트 전역 변수(페이지간에 주고 받을 필요가 없다.)
	application.setAttribute("b", 20); //어플리케이션 객체 b에 변수 저장 
	
	// 지역변수는 안된다. 페이지가 끝나면 같이 죽기 때문이다.
	// int i = 1;
	// n += 1;
	
	// 세션은 없어지지 않는다.
	if (session.getAttribute("count") == null) {
		session.setAttribute("count", 1);
	} else {
		//count = count + 1
		session.setAttribute("count", (int)session.getAttribute("count") + 1);
	}
	
	if (application.getAttribute("count") == null) {
		application.setAttribute("count", 1);
	} else {
		//count = count + 1
		application.setAttribute("count", (int)application.getAttribute("count") + 1);
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
	<!-- ex14_session_application.jsp -->
	
	<h1>session</h1>
	<div>a: <%= session.getAttribute("a") %></div>
	
	<h1>application</h1>
	<div>b: <%= application.getAttribute("b") %></div>
	
	<h1>방문 카운트</h1>
	<div>count: <%= session.getAttribute("count") %></div>
	
	<h1>방문 카운트</h1>
	<div>count: <%= application.getAttribute("count") %></div>
	
	<script src="https://code.jquery.com/jquery-1.12.4.js" ></script>
	<script src="http://pinnpublic.dothome.co.kr/cdn/example-min.js"></script>
	<script>
			
	</script>
</body>
</html>