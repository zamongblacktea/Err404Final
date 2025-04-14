<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>배달완료 페이지</title>
</head>
<body>
    
    <!-- 배달완료를 누르면 가게/관리자페이지/라이더의 정산페이지에 영향 -->
   <p> 주문번호 ${order_idx}의 배달이 완료되었습니다 </p>
    <!-- 오른쪽에 정산내역확인하기 버튼-->
    <hr>
    <c:forEach var="vo" items="${standby_list}"> 
    <div>주문번호 : ${vo.order_idx}</div>
    <div>배달상태 : ${vo.delivery_status}</div> 
    <div>가게이름 : ${vo.shop_name}</div>
    <div>가게위치 : ${vo.shop_addr1} ${vo.shop_addr2} </div> 
    <div>회원번호 : ${vo.mem_idx}</div>
    <div>배달장소 : ${vo.mem_caddr} ${vo.mem_cdaddr}</div> 
    <div>배달날짜 : ${vo.pay_date}</div>
    <div>배 달 료 : ${vo.delivery_fee}</div> 
    <input type="button" value="당일정산내역확인" onclick="location.href='todayfee.do'"; />
    </c:forEach>
     

</body>
</html>