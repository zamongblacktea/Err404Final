$("#btn_order").prop("disabled", false);

// 결제하기
function cart_payment(f) {
  //   let shop_idx = f.shop_idx.value.trim();
  const shop_idx = f.shop_idx.value.trim();
  //   let menu_idx = f.menu_idx.value.trim();
  //   let amount = f.amount.value;
  const amount = f.amount.value;

  console.log("shop_idx:", shop_idx);
  //   console.log("menu_idxs:", menu_idx_str);
  console.log("amount:", amount);

  // f.action = "../order/payment_form.do?shop_idx="+ shop_idx + "&menu_idx=" + menu_idx; // 결제폼 PaymentController
  f.action = "../order/payment_form.do"; // 결제폼 PaymentController
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

  const currentCnt = parseInt(input.value.trim());

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
        document.getElementById(`cnt_${cart_idx}`).value = res_data.cart_cnt;
        document.getElementById(`amount_${cart_idx}`).innerText = "₩" + res_data.amount.toLocaleString();
        document.getElementById(`total_amount`).innerText = "₩" + res_data.total_amount.toLocaleString();
        document.getElementById(`total`).innerText = "₩" + res_data.total.toLocaleString();

        $("input[name='total_amount']").val(parseInt(res_data.total_amount));
        $("input[name='amount']").val(parseInt(res_data.total));
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
        if (res_data.null == "null") {
          $(`#row_${cart_idx}`).remove();
          document.getElementById(`total_amount`).innerText = "₩" + 0;
          document.getElementById(`total`).innerText = "₩" + 0;
          document.getElementById(`dfee`).innerText = "₩" + 0;
          $("#btn_order").prop("disabled", true);
        } else {
          $(`#row_${cart_idx}`).remove();
          document.getElementById(`total_amount`).innerText = "₩" + res_data.total_amount.toLocaleString();
          document.getElementById(`total`).innerText = "₩" + res_data.total.toLocaleString();

          $("input[name='total_amount']").val(parseInt(res_data.total_amount));
          $("input[name='amount']").val(parseInt(res_data.total));
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

  const currentCnt = parseInt(input.value.trim());

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
      document.getElementById(`cnt_${cart_idx}`).value = res_data.cart_cnt;
      document.getElementById(`amount_${cart_idx}`).innerText = "₩" + res_data.amount.toLocaleString();
      document.getElementById(`total_amount`).innerText = "₩" + res_data.total_amount.toLocaleString();
      document.getElementById(`total`).innerText = "₩" + res_data.total.toLocaleString();

      $("input[name='total_amount']").val(parseInt(res_data.total_amount));
      $("input[name='amount']").val(parseInt(res_data.total));
    },
    error: function (err) {
      console.error(err);
      alert("수량 변경 오류");
    },
  });
}
