<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/inc/asset.jsp" %>
<style>
	
</style>
</head>
<body>
	<!-- template.jsp > addok.jsp -->
	
	<%@ include file="/WEB-INF/views/inc/header.jsp" %>
	
	<script>
		<%-- <%if ((int)request.getAttribute("result") == 1) {%>
		loaction.href = '/memo/list.do';
		<% } else { %>
		alert('실패');
		location.href = '/memo/add.do';
		<% } %> --%>
		
		<c:if test="${result == 1}">
			location.href = '/memo/list.do';
		</c:if>

		<c:if test="${result != 1}">
			alert('실패');
			//location.href = '/memo/add.do'; > 페이지 새로 요청
			history.back(); //페이지 새로 요청(X) > 이전 상태로 되돌리기
		</c:if>
		
	</script>
</body>
</html>