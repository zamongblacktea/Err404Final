<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>사장 정보</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <!-- 웹소캣 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

    <style>
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }

      body {
        background-color: #f6f8fc;
      }

      /* 상단 nav */
      #nav {
        background: #ff694a;
        height: 60px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 0 20px;
      }

      #nav img {
        height: 45px;
      }

      .container-flex {
        /* height: 95vh; */
        display: flex;
        flex-direction: row;
      }

      /* 사이드바 */
      #sidebar {
        width: 220px;
        background-color: white;
        border-right: 1px solid #ddd;
        padding: 20px;
        font-size: 18px;
        height: 100%;
      }

      #sidebar .menu-group {
        margin-bottom: 20px;
      }

      #sidebar .menu-title {
        font-weight: bold;
        margin-bottom: 5px;
      }

      #sidebar a {
        display: block;
        text-decoration: none;
        color: #333;
        padding: 8px 12px;
        border-radius: 8px;
        transition: background-color 0.2s;
      }

      #sidebar a:hover {
        background-color: #ffbeb1;
        color: white;
      }

      /* 본문 영역 */
      .contents {
        /* border: 1px solid red; */
        width: 1320px;
        margin: 30px auto;
        padding-left: 50px;

      }
    </style>
<!-- 챗봇 AI -->
<script>
  (function(){var w=window;if(w.ChannelIO){return w.console.error("ChannelIO script included twice.");}var ch=function(){ch.c(arguments);};ch.q=[];ch.c=function(args){ch.q.push(args);};w.ChannelIO=ch;function l(){if(w.ChannelIOInitialized){return;}w.ChannelIOInitialized=true;var s=document.createElement("script");s.type="text/javascript";s.async=true;s.src="https://cdn.channel.io/plugin/ch-plugin-web.js";var x=document.getElementsByTagName("script")[0];if(x.parentNode){x.parentNode.insertBefore(s,x);}}if(document.readyState==="complete"){l();}else{w.addEventListener("DOMContentLoaded",l);w.addEventListener("load",l);}})();

  ChannelIO('boot', {
    "pluginKey": "6f7a9234-fd72-433f-b10a-7aeef84a830c",
    "memberId": "${ owner.owner_id }", // fill user's member id
    "profile": { // fill user's profile
      "name": "${owner.owner_name}", // fill user's name
      "landlineNumber": "USER_LANDLINE_NUMBER", // fill user's landline number  
      "CUSTOM_VALUE_1": "VALUE_1", // custom property
      "CUSTOM_VALUE_2": "VALUE_2" // custom property
    }
  });
</script>

    <script>
      function loadContent(url) {
        const shop_idx = "${sessionScope.shop_idx}"; // 세션에서 shop_idx 꺼냄
        const owner_idx = "${user.owner_idx}"; //세션에서 owner_idx 가져오기
        $.ajax({
          url: url,
          data: { shop_idx: shop_idx,
                  owner_idx: owner_idx,
           },
          success: function(res_data) {
            $("#disp").html(res_data);
          },
          error: function(err) {
            alert("에러 발생: " + err.responseText);
          }
        });
      }

      // 페이지 로드 시 기본으로 메뉴 목록 표시
      $(document).ready(function() {
        loadContent("../order/order_list.do");
      });

      
    //웹소캣구독
    var currentShopIdx = '<%= session.getAttribute("shop_idx") %>';
    var socket = new SockJS('${pageContext.request.contextPath}/ws-orders');
    var stompClient = Stomp.over(socket);

    // WebSocket 연결 설정
    stompClient.connect({}, function (frame) {
    console.log('Connected: ' + frame);

  // 주문 상태 업데이트 메시지 구독
    stompClient.subscribe('/topic/orders', function (message) {

    // JSON.stringify() : JSON->String
    // JSON.parse()     : String->JSON

    var receivedMessage = JSON.parse(message.body); // JSON 형식으로 메시지 파싱      
    //receivedMessage= {"shop_idx":1,"shop_idx":2,"order_status":"픽업완료"}
    //receivedMessage= {"shop_idx":1,"shop_idx":2,"order_status":"배달완료"}
    // 메시지에 있는 shopIdx와 현재 가게의 idx가 일치하는지 확인
    if (receivedMessage.shop_idx == currentShopIdx) {
          
         // alert("주문이 접수되었습니다.: 주문 번호 - ");
        
        location.reload(); // 페이지 새로고침
    
    }
  });
});


    </script>
  </head>

  <body>

    <!-- 상단 nav -->
    <div id="nav">
      <img src="${pageContext.request.contextPath}/images/로고.png" alt="로고" />
      <div class="user-info">
        <button class="btn" onclick="location.href='../member/logout.do'">로그아웃</button>
      </div>
    </div>

    <!-- 메인 레이아웃 -->
    <div class="container-flex">
      <!-- 사이드바 -->
      <div id="sidebar">
        <div class="menu-group">
          <div class="menu-title">사장관리</div>
          <a onclick="loadContent('../member/modify_form_owner.do')">사장정보</a>
        </div>
        <div class="menu-group">
          <div class="menu-title">메뉴관리</div>
          <a onclick="loadContent('menu_list.do')">메뉴목록</a>
          <a onclick="loadContent('menu_insert_form.do')">메뉴등록</a>
        </div>
        <div class="menu-group">
          <div class="menu-title">가맹점관리</div>
          <a onclick="loadContent('modify_form.do')">가게정보</a>
        </div>
        <div class="menu-group">
          <div class="menu-title">주문관리</div>
          
          <a onclick="loadContent('../order/order_list.do')">주문 내역
            <c:if test="${ order_count gt 0 }">
                <span class="badge" style="color: red;">주문</span>
            </c:if>
          </a>


          <a onclick="loadContent('../order/order_list_complete.do')">완료 주문 내역</a>
        </div>
        <div class="menu-group">
          <div class="menu-title">리뷰관리</div>
          <a onclick="loadContent('review_list.do')">리뷰관리</a>
        </div>
      </div>

      <!-- 본문 영역 -->
      <div class="contents">
        <div id="disp"></div>
      </div>
    </div>
  </body>
</html>
