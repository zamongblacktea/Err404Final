<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>주문대기 페이지</title>
    <!-- 파비콘 -->
    <link rel="icon" href="${pageContext.request.contextPath}/images/잇띵로고최종.png" type="image/x-icon">
     <!-- 웹소캣 -->
     <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
     <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <script>

      function rider_accept(order_idx,rider_idx){

          $.ajax({
            url : "rider_accept.do",
            //컨트롤러에게 보내야할 데이터들 order_idx,rider_idx
            data: {"order_idx":order_idx,"rider_idx":rider_idx},
            //컨트롤러가 어떤 데이터형식으로 받을것인가 ? json
            dataType:"json",
            success:function(res_data){
              // res_data ={"result": true}  or {"result": false}
              if(res_data.res_data==false){
                alert("배차실패");
                return;
              }
              //배차 성공했으면
              progress();
            },
            error:function(err){
              alert(err.responseText);
            }
  
          });
       }//end: fuction rider_accept(order_idx,rider_idx)

      //웹소캣 구독 
      var socket = new SockJS('${pageContext.request.contextPath}/ws-orders');
      var stompClient = Stomp.over(socket);
  
      // WebSocket 연결 설정
      stompClient.connect({}, function (frame) {
          // 주문 상태 업데이트 메시지 구독
      stompClient.subscribe('/topic/orders', function (message) {
              // 서버에서 메시지가 올 때마다 DOM 업데이트
      location.reload(); // 페이지를 새로고침하여 새로운 데이터를 반영
          });
      });

    </script>

  </head>

  <body>
     <!-- foreign키로 라이더의 아이디도 받아와야한다. -->

    <!-- 아래 내용을 하나의 패널이나 네모안에 넣고 오른쪽에 경로보기 버튼누르기 -->
    <!-- forEach문으로 출력 여기서 주문대기 할때 거리가 짧은순으로 orderby해서 출력되도록 하기  -->
     <!-- for(DeliveryVo vo : standby_list) -->
     <c:if test="${ empty standby_list }">
      현재 배차대기목록이 없습니다.
     </c:if>
     
    <c:forEach var="vo" items="${standby_list}">
      
    
      <div>주문번호 : ${vo.order_idx}</div>
      <div>가게이름 : ${vo.shop_name}</div>
      <div>가게위치 : ${vo.shop_addr1} ${vo.shop_addr2}</div>
      <div>메뉴 : ${vo.menu_name} </div>
      <div>메뉴가격 : ${vo.menu_price}</div>
      <div>배달장소 : ${vo.mem_addr1} ${vo.mem_addr2}</div>
      <div>배달요청사항 : ${vo.rider_request}</div>

        <input  type="button"  value="경로보기"    onclick="location.href='../route/route.do'" />
        <!-- 배차받기를 누르면 배달현황으로 넘어가기 -->
        <input type="button" value="배차받기" onclick="rider_accept('${ vo.order_idx }','${ user.rider_idx}');" />
        <!-- 배차받기 누르면 고객,가게쪽으로 알림뜨드록 -->
         <hr>
       
      </c:forEach>
   
  </body>
</html>