<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="http://pinnpublic.dothome.co.kr/cdn/example-min.css">
<style>
#list {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 10px;
}

#list .item {
	border: 1px solid #CCC;
	border-radius: 5px;
	padding: 5px 10px;
	display: flex;
	align-items: center;
}

#list .item img {
	height: 35px;
	margin: 7px;
}
</style>
</head>
<body class="wide">
	<!-- ex05.jsp -->

	<h1>
		Map <small>Marker</small>
	</h1>

	<div>
		<div id="map" style="width: 1168px; height: 400px;"></div>
	</div>

	<div id="result"></div>

	<hr>

	<h3>Place</h3>
	<div id="list">
		<c:forEach items="${list}" var="dto">
			<div class="item" id="item${dto.seq}">
				<img src="/toy/asset/marker/${dto.category}.png"> <span>${dto.name}</span>
			</div>
		</c:forEach>
	</div>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=791cfd7b7418b2b7b60ed25fffbcec27"></script>

	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="http://pinnpublic.dothome.co.kr/cdn/example-min.js"></script>
	<script>
		const container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스

		const options = { //지도를 생성할 때 필요한 기본 옵션
			center : new kakao.maps.LatLng(37.499285, 127.0332008), //지도의 중심좌표.
			level : 3
		//지도의 레벨(확대, 축소 정도)
		};

		const map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
		
		
		const plist = [];
		
		
		
		//마커 출력
		//- Uncaught SyntaxError: Identifier 'm' has already been declared -> 같은 이름 사용 안됨.
		
		const imageSize = new kakao.maps.Size(40, 40);
		const option = {};

		<c:forEach items="${list}" var="dto" varStatus="status">
		
			const imageUrl${status.count} = '/toy/asset/marker/${dto.category}.png';
			
			const markerImg${status.count} = new kakao.maps.MarkerImage(imageUrl${status.count}, imageSize, option);
			
			
			const m${status.count} = new kakao.maps.Marker({
				position: new kakao.maps.LatLng(${dto.lat}, ${dto.lng})
			});
			
			m${status.count}.setImage(markerImg${status.count});
			m${status.count}.seq = ${dto.seq};
			m${status.count}.setMap(map);
			
			
			//마커 + 클릭 이벤트
			kakao.maps.event.addListener(m${status.count}, 'click', function(evt) { //대상, 종류, 콜백함수
				//alert();
				//누구를 클릭했는지? > PK
				//alert(evt.target);
				//alert(evt.srcElement);
				//alert(evt.currentTarget);
				//alert(this.nodeName);
				//$(this).hide();
				//this.setMap(null);
				//alert(this.seq);
				
				//alert('${dto.seq}'); -> 되는데 하면 안되나?
				
				selPlace(this.seq);
				
				$('#map > div > div > div > div > img').css('opacity', '.3');
				$(event.target).css('opacity', '1');
			});
			
			//plist 배열 > 장소 정보 추가
			plist.push({
				seq: ${dto.seq},
				lat: ${dto.lat},
				lng: ${dto.lng}
			});
		
		</c:forEach>
		
		function selPlace(seq) {
			$('#list .item').css('background-color', 'transparent');
			$('#list #item' + seq).css('background-color', 'gold');
			
		}
		
		//초기화
		
		function clear() {
			$('#map > div > div > div > div > img').css('opacity', '1');
			$('#list .item').css('background-color', 'transparent');
		}
		
		window.onkeydown = function () {
			if (event.keyCode == 27) {
				//esc
				clear();
			}
		};
		
		kakao.maps.event.addListener(map, 'click', function(evt) {
			clear();
		});
		
		
		//보이는 장소만 아래 목록 생성하기
		kakao.maps.event.addListener(map, 'dragend', function(evt) { 

			//alert();
//			$('#result').text(map.getBounds());
//			$('#result').text(map.getBounds().getSouthWest()); //남서쪽
//			$('#result').text(map.getBounds().getNorthEast()); //북동쪽

			$('#result').text('');

			$(plist).each((index, item) => {
				if (contains(item.lat, item.lng)) {
					//$('#result').append('포함, ');
					$('#list #item' + item.seq).show();
				} else {
					//$('#result').append('미포함, ');
					$('#list #item' + item.seq).hide();
				}
			});

		});

		
		//지도 > 줌인, 줌아웃
		kakao.maps.event.addListener(map, 'zoom_changed', function(evt) { 

			$('#result').text('');

			$(plist).each((index, item) => {
				if (contains(item.lat, item.lng)) {
					$('#list #item' + item.seq).show();
				} else {
					$('#list #item' + item.seq).hide();
				}
				
			});

		});
		
		function contains(lat, lng) {
			
			const sw = map.getBounds().getSouthWest();
			const ne = map.getBounds().getNorthEast();
			
			if (lat >= sw.getLat() && lat <= ne.getLat() && lng >= sw.getLng() && lng <= ne.getLng()) {
				return true;
			} else {
				return false;
			}
			
		}
		
		
	</script>
</body>
</html>