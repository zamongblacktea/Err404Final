<script>$(document).ready(function() {
    var mapyElement = document.getElementById('mapy');
    var mapxElement = document.getElementById('mapx');

    var mapy = parseFloat(mapyElement.value); // 입력 필드의 값을 가져와 숫자로 변환
    var mapx = parseFloat(mapxElement.value);
    var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
    var options = { //지도를 생성할 때 필요한 기본 옵션
       center : new kakao.maps.LatLng(mapy, mapx), //지도의 중심좌표. mpay , mapx 순으로 집어넣기
       level : 3
    //지도의 레벨(확대, 축소 정도)
    };

    var map = new kakao.maps.Map(container, options);

    if ("${ not empty param.search }" == "true") {

       $("#search").val("${ param.search}");

    }

    if ("${ param.search eq 'all'}" == "true") {

       $("#search_text").val("");

    }

    if ("${ not empty param.rsv_in }" == "true") {

       $("#rsv_in").val("${ param.rsv_in}");

    }

    if ("${ not empty param.rsv_out }" == "true") {

       $("#rsv_out").val("${ param.rsv_out}");

    }
 });</script>