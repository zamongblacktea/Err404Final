<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/shop_order_list.css">
  </head>
  <body>
    완료주문내역조회
    <c:forEach var="vo" items="${ status }">
      <div id="box">
        <div class="order_idx">${ vo.order_idx }</div>
        <div class="order_text">
          주문일자: ${ vo.order_regdate }<br />
          <c:forEach var="cart" items="${cart}"> ${cart.menu_name} </c:forEach>
          주문가격: <fmt:formatNumber value="${vo.amount}" pattern="#,#00" />원<br /> 고객주소: ${ vo.mem_addr1 } ${ vo.mem_addr2 }<br /> 주문요청사항: ${ vo.order_request }
          <br /> 배달요청사항: ${ vo.rider_request }<br /> 주문 상태: ${ vo.order_status }<br />
        </div>
      </div>
    </c:forEach>
  </body>
</html>
