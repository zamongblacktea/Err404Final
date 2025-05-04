<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/shop_list.css">
  </head>
  <body>
        <c:forEach var="vo" items="${shop_list}">
          <div class="container" onclick="location.href='../main/detail.do?shop_idx=${vo.shop_idx}'">
            <div class="shop-list">
              <div id="shop_logo">
                <img src="${pageContext.request.contextPath}/images/${vo.shop_logo}" alt="가게로고">
              </div>
              <div id="shop_content">
                <div class="shop_info">${vo.shop_name}</div>
                <div class="shop_info">별점 ${vo.shop_rating} | 리뷰 ${vo.shop_reviewcnt}</div>
                <div class="shop_info">
                  <fmt:formatNumber value="${vo.shop_minprice}" pattern="#,#00" />원 이상 주문</div>
              </div>    
            </div>        
          </div>

        </c:forEach>

  </body>
</html>

