<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- 468780eb2df5022cd5c83fcacdc8b927 -->
    <script  type="text/javascript"  src="//dapi.kakao.com/v2/maps/sdk.js?appkey=766f5618bd04fce929594d8edb57b33b">
    </script>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title> 배달 직선 거리(라이더와 가게/라이더와 주문자)와 카카오 맵으로 경로 상세보기를 할 수 있는 페이지</title>
    <style>
      #text{
        text-align: center;
      }

      #kakaomap{
        text-align: center;
        background-color: #e89b82;
        margin: auto;
        display: inline-block;
      }
    </style>
    <script>

      $(document).ready(function(){
        setTimeout(init,100);
      });
      //가게의 위도경도를 전역변수로 설정 
      const shop1 = {lat: '${shop_latitude}', lng: '${shop_longitude}'};

      function init(){
        
          //var shop1 = {lat: '${shop_latitude}', lng: '${shop_longitude}'};
          var member1 = {lat: '${mem_latitude}', lng: '${mem_longitude}'};
          var rider1 = {lat: '${rider_latitude}', lng: '${rider_longitude}'};
            
          // var shop    = parseFloat(shop1.value);
          // var member  = parseFloat(member1.value);
          // var rider   = parseFloat(rider1.value);
          
   

          var mapContainer = document.getElementById('map');
          var mapOption = {
              center: new kakao.maps.LatLng(parseFloat(shop1.lat), parseFloat(shop1.lng)),
              level: 4
             };
      
 
          // var map = new kakao.maps.Map(mapContainer, mapOption);
          var map = new kakao.maps.Map(mapContainer, mapOption);
    
      
          // 마커 찍기 함수
          function addMarker(position, title) {
              new kakao.maps.Marker({
                  position: new kakao.maps.LatLng(position.lat, position.lng),
                  //position: new kakao.maps.LatLng(33.450701, 126.570667), 
                  map: map,
                  title: title
              });
          }
      
          addMarker(shop1, '가게');
          addMarker(member1, '고객');
          addMarker(rider1, '라이더');

      
          // 선 그리기
          var linePath = [
              new kakao.maps.LatLng(shop1.lat, shop1.lng),
              new kakao.maps.LatLng(rider1.lat, rider1.lng),
              new kakao.maps.LatLng(member1.lat, member1.lng)
          ];
      
          var polyline = new kakao.maps.Polyline({
              path: linePath,
              strokeWeight: 5,
              strokeColor: '#0000FF',
              strokeOpacity: 0.8,
              strokeStyle: 'solid'
          });
      
          polyline.setMap(map);

      }
      //카카오 경로 상세보기   
      var kakaoMapUrl = `https://map.kakao.com/?sName=${shop_addr}&eName=${mem_curaddr}`;

  </script>

  </head>
  <body>
    <div id="map" style="width:100%;height:500px;"></div><br>
    <div id ="text">
      총거리 : <fmt:formatNumber value="${rescal}" pattern="#,#00.00#"/>m<br>
      배달수수료 :<fmt:formatNumber value="${fee}" pattern="#,#00.00#"/>원<br>
      <!-- 1km 미만은 3000원(최솟값) 가게에서 측정한 배달값으로 하고 (마지막에 가게칼럼명 갖고오기) -->
    </div>
    <!-- 카카오 경로 상세 보기  -->
    <p style="text-align: center;">가게와 배달지 경로 확인</p>
    <div style="margin: auto; width: 100px; height: 24px;">
    <input id="kakaomap"  type="button" value="카카오맵경로보기" onclick="location.href=kakaoMapUrl"> 
    </div>   
  </div>

  </div>

  <!-- 카카오 경로 상세 보기 잠시 주석처리 
    <script>
      // Kakao 맵 길찾기 URL 생성
      //var kakaoMapUrl = `https://map.kakao.com/?sName=${shopAddress}&eName=${customerAddress}`;
      //var kakaoMapUrl = `https://map.kakao.com/?sName=서울대입구역&eName=신림역`;
      //var kakaoMapUrl = `https://map.kakao.com/?sName=${shop_addr}&eName=${mem_curaddr}`;
    </script> -->
  </body>
</html>
