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
	<!-- ex07.jsp -->
	<h1>고양이 + Ajax</h1>
	
	<img src="/ajax/images/catty01.png" id="cat1" class="cat">
	<!-- <img src="/ajax/images/catty02.png" id="cat2" class="cat">
	<img src="/ajax/images/catty03.png" id="cat3" class="cat">
	<img src="/ajax/images/catty04.png" id="cat4" class="cat">
	<img src="/ajax/images/catty05.png" id="cat5" class="cat"> -->
	
	<script src="https://code.jquery.com/jquery-1.12.4.js" ></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script src="http://pinnpublic.dothome.co.kr/cdn/example-min.js"></script>
	<script>
	
		//직접 구현 vs 참조
		//-> 참조써라.
		
		//$('#cat1').draggable({
		$('.cat').draggable({
			//axis: 'y'
			//grid: [128, 128]
		});
		
	</script>
</body>
</html>