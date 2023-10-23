<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="inc/asset.jsp" %>
<style>
	
</style>
</head>
<body class="narrow">
	<!-- template.jsp > add.jsp -->
	<%@ include file="inc/header.jsp" %>
	
	<form method="post" action="addok.jsp"> <!-- 전송버튼과 값이 하나의 폼 안에 들어있어야 한다. -->
		<table class="vertical">
			<tr>
				<th>할일</th>
				<td><input type="text" class="long" name="todo" required>
			</tr>
		</table>
		<div>
			<button class="back" type="button" onclick="location.href='list.jsp'">뒤로가기</button> <!-- 타입 안주면 자동 submit임 -->
			<button class="add">등록하기</button>
		</div>
	</form>
	
	<script>
			
	</script>
</body>
</html>