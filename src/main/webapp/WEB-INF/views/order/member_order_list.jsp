<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <!DOCTYPE html>
    <html>

    <head>
      <meta charset="UTF-8" />
      <title>Insert title here</title>
      <link rel="stylesheet" href="${pageContext.request.contextPath}/css/shop_order_list.css">

      <script>

      $('.status-btn').click(function () {
        const orderIdx = $(this).data('order-idx');
        const nextStatus = $(this).data('next-status');
        console.log(orderIdx, nextStatus);

        $.ajax({
          url: 'update_status.do',
          type: 'POST',
          contentType: 'application/json',
          data: JSON.stringify({
            orderIdx: orderIdx,
            orderStatus: nextStatus
          }),
          success: function (res) {
            confirm("주문 상태를 변경 하시겠습니까 ? " + res.updatedStatus);
            // TODO: 화면 갱신 로직 추가
            loadContent('order_list.do');
          },
          error: function (err) {
            alert("상태 변경 실패");
          }
        });
      });



      </script>
    </head>

    <body>
      <div id="box">
    <!-- 주문 목록이 없을 때 메시지 표시 -->
    <c:if test="${empty status}">
      <p>작성하신 리뷰가 없습니다.</p>
    </c:if>

      주문내역조회
      <c:forEach var="vo" items="${ status }">
        <div id="box">
          <div class="order_idx">
            ${ vo.order_idx }
          </div>
        <div class="order_text">
          주문일자: ${ vo.order_regdate }<br />
          <c:forEach var="cart" items="${cart}">
          ${cart.menu_name}
          </c:forEach>
          주문가격: <fmt:formatNumber value="${vo.amount}" pattern="#,#00" />원<br />
          고객주소: ${ vo.mem_addr1 } ${ vo.mem_addr2 }<br />
          주문요청사항: ${ vo.order_request } <br />
          배달요청사항: ${ vo.rider_request }<br />
          주문 상태: ${ vo.order_status }<br />
        </div>
          <div>
            <c:if test="${vo.order_status eq '조리중'}">
              <button class="btn status-btn">리뷰쓰기</button>
          </c:if>
            
          </div>
        </div>
      </c:forEach>
    </div>
    </body>

    </html>