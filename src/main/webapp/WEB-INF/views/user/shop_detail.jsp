<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  </head>
  <style>
    * {
      border: 1px solid black;
      margin: 0;
      padding: 0;
    }

    #mybox {
      margin: 0 auto;
      /* width: 1150px; */
      width: 800px;
      padding-left: 10px;
      display: inline-block;
    }

    .navbar {
      width: 100%;
      height: 80px;
    }
    .header {
      width: 100%;
      height: 160px;
    }

    .shop-detail {
      width: 1150px;
      /* display: block; */
      display: flex;
      margin: 0 auto;
    }

    .row {
      margin: auto;
      /* margin-top: 8px; */
    }

    .shop-title {
      margin-bottom: 0;
      height: 43px;
    }

    .shop-content {
      height: 100px;
    }

    .shop-notice {
      margin-bottom: 10px;
      height: 44px;
    }

    #shop_logo {
      width: 80px;
      height: 80px;
      display: inline-block;
      margin-left: 10px;
      margin-top: 10px;
    }
    .list {
      display: inline-block;
      margin-left: 15px;
      margin-top: 10px;
    }

    .list > li {
      list-style: none;
    }

    .nav {
      height: 47px;
    }

    .nav > li {
      list-style: none;
      display: inline-block;
    }

    .menu-text {
      width: 520px;
      margin-top: 10px;
    }

    .menu-img {
      width: 112px;
      height: 80px;
      margin-left: 140px;
    }

    .cart {
      display: inline-block;
      width: 300px;
    }
    .footer {
      width: 100%;
      height: 150px;
    }
  </style>

  <body>
    <nav class="navbar">네비바 로그인/로그아웃</nav>
    <header class="header">헤더</header>
    <div class="content">
      <div class="shop-detail">
        <div id="mybox">
          <div class="shop-title">${shop.shop_name}</div>
          <div class="row shop-content">
            <div id="shop_logo" class="col-sm-4">
              <img src="${pageContext.request.contextPath}/images/${shop.shop_logo}" alt="가게로고" style="width: 100%; height: 100%" />
            </div>

            <ul class="list">
              <li>별점 ${shop.shop_rating}</li>
              <li><fmt:formatNumber value="${shop.shop_minprice}" pattern="#,#00" />원 이상 주문</li>
              <li>결제 카카오결제</li>
            </ul>
          </div>
          <div class="shop-notice">가게 공지사항</div>

          <ul class="nav row">
            <li class="col-sm-4"><a class="nav-a">메뉴</a></li>
            <li class="col-sm-4"><a href="" class="nav-a">리뷰</a></li>
            <li class="col-sm-4"><a href="" class="nav-a">정보</a></li>
          </ul>
          <div>
            <div>메뉴카테고리</div>
            <div class="row">
              <div class="menu-text col-sm-8">
                <div class="menu-name">메뉴이름</div>
                <div class="menu-price">메뉴가격</div>
              </div>
              <div class="menu-img col-sm-4"><img src="${pageContext.request.contextPath}/images/${menu.menu_img}" alt="메뉴사진" style="width: 100%; height: 100%" /></div>
            </div>
          </div>
        </div>
        <div class="cart">
          <div>주문표/취소</div>
          <div>메뉴/가격/수량</div>
          <div>최소주문금액 얼마</div>
          <div>합계 얼마</div>
          <div>주문하기 버튼</div>
        </div>
      </div>
    </div>

    <footer class="footer">푸터</footer>
  </body>
</html>
