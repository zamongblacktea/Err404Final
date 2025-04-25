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
    
    table.table-borderless td,
    table.table-borderless th,
    table.table-borderless tr{
      border:none !important
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
              <li><fmt:formatNumber value="${shop.shop_minprice}" pattern="#,#00" />원 이상 주문</li>
              <li>결제 카카오결제</li>
            </ul>
          </div>
          <div class="shop-notice">가게 공지사항</div>

          <ul class="nav row">
            <li class="col-sm-4"><a href="../main/detail.do?shop_idx=${shop.shop_idx}" class="nav-a">메뉴</a></li>
            <li class="col-sm-4"><a href="" class="nav-a">리뷰</a></li>
            <li class="col-sm-4"><a href="../main/info.do?shop_idx=${shop.shop_idx}" class="nav-a">정보</a></li>
          </ul>
          <div>
            <div>가게 정보</div>
              <form onsubmit="insert_cart(this); return false;">
                <input type="hidden" id="mem_idx" name="mem_idx" value="${user.mem_idx}">
                <input type="hidden" id="shop_idx" name="shop_idx" value="${shop.shop_idx}">
                
                <div class="row">
                <div class="notice">
                  📢사장님 알림
                  <hr>
                  <div class="notice_content">
                    ${shop.shop_notice}
                  </div>
                </div>
                <div class="intro">
                  🤗가게 소개
                  <hr>
                  <div class="intro_content">
                    ${shop.shop_intro}
                  </div>
                </div>
                <div class="info">
                  🍴업체정보
                  <hr>
                  <div class="info_content">
                    <table class="table table-borderless">
                      <tr>
                        <th>영업시간</th>
                        <td>${shop.shop_optime} - ${shop.shop_cltime}</td>
                      </tr>
                      <tr>
                        <th>전화번호</th>
                        <td>${shop.shop_phone}</td>
                      </tr>
                      <tr>
                        <th>주소</th>
                        <td>${shop.shop_addr1} ${shop.shop_addr2}</td>
                      </tr>

                    </table>
                  </div>
                </div>
                <div class="pay_info">
                  💳결제 정보
                  <hr>
                  <div class="pay_info_content">
                    <table class="table table-borderless">
                      <tr>
                        <th>최소주문금액</th>
                        <td><fmt:formatNumber value="${shop.shop_minprice}" pattern="#,#00" />원</td>
                      </tr>
                      <tr>
                        <th>결제수단</th>
                        <td>카카오페이결제</td>
                      </tr>
                    </table>
                  </div>
                </div>
                <div class="owner_info">
                  👤사업자 정보
                  <hr>
                  <div class="owner_content">
                    <table class="table table-borderless">
                      <tr>
                        <th>상호명</th>
                        <td>${shop.shop_company}</td>
                      </tr>
                      <tr>
                        <th>사업자등록번호</th>
                        <td>${shop.shop_bnumber}</td>
                      </tr>
                    </table>
                  </div>
                </div>
              </div>
            </form>
          </div>
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
  </body>
</html>
