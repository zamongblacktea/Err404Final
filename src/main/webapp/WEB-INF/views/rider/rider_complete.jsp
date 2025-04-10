<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <div>주문번호 : </div> ${order_idx}
    <div>배달상태 : </div> ${delevery_status}
    <div>가게이름 : </div> ${shop_name}
    <div>가게위치 : </div> ${shop_addr1} ${shop_addr2}
    <div>회원번호 : </div> ${mem_idx}
    <div>배달장소 :</div> ${mem_caddr} ${mem_caddr}
    <div>배달날짜 :</div> ${pay_date}
    <div>배 달 료 :</div> ${delevery_fee}
    <input type="button" value="정산내역확인" />
    
     

</body>
</html>