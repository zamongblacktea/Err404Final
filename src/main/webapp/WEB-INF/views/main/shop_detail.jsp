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
    function insert_cart(f, force = false) {
      // 로그인 여부 체크
      if ("${empty user}" == "true") {
        if (confirm("장바구니 등록은 로그인 후 가능합니다.\n 로그인 하시겠습니까?") == false) return;

        //로그인 폼 이동
        location.href = "../member/login_form.do?url=" + encodeURIComponent(location.href);
        return;
      }

      let menu_idx = f.menu_idx.value;
      let mem_idx = f.mem_idx.value;
      let shop_idx = parseInt(f.shop_idx.value);
      let cart_price = f.menu_price.value;
      // let menu_price = f.menu_price.value;

      // Ajax 이용해서 장바구니 등록
      $.ajax({
        url: "../cart/insert.do",
        method: "POST",
        data: {
          mem_idx: mem_idx,
          shop_idx: shop_idx,
          menu_idx: menu_idx,
          cart_price : cart_price,
          cart_cnt : 1,
          force : force ? "true" : "false"
        },
        dataType: "json",
        success: function (res_data) {

          if (res_data.result == "exist") {
            alert("이미 장바구니에 등록되어있습니다");
          }
          if (res_data.result == "fail") {
            alert("장바구니에 등록 실패 하였습니다");
          }

          // if(res_data.result == "deleted"){
          //   if(confirm("같은 가게에서만 주문 가능합니다.\n장바구니를 비우고 새로 담으시겠습니까?")==false) return;
          // }
          if (res_data.result == "deleted") {
            if (confirm("같은 가게에서만 주문 가능합니다.\n장바구니를 비우고 새로 담으시겠습니까?")== true){
              $.ajax({
                url: "../cart/delete_all.do",
                method: "POST",
                data: {
                  mem_idx: mem_idx
                },
                dataType: "json",
                success: function(res_data){
                  insert_cart(f, "true");
                }
            });
          }
          return;
        }
        $.ajax({
          url: "../cart/list_view.do",
          type: "GET",
          data: { mem_idx: mem_idx, shop_idx:shop_idx },
          success: function (html) {
            $(".cart").html(html);
          },
          error: function (err) {
            console.error("장바구니 리로드 오류", err);
          }
        });
          // 성공 했을 때 코드
          if (confirm("장바구니에 등록되었습니다\n장바구니 화면으로 이동하시겠습니까?") == false) return;

          // 장바구니 보기로 이동
          location.href = "../cart/list.do?mem_idx=${user.mem_idx}&shop_idx=" + shop_idx;
        },
        error: function (err) {
          alert(err.responseText);
        },
      });

      
    }
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
              <li>별점 ${shop.shop_rating}</li>
              <li>최소주문금액 <fmt:formatNumber value="${shop.shop_minprice}" pattern="#,#00" />원</li>
            </ul>
          </div>
          <div class="shop-notice">가게 공지사항</div>

          <ul class="nav row">
            <li class="col-sm-4"><a href="../main/detail.do?shop_idx=${shop.shop_idx}" class="nav-a">메뉴</a></li>
            <li class="col-sm-4"><a href="" class="nav-a">리뷰</a></li>
            <li class="col-sm-4"><a href="../main/info.do?shop_idx=${shop.shop_idx}" class="nav-a">정보</a></li>
          </ul>
          <div>
            <div>메뉴카테고리</div>
            <c:forEach var="menu" items="${menu}">
              <form onsubmit="insert_cart(this); return false;">
                <input type="hidden" id="menu_idx" name="menu_idx" value="${menu.menu_idx}">
                <input type="hidden" id="shop_idx" name="shop_idx" value="${menu.shop_idx}">
                <input type="hidden" id="mem_idx" name="mem_idx" value="${user.mem_idx}">
                
                <div class="row" onclick="this.closest('form').requestSubmit();">
                <div class="menu-text col-sm-8">
                  <div class="menu-name">${menu.menu_name}</div>
                  <div class="menu-price" id="menu_price"><fmt:formatNumber value="${menu.menu_price}" pattern="#,#00"/>원</div>
                  <input type="hidden" name="menu_price" value="${menu.menu_price}">
                </div>
                <div class="menu-img col-sm-4">
                  <img src="${pageContext.request.contextPath}/images/${menu.menu_img}" alt="메뉴사진" style="width: 100%; height: 100%" />
                </div>
              </div>
            </form>
            </c:forEach>
          </div>
        </div>
        <div class="cart">
          <%@ include file="./detail_cart.jsp" %>
          <!-- <div>주문표/취소</div>
          <div>
            <c:forEach var="cart" items="${cart_list}">
              <li class="cart_li">
                <div id="menu_name">${cart.menu_name}</div>
                <div class="row">
                <div class="col-sm-6 text-left">
                <span>❌</span>
                <span><fmt:formatNumber value="${cart.menu_price}" pattern="#,#00" />원</span>
                </div>
                <div class="col-sm-6 text-right"><span onclick="minus('${cart.cart_idx}');" style="cursor: pointer;">➖</span>
                  <span id="cnt_${cart.cart_idx}" style="text-align: center;">${cart.cart_cnt}</span>
                  <span onclick="plus('${cart.cart_idx}');" style="cursor: pointer;">➕</span></div>
                </div>
              </li>
            </c:forEach>
          </div>
          <div>최소주문금액 얼마</div>
          <div id="total_amount"><fmt:formatNumber value="${total_amount }" type="currency" />
            <input type="hidden" name="amount" value="${total_amount}"></div>
          <div>주문하기 버튼</div> -->
        </div>
      </div>
    </div>
    </div>

  </div>
    <footer class="footer">푸터</footer>
    </div>
  </body>
</html>
