<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>정산내역 확인페이지</title>
    <!-- 파비콘 -->
    <link rel="icon" href="${pageContext.request.contextPath}/images/잇띵로고최종.png" type="image/x-icon">
    <!-- 웹소캣 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <!-- Bootstrap 3.x -->
    <link
      rel="stylesheet"
      href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

   
   <style>
      body {
        background-color: #f8f9fa;
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
      }

      .header h2 {
        text-align: center;
        font-size: 18px;
        font-weight: bold;
        margin-bottom: 30px;
      }

      .form-inline {
        display: flex;
        justify-content: space-between;
        margin-bottom: 20px;
      }

      .form-group {
        margin-bottom: 15px;
      }

      .form-control {
        border-radius: 5px;
        height: 45px;
        width: 200px;
      }

      .button_style {
        background-color: #e4a159;
        color: white;
        border: none;
        border-radius: 5px;
        padding: 10px 15px;
        cursor: pointer;
        transition: background-color 0.3s ease;
      }

      .button_style:hover {
        background-color: #e4a159;
      }

      .table {
        margin-top: 20px;
      }

      h3 {
        margin-top: 20px;
        text-align: center;
      }

      .pagination {
        text-align: center;
        margin-top: 20px;
      }

      /* Center pagination */
      .pagination {
        display: flex;
        justify-content: center;
      }
      .delivery-content{
        margin-left: 20px;

      }
    </style>
</head>
<body>
    <div class="header">

        <h2 style="margin-top: 30px; font-size: x-large; color: #0b6019;" >배달 완료 목록</h2>
        
        <form action="deliveryfeefilter.do" method="get" class="form-inline">
          <input type="hidden" name="rider_idx" value="${param.rider_idx}" />
         
          <!-- html5에서 지원하는 달력 태그 형식 -->
          <div class="form-group">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <label for="startDate">시작 날짜:</label>
            <input
              type="date"
              id="startDate"
              name="startDate"
              value="${param.startDate}"
              class="form-control"
            />
          
  
          
            <label for="endDate">종료 날짜:</label>
            <input
              type="date"
              id="endDate"
              name="endDate"
              value="${param.endDate}"
              class="form-control"
            />
          &nbsp;&nbsp;
  
          <button type="submit" class="button_style" style="background-color: #ed796e !important;">  필터 적용</button>
        </div>
          <input
          style="margin-right: 50px;"
            type="button"
            class="button_style"
            id="btn_popup_update"
            value="마이페이지"
            onclick="location.href ='../member/modify_form_rider.do?rider_idx=${user.rider_idx}'"
          />
        
        </form>

    </div> <!--div header-->
    <div class="content">
    
      <div id="delivery-content" style="margin-left: 50px !important; margin-right: 50px !important;">
      <table id="delivery-table" class="table table-striped">
        <thead>
          <tr>
            <th>가게 이름</th>
            <th>주문 번호</th> 
            <th>주문 날짜</th>
            <th>배달 주소</th>
            <th>총 거 리</th>
            <th>배 달 료</th>
          </tr>
        </thead>
        <tbody>
        

          <c:forEach var="vo" items="${riderdelivery_list}">
              <tr>
              <td>${vo.shop_name}</td>
              <td>${vo.order_idx}</td> 
              <td>${vo.pay_regdate}</td>
              <td>${vo.mem_addr1}, ${vo.mem_addr2}</td>
              <td>${vo.totalDistance}m</td>
              <td>${vo.delivery_fee} 원</td>
            </tr>  
          </c:forEach>

          <tr>
            <td colspan="6" style="text-align: right; color: #00126d; font-weight: bold; font-size: large;">
                <c:if test="${ empty param.startDate }">
                   전체 배달내역                   
                </c:if>
                <c:if test="${ not empty param.startDate }">
                   날짜 조회별                  
                </c:if>
                총수입 :   <fmt:formatNumber value="${ totalDeliveryFee }" />(원)  
             </td>
          </tr>
        </tbody>
      </table>
    </div> <!--div deliver-content-->
  </div> <!--content-->
    
</body>
</html>