<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>배달완료 페이지</title>
    <!-- 파비콘 -->
    <link rel="icon" href="${pageContext.request.contextPath}/images/잇띵로고최종.png" type="image/x-icon">
    <!-- 웹소캣 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

</head>
<style>
    
   .content-items{
        width: 90%;
        margin: auto;
        padding-top: 3%;
        text-align: left;
        border: 1px solid black;
        background-color: white;
        /* width: 600px; */
        height: auto;
        border-radius: 5px;
        padding-left: 30px;
        /* margin-bottom: 10px; */
        margin: 10px auto;
        display: flex;
        font-size: medium;
      }
    
</style>

<body>

    <!-- <div class="content-items" style="width: 90%;margin: auto; padding-top: 3%;"> -->
    <!-- 배달완료를 누르면 가게/관리자페이지/라이더의 정산페이지에 영향 -->
    <!-- <p> 주문번호 ${order_idx}의 배달이 완료되었습니다 </p> -->
    <!-- 오른쪽에 정산내역확인하기 버튼-->
    <div style="width: 100%; text-align: left; margin-bottom: 20px; margin-left: 0;"></div>
        <c:if test="${empty deliverycomplete_list}">
         현재 배달 완료한 건이 없습니다.
        </c:if>
  

        
        <c:forEach var="vo" items="${deliverycomplete_list}">
            <div class="content-items">
                <div class="table"> 
                
                 <div class="table_text"> 
                    <p style="color: rgb(195, 58, 86);"> 주문번호 ${vo.order_idx}의 배달이 완료되었습니다 </p>
                    배달상태 : ${vo.delivery_status} <br />
                    가게이름 : ${vo.shop_name}<br />
                    가게위치 : ${vo.shop_addr1} ${vo.shop_addr2} <br />
                    회원번호 : ${vo.mem_idx}<br />
                    배달장소 : ${vo.mem_addr1} ${vo.mem_addr2}<br />
                    배달날짜 : ${vo.pay_regdate}<br />
                    배 달 료 : ${vo.delivery_fee}<br />
                 </div><!--div table_text-->
                </div> <!--div table-->

            </div> <!--div content-items-->
        </c:forEach>


</body>
</html>