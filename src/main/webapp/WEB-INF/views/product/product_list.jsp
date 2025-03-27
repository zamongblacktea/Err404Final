<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <!-- bootstrap 사용설정 -->
                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
                <title>Insert title here</title>
                <style>
                    #box {
                        width: 1000px;
                        margin: auto;
                        margin-top: 30px;
                    }

                    #title {
                        text-align: center;
                        font-size: 28px;
                        font-weight: bold;
                        color: green;
                        text-shadow: 1px 1px 1px black;
                        margin-bottom: 50px;
                    }

                    .my-menu {

                        font-size: 20px;
                        font-weight: bold;

                    }

                    img {
                        width: 100px;
                        height: 80px;
                    }

                    td {
                        vertical-align: middle !important;
                    }

                    label {
                        display: inline-block;
                        width: 50px;
                        text-align: right;
                    }
                </style>
            </head>

            <body>
                <div id="box">
                    <!-- header : 타이틀 + 메뉴 -->
                    <%@ include file="header.jsp" %>


                        <!-- 상품정보 출력 -->
                        <table class="table">
                            <tr class="success">
                                <th width="200">이미지</th>
                                <th width="400">제품명</th>
                                <th width="150">제조회사</th>
                                <th>가격</th>
                            </tr>

                            <!-- 상품이 없는 경우 -->
                            <c:if test="${ empty list }">
                                <tr>
                                    <td colspan="4" align="center">
                                        <font color="red">등록된 상품이 없습니다.</font>
                                    </td>
                                </tr>
                            </c:if>

                            <!-- 상품목록 -->
                            <!-- for(ProductVo product : list)  -->
                            <c:forEach var="product" items="${ list }">
                                <tr>
                                    <td><img src="../images/${ product.prod_image_s }"></td>
                                    <td>
                                        <!-- cate_idx가 empty면 기본값으로 1을 주고 있으면 param의 값을 입력하라는 ? 삼항 연산자식 -->
                                        <a
                                            href="view.do?prod_idx=${ product.prod_idx }&cate_idx=${ empty param.cate_idx ? 1 : param.cate_idx}">${
                                            product.prod_name }</a>
                                    </td>
                                    <td>${ product.prod_company }</td>
                                    <td>
                                        정가:
                                        <fmt:formatNumber value="${product.prod_price }" type="currency" /><br>
                                        할인가:
                                        <fmt:formatNumber value="${product.prod_saleprice }" type="currency" />(<font
                                            color="red">${product.getDcRate()}% DC</font>)<br>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>

                </div>
            </body>

            </html>