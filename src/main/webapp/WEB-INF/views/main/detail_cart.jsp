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
 
  </head>
  <body>
    <form class="form-inline" method="POST">
      <div id="cart_area">
      <input type="hidden" name="shop_idx" id="shop_idx" value="${param.shop_idx}">
      <input type="hidden" name="mem_idx" id="mem_idx" value="${user.mem_idx}">
      <div class="cart-title">주문표<span style="margin-left: 210px;" onclick="delete_all();">🗑️</span></div>
      <c:choose>
      <c:when test="${empty cart_list}">
        <div style="text-align: center; padding-top: 40px; border: 1px solid #d9d9d9; height: 100px;">
          장바구니가 비어있습니다.
        </div>
      </c:when>

      <c:otherwise>      
      <c:forEach var="cart" items="${cart_list}">
        <!-- <input type="hidden" name="shop_idx" id="shop_idx" value="${cart.shop_idx}"> -->
        <input type="hidden" name="menu_idx" id="menu_idx" value="${cart.menu_idx}">
        <!-- <input type="hidden" name="mem_idx" id="mem_idx" value="${cart.mem_idx}"> -->
        <li class="cart_li" id="row_${cart.cart_idx}">
          <div id="cart-name">${cart.menu_name}</div>
          <div class="cart-price">
            <div class="order_price">
              <span onclick="delete_one('${cart.cart_idx}')">❌</span>
              <span><fmt:formatNumber value="${cart.menu_price}" pattern="#,#00" />원</span>
            </div>
            <div class="cart_cnt">
              <span onclick="minus('${cart.cart_idx}');" style="cursor: pointer">➖</span>
              <span id="cnt_${cart.cart_idx}" style="text-align: center">${cart.cart_cnt}</span>
              <span onclick="plus('${cart.cart_idx}');" style="cursor: pointer">➕</span>
            </div>
          </div>
        </li>
      </c:forEach>

      <c:if test="${shop.shop_minprice > total_amount}">
        <div id="shop_dfee">배달요금 <fmt:formatNumber value="${shop_dfee}" pattern="#,#00" />원 별도</div>
        <input type="hidden" name="amount" value="${total_amount + shop_dfee}">
        <div>최소주문금액 : <fmt:formatNumber value="${shop.shop_minprice}" pattern="#,#00" />원</div>
      </c:if>

      <div id="shop_dfee">배달요금 <fmt:formatNumber value="${shop_dfee}" pattern="#,#00" />원 별도</div>
      <input type="hidden" name="amount" value="${total_amount + shop_dfee}">
      <div id="total_amount">
        합계: 
        <fmt:formatNumber value="${total_amount }" pattern="#,#00" />원
        <input type="hidden" name="total_amount" value="${total_amount}" />
      </div>
    </c:otherwise>
  </c:choose>

      <!-- <div id="shop_dfee">배달요금 <fmt:formatNumber value="${shop_dfee}" pattern="#,#00" />원 별도</div>
      <input type="hidden" name="amount" value="${total_amount + shop_dfee}"> -->

    <div><input type="button" class="btn btn-primary" id="btn_order" value="주문하기" onclick="cart_payment(this.form)" disabled="disabled"></div>
</div>
  </form>
  <!-- <script src="${pageContext.request.contextPath}/js/detail_cart.js"></script> -->
  </body>
</html>
