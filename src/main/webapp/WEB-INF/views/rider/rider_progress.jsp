<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문현황 페이지</title>
    <!-- 파비콘 -->
    <link rel="icon" href="${pageContext.request.contextPath}/images/잇띵로고최종.png" type="image/x-icon">
     <!-- 웹소캣 -->
     <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
     <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <!-- bootstrap 3.x 사용설정 -->
    <script>
    // function setActiveButton(activeId) {
    //     // 모든 버튼 클래스 제거
    //     document.querySelectorAll(".buttons").forEach(btn => {
    //     btn.classList.remove("active");
    //     });

    //     // 활성화 버튼에 active 클래스 추가
    //     document.getElementById(activeId).classList.add("active");
    // }

    function delivery_pickup(order_idx,shop_idx,mem_idx){

            $.ajax({
            url : "deliverypickup.do",
            //컨트롤러에게 보내야할 데이터들 order_idx,rider_idx
            data: {"order_idx":order_idx,"shop_idx":shop_idx,"mem_idx":mem_idx},
            //컨트롤러가 어떤 데이터형식으로 받을것인가 ? json
            dataType:"json",
            success:function(res_data){
                // res_data ={"result": true}  or {"result": false}
                if(res_data.res_data==false){
                alert("픽업실패");
                return;
                }
                //픽업성공했으면
                progress();
            },
            error:function(err){
                alert(err.responseText);
            }

            });
            }//end: fuction pickup(order_idx)

    function delivery_complete(order_idx,shop_idx,mem_idx){

        $.ajax({
        url : "deliverycomplete.do",
        //컨트롤러에게 보내야할 데이터들 order_idx,rider_idx
        data: {"order_idx":order_idx,"shop_idx":shop_idx,"mem_idx":mem_idx},
        //컨트롤러가 어떤 데이터형식으로 받을것인가 ? json
        dataType:"json",
        success:function(res_data){
            // res_data ={"result": true}  or {"result": false}
            if(res_data.res_data==false){
            alert("배달실패");
            return;
            }
            //배달 성공했으면
            complete();
        },
        error:function(err){
            alert(err.responseText);
        }

        });
    }//end: fuction rider_accept(order_idx,rider_idx)        
          
    //웹소캣구독
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
         if(receivedMessage.order_status == "픽업대기"){
            //location.reload(); // 페이지 새로고침
             progress();
         }          
    
      });
    });
    
    </script>
</head>
<body>
    <div class="content-items" style="width: 90%;margin: auto; padding-top: 3%;">
    <!-- 아래 내용을 하나의 패널이나 네모안에 넣고 오른쪽에 경로보기 버튼누르기 -->
     <!-- 하나의 div넣고 경로보기랑 픽업완료도 div로 넣고 그리드로 넣어야 할듯 -->
    <!-- 배차 받기를 누르면 아래에 나오는것에 고객 전화번호도 추가시켜야함 포린키로 설정해야할듯 -->
    <c:choose>
        <c:when test="${empty rider_list}">
            <p>현재 배달 진행 중인 건이 없습니다.</p>
        </c:when>

        <c:otherwise>
        <c:forEach var="vo" items="${rider_list}"> 
            <div>주문번호 : ${vo.order_idx}</div> 
            <%-- <div>주문상태 : ${vo.order_status}</div> 고객쪽으로가야함 --%>
            <div>가게이름 :  ${vo.shop_name}</div>
            <div>가게위치 : ${vo.shop_addr1} ${vo.shop_addr2}</div> 
            <div>가게전화번호 : ${vo.shop_phone}</div> 
            <div>회원번호 :  ${vo.mem_idx}</div>
            <div>회원전화번호 :  ${vo.mem_phone}</div>
            <div>배달장소 :${vo.mem_addr1} ${vo.mem_addr2}</div> 
            <div>배달요청사항 :  ${vo.rider_request}</div>
            <div>
                <c:if test="${ vo.delivery_status eq '픽업대기'}">
                    배달상태: ${vo.delivery_status}
                </c:if>    
                <c:if test="${ vo.delivery_status eq '배달중'}">
                <label>배달상태: 배달중...</label>
            </c:if>
            </div>  
    
            <input type="button" value="경로보기" onclick="location.href='../route/route.do'">
            <!-- 원래는 배달예상시간 버튼 누르고 나서 픽업완료가 뜸(이전기수)
            여기서는 가게가 조리 완료를 누르면 픽업완료가 뜰 수 있도록 하기 -->
            <c:if test="${ vo.order_status eq '픽업대기'}">
                <input type="button" value="픽업완료" onclick="delivery_pickup('${vo.order_idx}','${vo.shop_idx}','${ vo.mem_idx }')">
            </c:if>
            
            <!-- 픽업완료 버튼을 누르면
            픽업 완료 버튼이 배달완료 버튼으로 바뀌게 하기
            픽업이 완료되었다는 정보가 가게,고객에게 전달됨 -->
            <c:if test="${ vo.delivery_status eq '배달중'}">
            <input type="button" value="배달완료" onclick="delivery_complete('${vo.order_idx}','${vo.shop_idx}','${ vo.mem_idx }')">
            <!-- 배달이 완료되었다는 정보가 가게,고객에게 전달됨 -->
         </c:if>
         <hr>
        </c:forEach>
    </c:otherwise>
</c:choose>
</div><!--div content-items-->


</body>
</html>