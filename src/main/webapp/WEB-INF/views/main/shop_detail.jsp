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

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/shop_detail.css">

     <script>
      // detail_content 출력
      function loadContent(url) {
        const shop_idx = "${shop.shop_idx}"; // 세션에서 shop_idx 꺼냄
        $.ajax({
          url: url,
          data: { shop_idx: shop_idx },
          success: function (res_data) {
            $("#disp").html(res_data);
          },
          error: function (err) {
            alert("에러 발생: " + err.responseText);
          },
        });
      }

      // 페이지 로드 시 기본으로 메뉴 목록 표시
      $(document).ready(function () {
        loadContent("/main/detail_menu.do");
      });

      $(document).ready(function () {
        checkShop(); // 페이지 로드 시 한 번 실행
      });
     </script>

      <script>
        document.addEventListener('DOMContentLoaded', () => {
          const navButtons = document.querySelectorAll('.content_nav .nav-a');
          navButtons.forEach(btn => {
            btn.addEventListener('click', () => {
              navButtons.forEach(b => b.classList.remove('active'));
              btn.classList.add('active');
            });
          });
          
          // 첫 번째 버튼 미리 활성화
          if (navButtons[0]) navButtons[0].classList.add('active');
        });
      </script>

  </head>

  <body>
    <div class="page">
      <div class="navbar">
        <%@ include file="navbar.jsp" %>
        <input type="button" value="장바구니" onclick="location.href='../cart/list.do?mem_idx=${user.mem_idx}'">
      </div>
    <div class="header">
      <form id="search_form" action="">
          <input type="text" id="search" class="form-control">
          <input type="button" class="btn btn-info btn_search" value="검색" onclick="">
      </form>
  </div>

  <div class="category">
    가게 카테고리
  </div>

    <div class="content">
      <div class="shop-detail">
        <div id="mybox">
          <div class="shop-title">${shop.shop_name}</div>
          <input type="hidden" name="shop_dfee" id="shop_dfee" value="${shop.shop_dfee}">
          <div class="shop-content">
            <div id="shop_logo">
              <img src="${pageContext.request.contextPath}/images/${shop.shop_logo}" alt="가게로고" style="width: 80px; height: 100%" />
            </div>

            <ul class="list">
              <li>별점 ⭐${shop.shop_rating}</li>
              <li>최소주문금액 <fmt:formatNumber value="${shop.shop_minprice}" pattern="#,#00" />원</li>
            </ul>
          </div>
          <div class="shop-notice">가게 공지사항 | ${shop.shop_notice}</div>

          <ul class="content_nav">
            <li><input type="button" onclick="loadContent('../main/detail_menu.do?shop_idx=${shop.shop_idx}');" class="nav-a" value="메뉴"></input></li>
            <li><input type="button" onclick="loadContent('../main/detail_review.do?shop_idx=${shop.shop_idx}');" class="nav-a" value="리뷰"></input></li>
            <li><input type="button" onclick="loadContent('../main/detail_info.do?shop_idx=${shop.shop_idx}');" class="nav-a" value="정보"></input></li>
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
    <script src="${pageContext.request.contextPath}/js/detail_menu.js"></script>
    
  </body>
</html>
