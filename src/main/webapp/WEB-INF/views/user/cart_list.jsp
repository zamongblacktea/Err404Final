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
                    $("#btn_order").prop("disabled", false);

                    // 결제하기
                    function cart_payment(f) {
                        let shop_idx = f.shop_idx.value.trim();
                        let menu_idx = f.menu_idx.value.trim();
                        let amount   = f.amount.value; 

                        f.action = "../order/payment_form.do?shop_idx="+ shop_idx + "&menu_idx=" + menu_idx; // 결제폼 PaymentController
                        f.submit();
                    }

                    // 수량 감소
                    function minus(cart_idx){

                        cart_idx = parseInt(cart_idx);         
                        // 현재 수량 체크
                        const input = document.getElementById(`cnt_\${cart_idx}`);

                        // if(!input){
                        //     console.error(`input 요소: cnt_${cart_idx}`);
                        //  return;
                        // }

                        const currentCnt = parseInt(input.value.trim());

                        if(currentCnt > 1){
                            $.ajax({
                                url : "../cart/cnt_minus.do",
                                type: "POST",
                                data : {
                                    cart_idx : cart_idx,
                                    cart_cnt : currentCnt
                                },
                                success: function(res_data){
                                    // console.log("응답확인", res_data);
                                    // $(`#cnt_${cart_idx}`).val(res_data); 
                                    document.getElementById(`cnt_\${cart_idx}`).value = res_data.cart_cnt; 
                                    document.getElementById(`amount_\${cart_idx}`).innerText = "₩" + res_data.amount.toLocaleString(); 
                                    document.getElementById(`total_amount`).innerText = "₩" + res_data.total_amount.toLocaleString(); 
                                    document.getElementById(`total`).innerText = "₩" + res_data.total.toLocaleString(); 
                                },
                                error : function(err){
                                    console.error(err);
                                    alert("수량 변경 오류");
                                }
                            });
                        }else{
                            $.ajax({
                                url : "../cart/delete.do",
                                type: "POST",
                                data : {
                                    cart_idx : cart_idx
                                },
                                success: function(res_data){
                                    if(res_data.null == "null"){
                                        $(`#row_\${cart_idx}`).remove(); 
                                        document.getElementById(`total_amount`).innerText = "₩" + 0;
                                        document.getElementById(`total`).innerText = "₩" + 0;
                                        document.getElementById(`dfee`).innerText = "₩" + 0;
                                        $("#btn_order").prop("disabled", true);
                                    }else{
                                    $(`#row_\${cart_idx}`).remove(); 
                                    document.getElementById(`total_amount`).innerText = "₩" + res_data.total_amount.toLocaleString();
                                    document.getElementById(`total`).innerText = "₩" + res_data.total.toLocaleString();

                                    }
                                },
                                error : function(err){
                                    console.error(err);
                                    alert("수량 변경 오류");
                                }
                            });
                        }
                    }

                    // 수량 증가
                    function plus(cart_idx){
                        cart_idx = parseInt(cart_idx);         
                        // 현재 수량 체크
                        const input = document.getElementById(`cnt_\${cart_idx}`);

                        const currentCnt = parseInt(input.value.trim());

                        $.ajax({
                                url : "../cart/cnt_plus.do",
                                type: "POST",
                                data : {
                                    cart_idx : cart_idx,
                                    cart_cnt : currentCnt
                                },
                                success: function(res_data){
                                    // console.log("응답확인", res_data);
                                    // $(`#cnt_${cart_idx}`).val(res_data); 
                                    document.getElementById(`cnt_\${cart_idx}`).value = res_data.cart_cnt; 
                                    document.getElementById(`amount_\${cart_idx}`).innerText = "₩" + res_data.amount.toLocaleString(); 
                                    document.getElementById(`total_amount`).innerText = "₩" + res_data.total_amount.toLocaleString();
                                    document.getElementById(`total`).innerText = "₩" + res_data.total.toLocaleString(); 
                                },
                                error : function(err){
                                    console.error(err);
                                    alert("수량 변경 오류");
                                }
                            });
                    }


                </script>

            </head>

            <body>
                <div id="box">


                        <br>
                        <h4 style="text-align: center;">::::장바구니 목록::::</h4>

                        <form class="form-inline" method="POST">
                            <input type="hidden" name="mem_idx" value="${user.mem_idx}">
                            
                             
                            <!-- check all -->
                            <div>
                                <!-- <input type="checkbox" class="form-control" id="checkAll"><label
                                    for="checkAll">전체</label> -->
                            </div>
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
                                    <input type="hidden" name="shop_idx" value="${cart.shop_idx}">
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
                                            <!-- <fmt:formatNumber value="${cart.menu_price * cart.cart_cnt}" type="currency" />
                                            <input type="hidden" name="total_price" value="{cart.menu_price * cart.cart_cnt}"> -->
                                            <fmt:formatNumber value="${cart.amount}" type="currency" />
                                            <input type="hidden" name="total_price" value="${cart.amount}">
                                        </td>
                                    </tr>
                                </c:forEach>

                                <!-- 총액 출력 -->
                                <tr>
                                    <td colspan="3" style="text-align: right;">총액</td>
                                    <td class="currency" colspan="1" id="total_amount">
                                        <fmt:formatNumber value="${total_amount}" type="currency" />
                                        <input type="hidden" name="total_amount" value="${total_amount}">
                                    </td>
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
                                    <td class="currency" colspan="1" id="total">
                                        <fmt:formatNumber value="${total_amount + shop_dfee}" type="currency" />
                                        <input type="hidden" name="amount" value="${total_amount + shop_dfee}">
                                    </td>
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
            </body>

            </html>