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
        <h4 style="text-align: center;">::::장바구니 목록::::</h4>

        <form class="form-inline" method="POST">
            <input type="hidden" name="mem_idx" value="${user.mem_idx}">
            <input type="hidden" name="shop_idx" value="${shop_idx}">
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
                <c:if test="${ empty cart_list }">
                    <tr>
                        <td colspan="7" align="center">
                            <font color="red">등록된 상품이 없습니다</font>
                        </td>
                    </tr>
                </c:if>                               
                <!-- 장바구니목록 -->
                <!-- for(CartVo cart : list)  -->
                <c:forEach var="cart" items="${ cart_list }">  
                                                
                    <input type="hidden" name="menu_idx" value="${cart.menu_idx}">
                    <tr id="row_${cart.cart_idx}">
                        <!-- <td><input type="checkbox" name="cart_idx"
                                value="${cart.cart_idx}">&nbsp;&nbsp;${cart.cart_idx}</td> -->
                        
                        <td class="content">
                            ${cart.menu_name}
                        </td>
                        <td>
                            <span onclick="minus('${cart.cart_idx}');" style="cursor: pointer;">➖</span>
                            <input size="5" id="cnt_${cart.cart_idx}" value="${cart.cart_cnt}" style="text-align: center;">
                            <span onclick="plus('${cart.cart_idx}');" style="cursor: pointer;">➕</span>
                        </td>
                        <td><fmt:formatNumber value="${cart.menu_price}" type="currency" /></td>
                        <td id="amount_${cart.cart_idx}">
                            <fmt:formatNumber value="${cart.amount}" type="currency" />
                        </td>
                        <input type="hidden" name="total_price" value="${cart.amount}">
                    </tr>
                </c:forEach>

                <!-- 총액 출력 -->
                <tr>
                    <td colspan="3" style="text-align: right;">총액</td>
                    <td class="currency" colspan="1" id="total_amount">
                        <fmt:formatNumber value="${total_amount}" type="currency" />
                    </td>
                    <input type="hidden" name="total_amount" value="${total_amount}">
                </tr>

                <!-- 배달비 출력 -->
                <tr>
                    <td colspan="3" style="text-align: right;">배달비</td>
                    <td class="currency" colspan="1" id="dfee">
                        <fmt:formatNumber value="${shop_dfee }" type="currency" />
                        <input type="hidden" name="dfee" value="${shop_dfee}">
                    </td>
                </tr>

                <!-- 총액 + 배달비 출력 -->
                <tr>
                    <td colspan="3" style="text-align: right;">결제할 금액</td>
                    <td class="currency" colspan="1" class="total" id="total">
                        <fmt:formatNumber value="${total_amount + shop_dfee}" type="currency" />
                    </td>
                    <input type="hidden" name="amount" class="total" value="${total_amount + shop_dfee}">
                </tr>


            </table>

            <!-- 결제 및 삭제 버튼 -->
            <div class="row">
                <div class="col-sm-12" style="text-align: right;">
                    <input class="btn btn-primary" type="button" id="btn_order" value="결제"
                        onclick="cart_payment(this.form);">

                </div>
            </div>
        </form>

    </div>
    <script src="${pageContext.request.contextPath}/js/cart_list.js"></script>
</body>

</html>