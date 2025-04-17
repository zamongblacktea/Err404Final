<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>정산내역 확인페이지</title>
    <!-- 파비콘 -->
    <link rel="icon" href="${pageContext.request.contextPath}/images/잇띵로고최종.png" type="image/x-icon">
    <!-- Bootstrap 3.x -->
    <link
      rel="stylesheet"
      href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

</head>
<body>
    <div class="header">
        <h2>배달 완료 목록</h2>
        <form action="list.do" method="get" class="form-inline">
          <input type="hidden" name="rider_idx" value="${param.rider_idx}" />
  
          <!-- html5에서 지원하는 달력 태그 형식 -->
          <div class="form-group">
            <label for="startDate">시작 날짜:</label>
            <input
              type="date"
              id="startDate"
              name="startDate"
              value="${param.startDate}"
              class="form-control"
            />
          </div>
  
          <div class="form-group">
            <label for="endDate">종료 날짜:</label>
            <input
              type="date"
              id="endDate"
              name="endDate"
              value="${param.endDate}"
              class="form-control"
            />
          </div>
  
          <button type="submit" class="button_style">필터 적용</button>
          <input
            type="button"
            class="button_style"
            id="btn_popup_update"
            value="마이페이지"
            onclick="location.href ='../mypage.do'"
          />
        </form>

    </div>
    가게 이름 주문금액 주문 날짜 배달주소 배달료 
    표만들기
    날짜 설정
    전체 정산내역 ->동적쿼리사용
    5개씩 출력 페이징처리

    <table id="delivery-table" class="table table-striped">
        <thead>
          <tr>
            <th>가게 이름</th>
            <th>주문 금액</th>
            <th>주문 날짜</th>
            <th>배달 주소</th>
            <th>배 달 료</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="vo" items="${completedDeliveries}">
            <!-- <tr>
              <td>${vo.shop_name}</td>
              <td>${vo.order_price} 원</td>
              <td>${vo.}</td>
              <td>${vo.addr_line1}, ${vo.addr_line2}</td>
              <td>${vo.commission} 원</td>
            </tr> -->
          </c:forEach>
        </tbody>
      </table>

      <!-- <h3>총 수입: ${총배달금액} 원</h3> -->
    
</body>
</html>