<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
 

    <style>
      .cart_list > .row{
        width: 247px;
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
    </style>

    <script>
      $(document).ready(function () {
        checkShop(); // 페이지 로드 시 한 번 실행
      });
    
    </script>
  </head>
  <body>
    <form class="form-inline">
    <div id="cart_area">
    <div>주문표/<span onclick="delete_all();">🗑️</span></div>
      <c:choose>
      <c:when test="${empty cart_list}">
        <div style="text-align: center; margin-top: 65px">
          장바구니가 비어있습니다.
        </div>
      </c:when>

      <c:otherwise>      
      <c:forEach var="cart" items="${cart_list}">
        <input type="hidden" name="shop_idx" id="shop_idx" value="${cart.shop_idx}">
        <input type="hidden" name="menu_idx" id="menu_idx" value="${cart.menu_idx}">
        <input type="hidden" name="mem_idx" id="mem_idx" value="${cart.mem_idx}">
        <li class="cart_li" id="row_${cart.cart_idx}">
          <div id="menu_name">${cart.menu_name}</div>
          <div class="row">
            <div class="col-sm-6 text-left">
              <span onclick="delete_one('${cart.cart_idx}')">❌</span>
              <span><fmt:formatNumber value="${cart.menu_price}" pattern="#,#00" />원</span>
            </div>
            <div class="col-sm-6 text-right">
              <span onclick="minus('${cart.cart_idx}');" style="cursor: pointer">➖</span>
              <span id="cnt_${cart.cart_idx}" style="text-align: center">${cart.cart_cnt}</span>
              <span onclick="plus('${cart.cart_idx}');" style="cursor: pointer">➕</span>
            </div>
          </div>
        </li>
      </c:forEach>

      <c:if test="${shop.shop_minprice > total_amount}">
        <div>최소주문금액 얼마</div>
      </c:if>
      <div id="total_amount">
        <fmt:formatNumber value="${total_amount }" type="currency" />
        <input type="hidden" name="amount" value="${total_amount}" />
      </div>
    </c:otherwise>
  </c:choose>

      <div id="shop_dfee">배달요금 <fmt:formatNumber value="${dfee}" pattern="#,#00" />원 별도</div>
      <!-- <input type="hidden" id="dFee" name="dFee" value="${dfee}"> -->

      <div><input type="button" class="btn btn-primary" id="btn_order" value="주문하기" onclick="cart_payment(this.form);" disabled="disabled"></div>
</div>
  </form>
  <script src="${pageContext.request.contextPath}/js/detail_cart.js"></script>
  </body>
</html>
