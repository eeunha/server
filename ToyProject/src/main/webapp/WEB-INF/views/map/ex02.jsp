<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	<!-- ex02.jsp -->

	<h1>
		Map <small>지도 좌표 이동하기 + 레벨 바꾸기</small>
	</h1>

	<div>
		<div id="map" style="width: 768px; height: 400px;"></div>
	</div>

	<hr>


	<div>
		<input type="button" value="종각역으로 이동하기" id="btn1"> <input
			type="button" value="역삼역으로 이동하기" id="btn2"> <input
			type="button" value="잠실역으로 이동하기" id="btn3">
	</div>
	<div>
		<input type="button" value="확대" id="btn4"> <input
			type="button" value="축소" id="btn5">
	</div>
	<div>
		<input type="button" value="이동 제어" id="btn6"> <input
			type="button" value="확대/축소 제어" id="btn7">
	</div>


	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=791cfd7b7418b2b7b60ed25fffbcec27"></script>

	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="http://pinnpublic.dothome.co.kr/cdn/example-min.js"></script>
	<script>
		const container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스

		const options = { //지도를 생성할 때 필요한 기본 옵션
			center : new kakao.maps.LatLng(37.499285, 127.0332008), //지도의 중심좌표.

			//한독 > 37.499285, 127.0332008
			//종각 > 37.570176, 126.983197
			//역삼 > 37.500163, 127.0348455
			//잠실 > 37.5132612, 127.1001336

			level : 3
		//지도의 레벨(확대, 축소 정도)
		};

		const map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

		$('#btn1').click(function() {

			//좌표 객체
			const p1 = new kakao.maps.LatLng(37.570176, 126.983197);
			map.setCenter(p1);
		});

		$('#btn2').click(function() {
			const p1 = new kakao.maps.LatLng(37.500163, 127.0348455);
			//map.setCenter(p1);	//순간이동
			map.panTo(p1); //스크롤이동 - 시야에 벗어나면 순간이동
		});

		$('#btn3').click(function() {
			const p1 = new kakao.maps.LatLng(37.5132612, 127.1001336);
			map.setCenter(p1);
		});

		$('#btn4').click(function() {
			map.setLevel(map.getLevel() - 1);
		});

		$('#btn5').click(function() {
			map.setLevel(map.getLevel() + 1);
		});

		map.setDraggable(false);
		$('#btn6').click(function() {
			//토글 버튼(드래그 On/Off)

			if (map.getDraggable()) {
				map.setDraggable(false);
				$(this).css('background-color', '#EFEFEF');
			} else {
				map.setDraggable(true);
				$(this).css('background-color', 'gold');
			}

		});

		map.setZoomable(false);
		$('#btn7').click(function() {
			//토글 버튼(확대,축소 on/off)

			if (map.getZoomable()) {
				map.setZoomable(false);
				$(this).css('background-color', '#EFEFEF');
			} else {
				map.setZoomable(true);
				$(this).css('background-color', 'gold');
			}
		});
	</script>
</body>
</html>