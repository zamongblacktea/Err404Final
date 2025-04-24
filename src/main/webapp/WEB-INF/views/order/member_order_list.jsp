<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html>

    <head>
      <meta charset="UTF-8" />
      <title>Insert title here</title>

      <style>
        #box {
          border: 1px solid black;
          width: 800px;
          border-radius: 20px;
          padding-left: 30px;
        }
      </style>

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
      내 주문
      <c:forEach var="vo" items="${ status }">
        <div id="box">
          주문번호:${ vo.order_idx } <br />
          주문일자: ${ vo.order_regdate }<br />
          주문가격: ${ vo.amount }<br />
          고객주소: ${ vo.mem_addr1 } ${ vo.mem_addr2 }<br />
          주문요청사항: ${ vo.order_request } <br />
          배달요청사항: ${ vo.rider_request }<br />
          주문 상태: ${ vo.order_status }<br />

</div>
      </c:forEach>
    </body>

    </html>