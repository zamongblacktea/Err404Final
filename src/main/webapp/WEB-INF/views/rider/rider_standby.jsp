
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>주문대기 페이지</title>
  </head>

  <body>
    <!-- 아래 내용을 하나의 패널이나 네모안에 넣고 오른쪽에 경로보기 버튼누르기 -->
    <!-- forEach문으로 출력할듯?  여기서 주문대기 할때 거리가 짧은순으로 orderby해서 출력되도록 하기  -->
    <%-- <c:forEach var="order" items="${order}"> --%>
    
    <c:forEach  begin="1" end="3">
      <div>주문번호 :</div>
      <div>가게이름 :</div>
      <div>가게위치 :</div>
      <div>메뉴 :</div>
      <div>메뉴가격 :</div>
      <div>배달장소 :</div>
      <div>배달요청사항 :</div>
    
        <!-- <div>주문번호 : </div> ${order.order_idx}
        <div>가게이름 : </div> ${shop_name}
        <div>가게위치 : </div> ${shop_addr1} ${shop_addr2}
        <div>메뉴 : </div> ${menu_name}
        <div>메뉴가격 : </div> ${menu_price}
        <div>배달장소 :</div> ${mem_caddr} ${mem_caddr}
        <div>배달요청사항 : </div> ${rider_request} -->

        <input  type="button"  value="경로보기"    onclick="location.href='../route/route.do'" />
        <!-- 배차받기를 누르면 배달현황으로 넘어가기 -->
        <input type="button" value="배차받기" />
        <!-- 배차받기 누르면 고객,가게쪽으로 알림뜨드록 -->
         <hr>
      </c:forEach>
  </body>
</html>