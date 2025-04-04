<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    라이더 테스트 페이지
    
    주소를 위도경도로 얻어와서 
    위도경도를 주소로 얻어와서 그걸 sname ename에 넣기

    라이더의 gps를 위도경도로 얻어오기?
    멤버 배달주소 테이블
    라이더 현재주소 테이블
    위도경도를 받아서 주소를 얻는 api

    라이더위치를 구하고 x,y 주소를 구해서 배달지의 주소까지의 경로
    주소로 경로
    라이더위치에서 음식점위치 음식점위치에서 배달지 위치 두개의 합산거리 띄워주기
    전체 총 길이 실질적 이동거리 ->총길이 기준으로 orderby
    라이더 기준으로 가까운 곳으로 알려주기

    gps가 아니니까 geolocation https로 해야함 여기서는 못함 야매로하던 도메인을 사서 하던
    라이더위치를 학원으로 고정 (모바일은 gps로 얻어왔다는 가정)
    시연용 좌표 가게 1 가게 2 라이더가 여기잇을때 저기잇을때 경로보여주기

    3(라이더-가게-배달지) 총길이 구해서 거리& 배달료 구하기

    gps좌표만 알고있으면 된다.
    구하는 method가있음
    위도경도

    라이더 위치는 안다
    좌표 3개 
    라이더-가게-배달지 (gps) 총길이 합산 ->배차시 & 정산시  ->짧은거리로 orderby(뷰)
    정보안에 3개의 좌표만 알면됨
    주소로 db상 위도경도 구해놔야함
    
    주소를 위도경도 바꿔주는 함수가잇음

</body>
</html>