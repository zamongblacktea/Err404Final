<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <style>
      .cart_list > .row{
        width: 247px;
      }

      .cart {
      display: inline-block;
      width: 300px;
    }

    span{
      border: none;
    }

    .cart_li{
      list-style: none;
    }
    </style>

    <script>
      // 결제하기
      function cart_payment(f) {
                        let shop_idx = f.shop_idx.value.trim();
                        let menu_idx = f.menu_idx.value.trim();
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

                        const currentCnt = parseInt(input.innerText.trim());
                        console.log("cart_idx:", cart_idx);

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
                                    document.getElementById(`cnt_\${cart_idx}`).innerText = res_data.cart_cnt; 
                                    // document.getElementById(`amount_\${cart_idx}`).innerText = "₩" + res_data.amount.toLocaleString(); 
                                    document.getElementById(`total_amount`).innerText = "₩" + res_data.total_amount.toLocaleString(); 
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
                                    $(`#row_\${cart_idx}`).remove(); 
                                    document.getElementById(`total_amount`).innerText = "₩" + res_data.total_amount.toLocaleString();
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

                        const currentCnt = parseInt(input.innerText.trim());

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
                                    document.getElementById(`cnt_\${cart_idx}`).innerText = res_data.cart_cnt; 
                                    // document.getElementById(`amount_\${cart_idx}`).innerText = "₩" + res_data.amount.toLocaleString(); 
                                    document.getElementById(`total_amount`).innerText = "₩" + res_data.total_amount.toLocaleString(); 
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
    <form class="form-inline">
    <div>주문표/취소</div>
    <div>
      <c:forEach var="cart" items="${cart_list}">
        <input type="hidden" name="shop_idx" value="${cart.shop_idx}">
        <input type="hidden" name="menu_idx" value="${cart.menu_idx}">
        <li class="cart_li" id="row_${cart.cart_idx}">
          <div id="menu_name">${cart.menu_name}</div>
          <div class="row">
            <div class="col-sm-6 text-left">
              <span>❌</span>
              <span><fmt:formatNumber value="${cart.menu_price}" pattern="#,#00" />원</span>
            </div>
            <div class="col-sm-6 text-right">
              <span onclick="minus('${cart.cart_idx}');" style="cursor: pointer">➖</span>
              <span id="cnt_${cart.cart_idx}" style="text-align: center">${cart.cart_cnt}</span>
              <span onclick="plus('${cart.cart_idx}');" style="cursor: pointer">➕</span>
            </div>
          </div>
        </li>
      </c:forEach>
    </div>
    <c:if test="${shop.shop_minprice > total_amount}">
      <div>최소주문금액 얼마</div>
    </c:if>
    <div id="total_amount">
      <fmt:formatNumber value="${total_amount }" type="currency" />
      <input type="hidden" name="amount" value="${total_amount}" />
    </div>
    <div>주문하기 버튼</div>
  </form>
  </body>
</html>
