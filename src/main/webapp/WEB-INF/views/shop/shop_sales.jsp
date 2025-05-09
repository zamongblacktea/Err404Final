<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <!-- bootstrap 3.x 사용설정 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart_list.css">

</head>

<body>
    <div id="box">


        <br>




            <table class="table table-bordered">
                <tr class="success">
                    <th>주문번호</th>
                    <th>주문일자</th>
                    <th>메뉴</th>
                    <th>총액</th>
                </tr>

                <!-- 등록상품이 없는경우 -->

                    <tr>
                        <td colspan="7" align="center">
                            <font color="red">정산 내역이 없습니다</font>
                        </td>
                    </tr>
                            
               


    </div>
    <script src="${pageContext.request.contextPath}/js/cart_list.js"></script>
</body>

</html>