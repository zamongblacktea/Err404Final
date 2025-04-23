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
                    #box {
                        width: 1000px;
                        margin: auto;
                        margin-top: 30px;
                    }

                    #title {
                        text-align: center;
                        font-size: 28px;
                        font-weight: bold;
                        color: rgb(51, 122, 183);
                        text-shadow: 1px 1px 1px black;
                        margin-bottom: 80px;
                    }

                    .my-menu {

                        font-size: 14px;
                        font-weight: bold;

                    }

                    img {
                        width: 100px;
                        height: 80px;
                    }

                    th {
                        text-align: center !important;
                    }

                    td {
                        vertical-align: middle !important;
                        text-align: center;
                    }

                    label {
                        display: inline-block;
                        width: 50px;
                        text-align: right;
                    }

                    .currency {
                        text-align: right;
                        padding-right: 10px;
                    }

                    .content {
                        text-align: left;
                        padding-left: 10px;
                    }
                </style>

                <script>
                    const regular_number = /^[0-9]{1,5}$/;
                    function modify_cart(cart_idx) {
                        // let cart_cnt = document.getElementById("cnt_" + cart_idx).value;
                        // let cart_cnt = document.querySelector("cnt_" + cart_idx).value;
                        let cart_cnt = $("#cnt_" + cart_idx).val();
                        if (regular_number.test(cart_cnt) == false) {
                            alert("1~5자리의 숫자만 입력하세요");
                            $("#cnt_" + cart_idx).val("");
                            $("#cnt_" + cart_idx).focus();
                            return;
                        }

                        // location.href = "modify.do?cart_idx=" + cart_idx + "&cart_cnt=" + cart_cnt + "&mem_idx=${user.mem_idx}";

                        // backtic : 주의) JSP내에서 String Template사용시 자바스크립트 변수 표현 \${변수명} (앞에 \ 붙인다)
                        location.href = `modify.do?cart_idx=\${cart_idx}&cart_cnt=\${cart_cnt}&mem_idx=${user.mem_idx}`;

                    }
                </script>

                <!-- Check Box 처리 -->
                <script>
                    $(document).ready(function () {
                        // 전체가 눌리면
                        $("#checkAll").click(function () {
                            // 현재 체크 상태 구하기
                            let bChecked = $(this).prop("checked");

                            // 아래쪽 체크박스에 적용
                            $("input[name='cart_idx']").prop("checked", bChecked);
                        });

                        // 각각의 체크박스가 클릭되면
                        $("input[name='cart_idx']").click(function () {

                            // 전체갯수
                            let total_count = $("input[name='cart_idx']").length;
                            // 체크된 상태의 갯수
                            let check_count = $("input[name='cart_idx']:checked").length;

                            // alert(total_count + "중에 체크된 갯수는" + check_count + "개");

                            // 전체 체크 
                            $("#checkAll").prop("checked", (total_count == check_count));
                        });
                    });

                    // 삭제하기
                    function cart_delete(f) {
                        let checked_count = $("input[name='cart_idx']:checked").length;
                        if (checked_count == 0) {
                            alert("장바구니에서 삭제할 상품을 선택하세요");
                            return;
                        }

                        // 삭제확인
                        if (confirm("정말 삭제하시겠습니까?") == false) return;

                        f.method = "POST";
                        f.action = "delete.do";
                        f.submit();
                    }

                    // 결제하기
                    function cart_payment(f) {
                        let shop_idx = f.shop_idx.value;
                        let menu_idx = f.menu_idx.value;
                        let checked_count = $("input[name='cart_idx']:checked").length;
                        if (checked_count == 0) {
                            alert("장바구니에서 결제할 상품을 선택하세요");
                            return;
                        }

                        //f.method = "POST";
                        f.action = "../order/payment_form.do?shop_idx="+ shop_idx + "&menu_idx=" + menu_idx; // 결제폼 PaymentController
                        f.submit();
                    }


                </script>

            </head>

            <body>
                <div id="box">


                        <br>
                        <h4 style="text-align: center;">::::장바구니 목록::::</h4>

                        <form class="form-inline">
                            <input type="hidden" name="mem_idx" value="${user.mem_idx}">
                            <!-- check all -->
                            <div>
                                <input type="checkbox" class="form-control" id="checkAll"><label
                                    for="checkAll">전체</label>
                            </div>
                            <!-- 장바구니정보 출력 -->
                            <table class="table table-bordered">
                                <tr class="success">
                                    <th>일련번호</th>
                                    <!-- <th>이미지</th> -->
                                    <th>상품명</th>
                                    <th>수량</th>
                                    <th>단가</th>
                                    <th>금액</th>
                                    <th>비고</th>
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
                                    <tr>
                                        <input type="hidden" value="${ param.shop_idx }" name="shop_idx">
                                        <input type="hidden" value="${ cart.menu_idx }" name="menu_idx">
                                        <td><input type="checkbox" name="cart_idx"
                                                value="${cart.cart_idx}">&nbsp;&nbsp;${cart.cart_idx}</td>
                                      
                                        <td class="content">
                                            ${cart.menu_name}
                                        </td>
                                        <td><input size="5" id="cnt_${cart.cart_idx}" value="${cart.cart_cnt}"
                                                style="text-align: center;">
                                        </td>
                                        <td>
                                            <fmt:formatNumber value="${cart.menu_price * cart.cart_cnt}" type="currency" />
                                            <input type="hidden" name="total_price" value="{cart.menu_price * cart.cart_cnt}">
                                        </td>
                                        <td><input class="btn btn-info" type="button" value="수정"
                                                onclick="modify_cart('${cart.cart_idx}');"></td>
                                    </tr>
                                </c:forEach>

                                <!-- 총액 출력 -->
                                <tr>
                                    <td colspan="5" style="text-align: right;">총액</td>
                                    <td class="currency" colspan="2">
                                        <fmt:formatNumber value="${total_amount }" type="currency" />
                                        <input type="hidden" name="amount" value="${total_amount}">
                                    </td>
                                </tr>

                            </table>

                            <!-- 결제 및 삭제 버튼 -->
                            <div class="row">
                                <div class="col-sm-6">
                                    <input class="btn btn-danger" type="button" value="삭제"
                                        onclick="cart_delete(this.form);">
                                </div>
                                <div class="col-sm-6" style="text-align: right;">
                                    <input class="btn btn-primary" type="button" value="결제"
                                        onclick="cart_payment(this.form);">

                                </div>
                            </div>
                        </form>

                </div>
            </body>

            </html>