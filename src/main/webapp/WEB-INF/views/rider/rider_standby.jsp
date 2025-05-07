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
    <style type="text/css">

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

      #routebt{
        background-color: #eede51;
        font-size: medium;
        color: white;
        border: none;
        width: 25%;
        height: 40%;
        border-radius: 5px;
        padding: 10px 15px;
        cursor: pointer;
        transition: background-color 0.3s ease;
        margin-left: 20px;
        margin-bottom: 10px;
        box-sizing: border-box;
       
      }

      #routebt:hover {
        background-color: #81da46;
       
        }

        
      #deliverybt{
        background-color: #d866ec;
        font-size: medium;
        color: white;
        border: none;
        width: 25%;
        height: 25%;
        border-radius: 5px;
        padding: 10px 15px;
        cursor: pointer;
        transition: background-color 0.3s ease;
        margin-right: 20px;
        box-sizing: border-box;
        
      }

      #deliverybt:hover {
        background-color: #921994;
       
        }
       
        .table{
         margin: auto;
        }

        .table_text{
          margin-bottom: 20px;
        
        }

    
    </style>
    
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

    


    </script>

  </head>

  <body>
   
     <!-- <div class="content-items" style="width: 90%;margin: auto; padding-top: 3%;"> -->
     <!-- foreign키로 라이더의 아이디도 받아와야한다. -->

    <!-- 아래 내용을 하나의 패널이나 네모안에 넣고 오른쪽에 경로보기 버튼누르기 -->
    <!-- forEach문으로 출력 여기서 주문대기 할때 거리가 짧은순으로 orderby해서 출력되도록 하기  -->
     <!-- for(DeliveryVo vo : standby_list) -->
     <div style="width: 100%; text-align: left; margin-bottom: 20px; margin-left: 0;">
     <c:if test="${ empty standby_list }">
      현재 배차대기목록이 없습니다.
     </c:if>
    </div>
    
    <c:forEach var="vo" items="${standby_list}">
    <div class="content-items">
     <div class="table"> 
     
      <div class="table_text">
        주문번호 : ${vo.order_idx}<br />
        가게이름 : ${vo.shop_name}<br />
        가게위치 : ${vo.shop_addr1} ${vo.shop_addr2}<br />
        메뉴 : ${vo.menu_name} <br />
        메뉴가격 : ${vo.menu_price}<br />
        배달장소 : ${vo.mem_addr1} ${vo.mem_addr2}<br />
        배달요청사항 : ${vo.rider_request}<br />
      </div><!--div table_text-->
      </div> <!--div table-->

  
           
          <input  id="routebt" type="button"  value="경로보기"    onclick="location.href='../route/route.do?order_idx=${vo.order_idx}&rider_idx=${user.rider_idx}'" />
          <!-- 배차받기를 누르면 배달현황으로 넘어가기 -->
          &nbsp;&nbsp;
            
          <input id="deliverybt" type="button" value="배차받기" onclick="rider_accept('${ vo.order_idx }','${ user.rider_idx}');" />
          <!-- 배차받기 누르면 고객,가게쪽으로 알림뜨드록 -->
             
       
      
    </div><!--div content-items-->
  </c:forEach>
  </body>
</html>