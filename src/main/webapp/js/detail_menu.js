function insert_cart(f, force = false) {
  // 로그인 여부 체크
  if ("${empty user}" == "true") {
    if (confirm("장바구니 등록은 로그인 후 가능합니다.\n 로그인 하시겠습니까?") == false) return;

    //로그인 폼 이동
    location.href = "../member/login_form.do?url=" + encodeURIComponent(location.href);
    return;
  }

  let menu_idx = f.menu_idx.value;
  let mem_idx = f.mem_idx.value;
  let shop_idx = parseInt(f.shop_idx.value);
  let cart_price = f.menu_price.value;
  // let menu_price = f.menu_price.value;

  // Ajax 이용해서 장바구니 등록
  $.ajax({
    url: "../cart/insert.do",
    method: "POST",
    data: {
      mem_idx: mem_idx,
      shop_idx: shop_idx,
      menu_idx: menu_idx,
      cart_price: cart_price,
      cart_cnt: 1,
      force: force ? "true" : "false",
    },
    dataType: "json",
    success: function (res_data) {
      if (res_data.result == "exist") {
        alert("이미 장바구니에 등록되어있습니다");
      }
      if (res_data.result == "fail") {
        alert("장바구니에 등록 실패 하였습니다");
      }

      // if(res_data.result == "deleted"){
      //   if(confirm("같은 가게에서만 주문 가능합니다.\n장바구니를 비우고 새로 담으시겠습니까?")==false) return;
      // }
      if (res_data.result == "deleted") {
        if (confirm("같은 가게에서만 주문 가능합니다.\n장바구니를 비우고 새로 담으시겠습니까?") == true) {
          $.ajax({
            url: "../cart/delete_all.do",
            method: "POST",
            data: {
              mem_idx: mem_idx,
            },
            dataType: "json",
            success: function (res_data) {
              insert_cart(f, "true");
            },
          });
        }
        return;
      }
      $.ajax({
        url: "../cart/list_view.do",
        type: "GET",
        data: { mem_idx: mem_idx, shop_idx: shop_idx },
        success: function (res_data) {
          checkShop();
          $(".cart").html(res_data);
        },
        error: function (err) {
          console.error("장바구니 리로드 오류", err);
        },
      });
      // 성공 했을 때 코드
      //   if (confirm("장바구니에 등록되었습니다\n장바구니 화면으로 이동하시겠습니까?") == false) return;

      // 장바구니 보기로 이동
      //   location.href = "../cart/list.do?mem_idx=${user.mem_idx}&shop_idx=" + shop_idx;
    },
    error: function (err) {
      alert(err.responseText);
    },
  });
}
