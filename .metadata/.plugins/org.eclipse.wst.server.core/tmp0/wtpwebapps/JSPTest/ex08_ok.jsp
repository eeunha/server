<%@page import="java.util.Arrays"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//POST > 한글 인코딩
	request.setCharacterEncoding("UTF-8");
	
	//텍스트 박스
	//1. 입력O > 입력값 반환
	//2. 컨트롤O + 입력X > 빈 문자열 반환
	//3. 컨트롤X (key 오류) > null 반환
	String txt1 = request.getParameter("txt1"); 
	
	//System.out.println(txt1 == null); // false
	//System.out.println(txt1.equals("")); // true
	
	
	//암호 박스
	String txt2 = request.getParameter("txt2"); // 한글 입력 안됨. 영어가 넘어감. 한글 복붙하면 한글로 넘어가긴함. -> 한글 안된다고 생각해
	
	
	//다중 텍스트
	String txt3 = request.getParameter("txt3"); // 코드에서는 엔터가 맞지만 화면상에서는 엔터 처리 못해서 space로 바뀌어 출력됨. -> 수정해주기
	// 조작은 위(여기)에서 한다.
	
	txt3 = txt3.replace("\r\n", "<br>");
	
	
	//체크 박스
	//1. value 없을 때
	//	 체크O > "on" 전송
	//   체크X > null 전송
	//2. value 있을 때
	//	 체크O > value 전송
	//   체크X > null 전송
	String cb1 = request.getParameter("cb1");
	

	//체크 박스들
/* 	
	String cb2 = request.getParameter("cb2");
	String cb3 = request.getParameter("cb3");
	String cb4 = request.getParameter("cb4");
	
	String temp = "";
	temp += cb2 + ", " + cb3 + ", " + cb4;
 */	
	/* 
	String temp = "";
	for (int i = 2; i <= 4; i++) {
		temp += request.getParameter("cb" + i) + ", ";
	} 
	*/

	// name 1개일 때
	//String cb5 = request.getParameter("cb5"); // 맨 처음 체크된 값 하나만 나온다.
	
	//동일한 name의 컨트롤이 여러개 전송될 때
	String[] cb5 = request.getParameterValues("cb5");
	
	
	//라디오 버튼 -> 단일 값, 미리 checked 해두어서 유효성검사를 하지 않는다.
	String rb = request.getParameter("rb");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="http://pinnpublic.dothome.co.kr/cdn/example-min.css">

<style>
</style>
</head>
<body>
	<!-- ex08_ok.jsp -->
	<h1>결과</h1>

	<h2>텍스트 박스</h2>
	<div><%= txt1 %></div>
	
	<h2>암호 박스</h2>
	<div><%= txt2 %></div>
	
	<h2>다중 텍스트</h2>
	<div><%= txt3 %></div>
	
	<h2>체크 박스</h2>
	<div><%= cb1 %></div>
	
	<%-- <h2>체크 박스들</h2>
	<div><%= temp %></div>
	 --%>
	 
	<h2>체크 박스들</h2>
	<div><%= Arrays.toString(cb5) %></div>
	
	<h2>라디오 버튼</h2>
	<div><%= rb %></div>

	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="http://pinnpublic.dothome.co.kr/cdn/example-min.js"></script>
	<script>
		
	</script>
</body>
</html>