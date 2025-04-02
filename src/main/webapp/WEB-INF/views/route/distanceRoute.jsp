<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
  </head>
  <body>
    배달 직선 거리(라이더와 가게?/라이더와 주문자?)와 카카오 맵으로 경로 상세보기를 할 수 있는 페이지.

    <script>
      // Kakao 맵 길찾기 URL 생성
      //var kakaoMapUrl = `https://map.kakao.com/?sName=${shopAddress}&eName=${customerAddress}`;
      //var kakaoMapUrl = `https://map.kakao.com/?sName=서울대입구역&eName=신림역`;
      var kakaoMapUrl = `https://map.kakao.com/?sName=${shop_addr}&eName=${mem_curaddr}`;
    </script>
  </body>
</html>
