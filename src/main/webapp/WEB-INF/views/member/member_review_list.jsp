<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:forEach var="vo" items="${ list }">
가게 이름 : ${vo.shop_name} <br>
주문 메뉴 : ${vo.menu_name} <br>
주문일: ${ vo.pay_regdate } <br>
상태 : ${ vo.delivery_status } <br>


<a href="review_form.do?mem_idx=${vo.mem_idx}&shop_idx=${vo.shop_idx}&menu_idx=${vo.menu_idx}&order_idx=${vo.order_idx}&delivery_idx=${vo.delivery_idx}">리뷰 쓰기</a><br>

</c:forEach>
</body>
</html>