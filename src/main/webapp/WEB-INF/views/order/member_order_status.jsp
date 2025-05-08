<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <!DOCTYPE html>
    <html>

    <head>
      <meta charset="UTF-8" />
      <title>Insert title here</title>
      <!-- bootstrap 사용설정 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
      <!-- 웹소캣 -->
     <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
     <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

     <link rel="stylesheet" href="${pageContext.request.contextPath}/css/shop_order_list.css">

      <script>

      $('.status-btn').click(function () {
          const orderIdx = $(this).data('order-idx');
          const nextStatus = $(this).data('next-status');
          console.log(orderIdx, nextStatus);

          $.ajax({
              url: '../order/update_status.do',
              type: 'POST',
              contentType: 'application/json',
              data: JSON.stringify({
                orderIdx: orderIdx,
              orderStatus: nextStatus
            }),
            success: function (res) {
              //confirm("주문 상태를 변경 하시겠습니까 ? " + res.updatedStatus);
              // TODO: 화면 갱신 로직 추가
              loadContent('../order/order_list.do');
            },
            error: function (err) {
              alert("상태 변경 실패");
            }
          });
    });

    //웹소캣구독
    var currentShopIdx = '<%= session.getAttribute("shop_idx") %>';

    var socket = new SockJS('${pageContext.request.contextPath}/ws-orders');
    var stompClient = Stomp.over(socket);

    // WebSocket 연결 설정
    stompClient.connect({}, function (frame) {
    console.log('Connected: ' + frame);

      // 주문 상태 업데이트 메시지 구독
      stompClient.subscribe('/topic/orders', function (message) {

        // JSON.stringify() : JSON->String
        // JSON.parse()     : String->JSON

        var receivedMessage = JSON.parse(message.body); // JSON 형식으로 메시지 파싱      
        //receivedMessage= {"shop_idx":1,"shop_idx":2,"order_status":"픽업완료"}
        //receivedMessage= {"shop_idx":1,"shop_idx":2,"order_status":"배달완료"}
        // 메시지에 있는 shopIdx와 현재 가게의 idx가 일치하는지 확인
        if (receivedMessage.shop_idx == currentShopIdx) {

          if(receivedMessage.rider_status == "배차완료"){

           // alert("배차완료 되었습니다.: 주문 번호 - " + receivedMessage.order_idx);
            
          }else if(receivedMessage.order_status == "픽업완료"){
              
             // alert("픽업완료 되었습니다.: 주문 번호 - " + receivedMessage.order_idx);

            }else if(receivedMessage.order_status == "배달완료"){

             // alert("배달완료 되었습니다.: 주문 번호 - " + receivedMessage.order_idx);
            }
      
          location.reload(); // 페이지 새로고침
        } else {
          location.reload();
        }
      });
    });
  


      </script>
    </head>

    <body>
         <!-- 주문 목록이 없을 때 메시지 표시 -->
    <c:if test="${empty status}">
      <p>현재 진행 중인 주문이 없습니다.</p>
    </c:if>
      <c:forEach var="vo" items="${ status }">
        <div id="box">
          <div class="order_idx">
            ${ vo.order_idx }
          </div>
        <div class="order_text">
          주문일자: ${ vo.order_regdate }<br />
          
          주문가격: <fmt:formatNumber value="${vo.amount}" pattern="#,#00" />원<br />
          고객주소: ${ vo.mem_addr1 } ${ vo.mem_addr2 }<br />
          주문요청사항: ${ vo.order_request } <br />
          배달요청사항: ${ vo.rider_request }<br />
          <%-- 주문 상태: ${ vo.order_status }<br /> --%>
          <c:if test="${ vo.rider_status eq '배차완료'}">
            <label style="color: rgba(43, 226, 107, 0.805);">배차상태: 배차완료</label>
          </c:if> <br/> 
          <c:if test="${ vo.order_status eq '조리중'}">
             <label style="color: rgb(226, 122, 43); font-size: large;">주문상태: 조리중</label>
           </c:if> 
           <c:if test="${ vo.order_status eq '조리완료'}">
             <label style="color: rgb(226, 122, 43); font-size: large;">주문상태: 조리완료</label>
           </c:if> 
          <c:if test="${ vo.order_status eq '픽업완료'}">
             <label style="color: rgb(226, 122, 43); font-size: large;">주문상태: 픽업완료</label>
           </c:if>    
        <c:if test="${ vo.order_status eq '배달중'}">
        <label style="color: rgb(226, 122, 43); font-size: large;">주문상태 배달중...</label>
        </c:if>

          <!-- <c:forEach var="cart" items="${cart}">
          ${cart.menu_name}
          </c:forEach> -->
          메뉴 <br /> 
          ${ vo.menu_list } <br />
          결제 : ${ vo.pay_type } <br />
          고객 주소: ${ vo.mem_addr1 } ${ vo.mem_addr2 }<br />
          전화번호 : ${ vo.mem_phone } <br />
          주문요청사항: ${ vo.order_request } <br />
          배달요청사항: ${ vo.rider_request }<br />
          주문 상태: ${ vo.order_status }<br />
          주문 가격: <fmt:formatNumber value="${vo.amount}" pattern="#,#00" />원<br />
        </div>
          <div class="btn-div">
            <c:if test="${vo.order_status eq 'NONE'}">
              <button class="btn status-btn"
                      data-order-idx="${vo.order_idx}"
                      data-next-status="조리대기">주문 수락</button>
            </c:if>
            
            <c:if test="${vo.order_status eq '조리대기'}">
              <button class="btn status-btn"
                      data-order-idx="${vo.order_idx}"
                      data-next-status="조리중">조리 시작</button>
            </c:if>

            <c:if test="${vo.order_status eq '조리중'}">
              <button class="btn status-btn"
                      data-order-idx="${vo.order_idx}"
                      data-next-status="픽업대기">조리 완료</button>
            </c:if>
        
            
          </div>
        </div>
      </c:forEach>
    </body>

    </html>