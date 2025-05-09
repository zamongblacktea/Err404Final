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
        <!-- <h4 style="text-align: center;">::::장바구니 목록::::</h4> -->


            <!-- 장바구니정보 출력 -->
            <table class="table table-bordered">
                <tr class="success">
                    <!-- <th>일련번호</th> -->
                    <!-- <th>이미지</th> -->
                    <th>상품명</th>
                    <th>수량</th>
                    <th>단가</th>
                    <th>금액</th>
                </tr>

                <!-- 등록상품이 없는경우 -->

                    <tr>
                        <td colspan="7" align="center">
                            <font color="red">등록된 상품이 없습니다</font>
                        </td>
                    </tr>
                            
               


    </div>
    <script src="${pageContext.request.contextPath}/js/cart_list.js"></script>
</body>

</html>