<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<!-- ex21_jstl.jsp -->
	<h1>JSTL</h1>
	
	<h2>변수 선언</h2>
	<%
		int a = 10; // 지역 변수
		pageContext.setAttribute("b", 20); //내장 객체 변수
	%>
	<c:set var="c" value="30" /> <!-- JSTL 변수 == pageContext 변수 -->
	
	<div>a: <%= a %></div>
	<div>a: ${a}</div> <!-- 불가 -->
	
	<div>b: <%= pageContext.getAttribute("b") %></div>
	<div>b: ${b}</div> 
	
	<%-- <div>c: <%= c %></div> --%> <!-- 불가. 지역변수 아님 -->
	<div>c: ${c}</div> <!-- 내장 객체 변수 -->
	<div>c: ${pageContext.getAttribute("c")}</div> <!-- 내장 객체 변수 -->
	
	<h2>변수 수정하기(값 바꾸기)</h2>
	<c:set var="c" value="300"/>
	<div>c: ${c}</div>
	
	<h2>변수 삭제하기(Map의 요소 삭제)</h2>
	<c:remove var="c"/>
	<div>c: ${c}</div>	
	<div>c: ${empty c}</div>	
	
	<h2>조건문</h2>
	<c:set var="num" value="10" />
	<div>num: ${num}</div>
	
	<c:if test="${num > 0}">
		<div>${num}은 양수입니다.</div>
	</c:if>
	
	<c:if test="${num <= 0}">
		<div>${num}은 양수가 아닙니다.</div>
	</c:if>
	
	<!-- 다중 조건문 -->
	<c:choose>
		<c:when test="${num > 0}">양수</c:when>
		<c:when test="${num < 0}">음수</c:when>
		<c:otherwise>0</c:otherwise>
	</c:choose>
	
	
	<h2>반복문(일반 for + 향상된 for)</h2>
	
	
	<script src="https://code.jquery.com/jquery-1.12.4.js" ></script>
	<script src="http://pinnpublic.dothome.co.kr/cdn/example-min.js"></script>
	<script>
			
	</script>
</body>
</html>