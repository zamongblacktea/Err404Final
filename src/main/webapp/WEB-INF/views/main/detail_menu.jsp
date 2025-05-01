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

  <body>
    <c:if test="${empty menu}">
      <div class="review-box" style="text-align: center; padding-top: 35px;">
          <span style="color: red;">해당 가게의 메뉴가 없습니다.</span>
      </div>
    </c:if>

    <!-- <div>메뉴카테고리</div> -->
    <c:forEach var="menu" items="${menu}">
      <form onsubmit="insert_cart(this); return false;">
        <input type="hidden" id="menu_idx" name="menu_idx" value="${menu.menu_idx}">
        <input type="hidden" id="shop_idx" name="shop_idx" value="${param.shop_idx}">
        <input type="hidden" id="mem_idx" name="mem_idx" value="${user.mem_idx}">
        
        <div class="menu_row" onclick="this.closest('form').requestSubmit();">
          <div class="menu-text">
            <div class="menu-name">${menu.menu_name}</div>
            <div class="menu-explain">${menu.menu_explain}</div>
            <div class="menu-price" id="menu_price"><fmt:formatNumber value="${menu.menu_price}" pattern="#,#00"/>원</div>
            <input type="hidden" name="menu_price" value="${menu.menu_price}">
          </div>
          <div class="menu-img">
            <img src="${pageContext.request.contextPath}/images/${menu.menu_img}" alt="메뉴사진" style="width: 100%; height: 100%" />
          </div>
        </div>
    </form>
    </c:forEach>
 
  </body>
</html>
