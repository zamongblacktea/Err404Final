<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
    html, body {
      height: 100%;
      margin: 0;
    }

    .page {
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }

    .content{
      flex: 1;
    }

    #mybox {
      margin: 0 auto;
      /* width: 1150px; */
      /* width: 800px; */
      width: 750px;
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
      justify-content: space-between;
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
    width: 280px;
    min-height: 400px; /* 기본 높이 설정 */
    border: 1px solid #ccc;
    padding: 15px;
    box-sizing: border-box;
    background-color: #fafafa;
    margin-left: 10px;
    font-size: 14px;
    border-radius: 8px;
    flex-shrink: 0; /* 붙는 거 방지 */
  }

    .cart {
      display: inline-block;
      width: 300px;
    }

    span{
      border: none;
    }

    .cart_li{
      list-style: none;
    }
    .footer {
      width: 100%;
      height: 150px;
      display: block;
    }
  </style>

  <script>
    // detail_content 출력
    function loadContent(url) {
        const shop_idx = "${shop.shop_idx}"; // 세션에서 shop_idx 꺼냄
        $.ajax({
          url: url,
          data: { shop_idx: shop_idx
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
        loadContent("/main/detail_menu.do");
      });

      $(document).ready(function () {
        checkShop(); // 페이지 로드 시 한 번 실행
      });

  </script>

  <body>
    <div class="page">
    <nav class="navbar">네비바 로그인/로그아웃
      <input type="button" value="장바구니" onclick="location.href='../cart/list.do?mem_idx=${user.mem_idx}'">
    </nav>
    <header class="header">헤더</header>
    <div class="content">
      <div class="shop-detail">
        <div id="mybox">
          <div class="shop-title">${shop.shop_name}</div>
          <input type="hidden" name="shop_dfee" id="shop_dfee" value="${shop.shop_dfee}">
          <div class="row shop-content">
            <div id="shop_logo" class="col-sm-4">
              <img src="${pageContext.request.contextPath}/images/${shop.shop_logo}" alt="가게로고" style="width: 100%; height: 100%" />
            </div>

            <ul class="list">
              <li>별점 ⭐${shop.shop_rating}</li>
              <li>최소주문금액 <fmt:formatNumber value="${shop.shop_minprice}" pattern="#,#00" />원</li>
            </ul>
          </div>
          <div class="shop-notice">가게 공지사항</div>

          <ul class="nav row">
            <li class="col-sm-4"><a onclick="loadContent('../main/detail_menu.do?shop_idx=${shop.shop_idx}');" class="nav-a">메뉴</a></li>
            <li class="col-sm-4"><a onclick="loadContent('../main/detail_review.do?shop_idx=${shop.shop_idx}');" class="nav-a">리뷰</a></li>
            <li class="col-sm-4"><a onclick="loadContent('../main/detail_info.do?shop_idx=${shop.shop_idx}');" class="nav-a">정보</a></li>
          </ul>
          <div class="detail-content" id="disp"></div>
        </div>
        <div class="cart">
          <%@ include file="./detail_cart.jsp" %>
        </div>
      </div>
    </div>
    </div>

  </div>
    <footer class="footer">푸터</footer>
    </div>
    <script src="${pageContext.request.contextPath}/js/detail_cart.js"></script>
  </body>
</html>
