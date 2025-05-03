<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/shop_order_list.css">
</head>
<body>

     <!-- 주문 목록이 없을 때 메시지 표시 -->
     <c:if test="${empty list}">
        <p style="color: red; font-size: 30px;">주문목록이 없습니다.</p>
      </c:if>
        <c:forEach var="vo" items="${ list }">
          <div id="box">
            <div class="order_idx">
              ${ vo.order_idx }
            </div>
          <div class="order_text">
            주문일자: ${ vo.order_regdate }<br />
            결제: ${vo.pay_type}<br />
            <!-- <c:forEach var="cart" items="${cart}">
            ${cart.menu_name}
            </c:forEach> -->
            메뉴<br />
            ${ vo.menu_list} <br />
            고객주소: ${ vo.mem_addr1 } ${ vo.mem_addr2 }<br />
            주문요청사항: ${ vo.order_request } <br />
            배달요청사항: ${ vo.rider_request }<br />
            주문 상태: ${ vo.order_status }<br />
            주문가격: <fmt:formatNumber value="${vo.amount}" pattern="#,#00" />원<br />
          </div>
            <div>  
              <c:if test="${vo.delivery_status eq '배달완료' && vo.review_available == 0 }">
                <button class="btn status-btn">리뷰쓰기</button>
              </c:if>
              <!-- 픽업완료/배달중/배달완료 -->
              
            </div>
        </div>
        <a href="review_form.do?mem_idx=${vo.mem_idx}&shop_idx=${vo.shop_idx}&menu_idx=${vo.menu_idx}&order_idx=${vo.order_idx}&delivery_idx=${vo.delivery_idx}">리뷰 쓰기</a><br>
        </c:forEach>

</body>
</html>