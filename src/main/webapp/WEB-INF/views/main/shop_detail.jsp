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
    <link rel="icon" href="${pageContext.request.contextPath}/images/잇띵로고최종.png" type="image/x-icon">

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
      </div>
      <div class="header">
        <form id="search_form" action="${pageContext.request.contextPath}/main/list.do" method="get">
            <input type="text" name="search" id="search" class="form-control" placeholder="메뉴를 검색해주세요.">
            <input type="submit" class="btn btn-outline-success btn_search" value="검색">
        </form>
    </div>

  <div class="category">
    <%@ include file="catebar.jsp"%>
  </div>

    <div class="content">
      <div class="shop-detail">
        <div id="mybox">
          <div class="shop-title">${shop.shop_name}</div>
          <input type="hidden" name="shop_dfee" id="shop_dfee" value="${shop.shop_dfee}">
          <input type="hidden" name="shop_idx" id="shop_idx" value="${shop.shop_idx}">
          <div class="shop-content">
            <div id="shop_logo">
              <img src="${pageContext.request.contextPath}/images/${shop.shop_logo}" alt="가게로고" style="width: 80px; height: 100%" />
            </div>

            <ul class="list">
              <li>별점 | ⭐${shop.shop_rating}</li>
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
    	<div class="footer">
	
	<div class="footer-box" style="text-align: center; margin-top: 10px;"> 
	<p>주식회사 Eatting ｜ 공동대표 !Err404 박태섭 안소현 남가은 ｜ 서울특별시 관악구 청룡동 862-1 | http://www.gith.co.kr/</p>
	<p>고객센터: 02-6020-0052 (평일 오전 9시 ~ 오후 6시)</p>
	<p>Eatting은 통신판매 중개자로서 통신판매의 당사자가 아니며 상품 거래정보 및 거래 등에 대해 책임을 지지 않습니다.</p>
	<p>이용약관전자금거래 이용약관개인정보 처리방침</p>
	
	</div>
  </div>
    </div>
    <script src="${pageContext.request.contextPath}/js/detail_cart.js"></script>
    <script src="${pageContext.request.contextPath}/js/detail_menu.js"></script>
    
  </body>
</html>
