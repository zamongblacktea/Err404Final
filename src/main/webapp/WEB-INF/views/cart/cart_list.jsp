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

    <style>
        #box{
            width: 1000px;
            margin:auto;
            margin-top: 30px;
        }

        #title{
            text-align: center;
            font-size: 28px;
            font-weight: bold;
            color: rgb(51,122,183);
            text-shadow: 1px 1px 1px black;
            margin-bottom: 80px;
        }

        .my-menu{

            font-size: 14px;
            font-weight: bold;
           
        }

        img{
            width:100px;
            height: 80px;
        }

        td{
            vertical-align: middle !important;
        }

        label{
            display: inline-block;
            width:50px;
            text-align: right;
        }

    </style>

</head>

<body>
    <div id="box">

         <!-- header : 타이틀 + 메뉴 -->
         <%@ include file="../cart/header.jsp" %> 
        
         
         <!-- 상품정보 출력 -->
         <table class="table" border="bordered"> 
             <tr class="success">
                <th>일련번호</th>
                <th>이미지</th>
                <th>상품명</th>
                <th>수량</th>
                <th>단가/할인가</th>
                <th>금액</th>
             </tr>

             <!-- 장바구니 목록이 없는경우 -->
             <c:if test="${ empty list }">
                <tr>
                    <td colspan="4" align="center">
                        <font color="red">등록된 상품이 없습니다</font>
                    </td>
                </tr>
             </c:if> 

             <!-- 상품목록 -->
             <!-- for(cartVo cart : list)  -->
             <c:forEach var="cart" items="${ list }">
                 <tr>
                    <td><img src="../images/${ cart.prod_image_s }"></td>
                    <td>
                        <a href="view.do?prod_idx=${ cart.prod_idx }&cate_idx=${ (empty  param.cate_idx) ? 1 : param.cate_idx }">${ cart.prod_name }</a>
                    </td>
                    <td>${ cart.cart_cnt }</td>
                    <td>
                        <label>정  가:</label> <fmt:formatNumber value="${cart.prod_price }"     type="currency" /><br>
                        <label>할인가:</label> <fmt:formatNumber value="${cart.prod_saleprice }" type="currency" />
                        (<font color="red">${ cart.getDcRate() }% DC</font>)
                    </td>
                    <td>
                        <fmt:formatNumber value="${ cart.amount }"     type="currency" />
                    </td>
                 </tr>   
             </c:forEach> 
             <!-- 총액 출력 -->
              <tr>
                <td colspan="5" align="right">총액 : </td>
                <td><fmt:formatNumber value="${ total_amount }" type="currency" /></td>
              </tr>

         </table> 

    </div>
</body>

</html>