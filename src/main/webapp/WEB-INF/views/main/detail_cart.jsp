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

    // 메뉴 전체 삭제
    function delete_all(){
      let mem_idx = $("#mem_idx").val();
      $.ajax({
        url : "../cart/delete_all.do",
        type: "POST",
        data : {
            mem_idx : mem_idx
        },
        success: function(res_data){ 
          $("#cart_area").load("../cart/list_view.do");
        },
        error : function(err){
            console.error(err);
            alert("수량 변경 오류");
        }
    });
    }




    // shop_idx가 다르면 주문하기 버튼 disable
    let mem_idx = $("#mem_idx").val();
    let shop_idx = $("#shop_idx").val();

      //가입버튼 비활성화
      $("#btn_order").prop("disabled", true);

      // Ajax통해서 background로 요청
      $.ajax({
        url: "../cart/check_shop_idx.do", 
        data: { "mem_idx": mem_idx, "shop_idx": shop_idx },
        dataType: "json",            //결과수신을 JSON으로 받겠다		   
        success: function (res_data) {
          if (res_data.result == true) {
            //가입버튼 활성화
            $("#btn_order").prop("disabled", false);

          } else {
            $("#btn_order").prop("disabled", true);
          }
        },
        error: function (err) {
          alert(err.responseText);
        }
      });
    
    </script>
  </head>
  <body>
    <form class="form-inline">
    <div id="cart_area">
    <div>주문표/<span onclick="delete_all();">🗑️</span></div>
      <c:choose>
      <c:when test="${empty cart_list}">
        <div style="text-align: center; margin-top: 65px">
          장바구니가 비어있습니다.
        </div>
      </c:when>

      <c:otherwise>      
      <c:forEach var="cart" items="${cart_list}">
        <input type="hidden" name="shop_idx" id="shop_idx" value="${cart.shop_idx}">
        <input type="hidden" name="menu_idx" id="menu_idx" value="${cart.menu_idx}">
        <input type="hidden" name="mem_idx" id="mem_idx" value="${cart.mem_idx}">
        <li class="cart_li" id="row_${cart.cart_idx}">
          <div id="menu_name">${cart.menu_name}</div>
          <div class="row">
            <div class="col-sm-6 text-left">
              <span onclick="delete_one('${cart.cart_idx}')">❌</span>
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

      <c:if test="${shop.shop_minprice > total_amount}">
        <div>최소주문금액 얼마</div>
      </c:if>
      <div id="total_amount">
        <fmt:formatNumber value="${total_amount }" type="currency" />
        <input type="hidden" name="amount" value="${total_amount}" />
      </div>
    </c:otherwise>
  </c:choose>
      <div><input type="button" class="btn btn-primary" id="btn_order" value="주문하기" onclick="cart_payment(this.form);" disabled="disabled"></div>
</div>
  </form>

  <script>
    // shop_idx가 다르면 주문하기 버튼 disable
    mem_idx = $("#mem_idx").val();
    shop_idx = $("#shop_idx").val();

      //가입버튼 비활성화
      $("#btn_order").prop("disabled", true);

      // Ajax통해서 background로 요청
      $.ajax({
        url: "../cart/check_shop_idx.do", 
        data: { "mem_idx": mem_idx, "shop_idx": shop_idx },
        dataType: "json",            //결과수신을 JSON으로 받겠다		   
        success: function (res_data) {
          if (res_data.result == true) {
            //가입버튼 활성화
            $("#btn_order").prop("disabled", false);

          } else {
            $("#btn_order").prop("disabled", true);
          }
        },
        error: function (err) {
          alert(err.responseText);
        }
      });

    // 메뉴 1개 삭제
    function delete_one(cart_idx){
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

  </script>
  </body>
</html>
