// 결제하기
function cart_payment(f) {
  let shop_idx = f.shop_idx.value.trim();
  let menu_idx = f.menu_idx.value.trim();
  f.action = "../order/payment_form.do?shop_idx=" + shop_idx + "&menu_idx=" + menu_idx; // 결제폼 PaymentController
  f.submit();
}

// 수량 감소
function minus(cart_idx) {
  cart_idx = parseInt(cart_idx);
  // 현재 수량 체크
  const input = document.getElementById(`cnt_${cart_idx}`);

  // if(!input){
  //     console.error(`input 요소: cnt_${cart_idx}`);
  //  return;
  // }

  const currentCnt = parseInt(input.innerText.trim());
  // console.log("cart_idx:", cart_idx);

  if (currentCnt > 1) {
    $.ajax({
      url: "../cart/cnt_minus.do",
      type: "POST",
      data: {
        cart_idx: cart_idx,
        cart_cnt: currentCnt,
      },
      success: function (res_data) {
        // console.log("응답확인", res_data);
        // $(`#cnt_${cart_idx}`).val(res_data);
        document.getElementById(`cnt_${cart_idx}`).innerText = res_data.cart_cnt;
        // document.getElementById(`amount_\${cart_idx}`).innerText = "₩" + res_data.amount.toLocaleString();
        document.getElementById(`total_amount`).innerText = "₩" + res_data.total_amount.toLocaleString();
      },
      error: function (err) {
        console.error(err);
        alert("수량 변경 오류");
      },
    });
  } else {
    $.ajax({
      url: "../cart/delete.do",
      type: "POST",
      data: {
        cart_idx: cart_idx,
      },
      success: function (res_data) {
        // $(`#row_${cart_idx}`).remove();
        // document.getElementById(`total_amount`).innerText = "₩" + res_data.total_amount.toLocaleString();
        // 총액 등 갱신
        document.getElementById("total_amount").innerText = "₩" + res_data.total_amount.toLocaleString();

        // cart_list가 비었으면 detail_cart.jsp 다시 불러오기
        if (res_data.is_empty) {
          $("#cart_area").load("../cart/list_view.do");
        } else {
          // 그냥 삭제만 반영 (비어있진 않음)
          $(`#row_${cart_idx}`).remove();
        }
      },
      error: function (err) {
        console.error(err);
        alert("수량 변경 오류");
      },
    });
  }
}

// 수량 증가
function plus(cart_idx) {
  cart_idx = parseInt(cart_idx);
  // 현재 수량 체크
  const input = document.getElementById(`cnt_${cart_idx}`);

  const currentCnt = parseInt(input.innerText.trim());

  $.ajax({
    url: "../cart/cnt_plus.do",
    type: "POST",
    data: {
      cart_idx: cart_idx,
      cart_cnt: currentCnt,
    },
    success: function (res_data) {
      // console.log("응답확인", res_data);
      // $(`#cnt_${cart_idx}`).val(res_data);
      document.getElementById(`cnt_${cart_idx}`).innerText = res_data.cart_cnt;
      // document.getElementById(`amount_\${cart_idx}`).innerText = "₩" + res_data.amount.toLocaleString();
      document.getElementById(`total_amount`).innerText = "₩" + res_data.total_amount.toLocaleString();
    },
    error: function (err) {
      console.error(err);
      alert("수량 변경 오류");
    },
  });
}

// 메뉴 전체 삭제
function delete_all() {
  let mem_idx = $("#mem_idx").val();
  $.ajax({
    url: "../cart/delete_all.do",
    type: "POST",
    data: {
      mem_idx: mem_idx,
    },
    success: function (res_data) {
      $("#cart_area").load("../cart/list_view.do");
    },
    error: function (err) {
      console.error(err);
      alert("수량 변경 오류");
    },
  });
}

function checkShop() {
  // shop_idx가 다르면 주문하기 버튼 disable
  let mem_idx = $("#mem_idx").val();
  let shop_idx = $("#shop_idx").val();

  //가입버튼 비활성화
  $("#btn_order").prop("disabled", true);


  // Ajax통해서 background로 요청
  $.ajax({
    url: "../cart/check_shop_idx.do",
    data: { mem_idx: mem_idx, shop_idx: shop_idx },
    dataType: "json", //결과수신을 JSON으로 받겠다
    success: function (res_data) {
      if (res_data.result == true) {
        //주문버튼 활성화
        $("#btn_order").prop("disabled", false);
      } else {
        $("#btn_order").prop("disabled", true);
      }
    },
    error: function (err) {
      alert(err.responseText);
    },
  });
}
// 메뉴 1개 삭제
function delete_one(cart_idx) {
  $.ajax({
    url: "../cart/delete.do",
    type: "POST",
    data: {
      cart_idx: cart_idx,
    },
    success: function (res_data) {
      // $(`#row_${cart_idx}`).remove();
      // document.getElementById(`total_amount`).innerText = "₩" + res_data.total_amount.toLocaleString();
      // 총액 등 갱신
      document.getElementById("total_amount").innerText = "₩" + res_data.total_amount.toLocaleString();

      // cart_list가 비었으면 detail_cart.jsp 다시 불러오기
      if (res_data.is_empty) {
        $("#cart_area").load("../cart/list_view.do");
      } else {
        // 그냥 삭제만 반영 (비어있진 않음)
        $(`#row_${cart_idx}`).remove();
      }
    },
    error: function (err) {
      console.error(err);
      alert("수량 변경 오류");
    },
  });
}
