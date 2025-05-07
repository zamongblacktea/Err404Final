<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>사장 정보</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="icon" href="${pageContext.request.contextPath}/images/잇띵로고최종.png" type="image/x-icon">

    <!-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/shop_order_list.css"> -->


    <style>
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }

      /* body {
        background-color: #f6f8fc;
      } */

      /* 상단 nav */
      /* #nav {
        background: #ff694a;
        height: 60px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 0 20px;
      } */

      /* #nav img {
        height: 45px;
      } */

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
        min-height: 92.2vh;
        height: auto;
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

      #sidebar a.active {
        background-color: #ff694a;
        color: white;
        font-weight: bold;
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
    "memberId": "${ user.mem_idx }", // fill user's member id
    "profile": { // fill user's profile
      "name": "${user.mem_name}", // fill user's name
      "landlineNumber": "USER_LANDLINE_NUMBER", // fill user's landline number  
      "CUSTOM_VALUE_1": "VALUE_1", // custom property
      "CUSTOM_VALUE_2": "VALUE_2" // custom property
    }
  });
</script>
<script>
  const mem_idx = "${user.mem_idx}"; // 세션에서 mem_idx 꺼냄


  function loadCart(url){

    $.ajax({
      url: url,
      data: { mem_idx: mem_idx,
       },
      success: function(res_data) {

        $("#disp").html(res_data);
      },
      error: function(err) {
        alert("에러 발생: " + err.responseText);
      }
    });

  }



  function loadContent(url) {
    
    $.ajax({
      url: url,
      data: { mem_idx: mem_idx,
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
    loadContent("modify_form.do?mem_idx=${ user.mem_idx }"); //내 주문 내역 페이지 메인되도록 설정
  });

  // 사이드바 버튼 active
  $(document).ready(function () {
        const navButtons = $("#sidebar a");

        // 5번째 버튼 미리 active 부여 (인덱스 4)
        if (navButtons[0]) $(navButtons[0]).addClass("active");

        // sidebar a 클릭 시 active 클래스 제어
        navButtons.on("click", function () {
          navButtons.removeClass("active");
          $(this).addClass("active");
        });
      });


</script>
  </head>

  <body>

    <!-- 상단 nav -->
    <div id="nav">
      <%@ include file="../main/navbar.jsp" %>
    </div>

    <!-- 메인 레이아웃 -->
    <div class="container-flex">
      <!-- 사이드바 -->
      <div id="sidebar">
        <div class="menu-group">
          <div class="menu-title">내 정보관리</div>
          <a onclick="loadContent('modify_form.do?mem_idx=${ user.mem_idx }')">내 정보</a>
        </div>
        <div class="menu-group">
          <div class="menu-title">주문관리</div>
          <a onclick="loadContent('order_list.do?mem_idx=${ user.mem_idx }')">내 주문 내역</a>
          <!-- <a onclick="loadContent('../order/member_order_status.do?mem_idx=${ user.mem_idx }')">내 주문 현황</a> -->
          <a onclick="loadCart('../cart/list.do?mem_idx=${ user.mem_idx }')">장바구니</a>
          <!-- <a onclick="loadContent('../order/order_list_complete.do')">완료 주문 내역</a> -->
        </div>
        <div class="menu-group">
          <div class="menu-title">리뷰관리</div>
          <a onclick="loadContent('my_review.do?mem_idx=${ user.mem_idx }')">내가 쓴 리뷰</a>
        </div>
      </div>

      <!-- 본문 영역 -->
      <div class="contents">
        <div id="disp"></div>
      </div>
    </div>
  </body>
</html>
