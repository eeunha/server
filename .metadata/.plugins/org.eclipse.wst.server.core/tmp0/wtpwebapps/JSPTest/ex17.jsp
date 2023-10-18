<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<!-- ex17.jsp -->
	<h1>다중 파일 업로드</h1>
	
	<form method="POST" action="ex17_ok.jsp" enctype="multipart/form-data">
		<table class="vertical">
			<tr>
				<th>파일1</th>
				<td><input type="file" name="attach1"></td>
			</tr>
			<tr>
				<th>파일2</th>
				<td><input type="file" name="attach2"></td>
			</tr>
			<tr>
				<th>파일3</th>
				<td><input type="file" name="attach3"></td>
			</tr>
		</table>
		<div>
			<input type="submit" value="업로드">
		</div>
	</form>
	
	<script src="https://code.jquery.com/jquery-1.12.4.js" ></script>
	<script src="http://pinnpublic.dothome.co.kr/cdn/example-min.js"></script>
	<script>
			
	</script>
</body>
</html>