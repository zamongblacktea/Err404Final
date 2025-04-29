<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
*, :before, :after {
  box-sizing: border-box;
}

/* HEADER STYLES */
.header {
  position: fixed;
  left: 0;
  top: 80px;
  bottom: 0;
  width: 17.5em;
  /* background: #35302D; */
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


</style>

<script>
  function loadContent(url) {
    const mem_idx = "${user.mem_idx}"; // 세션에서 shop_idx 꺼냄
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
    loadContent("modify_form.do?mem_idx=${ user.mem_idx }");
  });
</script>
</head>
<body>

  <!-- <div id="sidebar">
    <div class="menu-group">
      <div class="menu-title">사장관리</div>
      <a onclick="loadContent('modify_form.do?mem_idx=${ user.mem_idx }')">내 정보</a>
    </div>
    <div class="menu-group">
      <div class="menu-title">주문관리</div>
      <a onclick="loadContent('../order_list.do?mem_idx=${ user.mem_idx }')">내 주문 내역</a>
    </div>
    <div class="menu-group">
      <div class="menu-title">리뷰관리</div>
      <a onclick="loadContent('review_list.do?mem_idx=${ user.mem_idx }')">내가 쓴 리뷰</a>
    </div>
  </div> -->

    <header class="header" role="banner">
        <!-- <h1 class="logo">
          <a href="#">Terence <span>Devine</span></a>
        </h1>
        <div class="nav-wrap">
          <nav class="main-nav" role="navigation">
            <ul class="unstyled list-hover-slide">
              <li><a href="modify_form.do?mem_idx=${ user.mem_idx }">내 정보</a></li>
              <li><a href="order_list.do?mem_idx=${ user.mem_idx }">내 주문 내역</a></li>
              <li><a href="review_list.do?mem_idx=${ user.mem_idx }">내가 쓴 리뷰</a></li>
              <li><a href="rider_approve.do?mem_idx=${ user.mem_idx }&mem_grade=${ user.mem_grade }">내 문의 내역</a></li>
            </ul>
          </nav>
        </div> -->
        <div id="sidebar">
          <div class="menu-group">
            <div class="menu-title">내 정보관리</div>
            <a onclick="loadContent('modify_form.do?mem_idx=${ user.mem_idx }')">내 정보</a>
          </div>
          <div class="menu-group">
            <div class="menu-title">주문관리</div>
            <a onclick="loadContent('order_list.do?mem_idx=${ user.mem_idx }')">내 주문 내역</a>
            <a onclick="loadContent('../cart/list.do?mem_idx=${ user.mem_idx }')">장바구니</a>
            <!-- <a onclick="loadContent('../order/order_list_complete.do')">완료 주문 내역</a> -->
          </div>
          <div class="menu-group">
            <div class="menu-title">리뷰관리</div>
            <a onclick="loadContent('review_list.do?mem_idx=${ user.mem_idx }')">내가 쓴 리뷰</a>
          </div>
        </div>
      </header>

</body>
</html>