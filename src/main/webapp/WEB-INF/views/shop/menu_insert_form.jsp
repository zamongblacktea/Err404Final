<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>메뉴 등록</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <style>
      .form-container {
        max-width: 600px;
        margin: 0 auto;
        padding: 20px;
      }
      .form-group {
        margin-bottom: 15px;
      }
    </style>

    <script type="text/javascript">
      // 메뉴 금액에 대한 수치범위 : 1~10
      const regular_number = /^[0-9]{1,10}$/;

      function send(f) {
        //입력값 체크
        let shop_idx = f.shop_idx.value.trim();
        let menu_name = f.menu_name.value.trim();
        let menu_price = f.menu_price.value;
        let menu_explain = f.menu_explain.value.trim();
        let photo = f.photo.value.trim();
        let menu_status = f.menu_status.value.trim();

        if (menu_name == "") {
          alert("메뉴명을 입력하세요!");
          f.menu_name.value = "";
          f.menu_name.focus();
          return;
        }

        if (menu_price == "") {
          alert("메뉴가격을 입력하세요!");
          f.menu_price.value = "";
          f.menu_price.focus();
          return;
        }

        if (regular_number.test(menu_price) == false) {
          alert("숫자로 가격을 입력하세요");
          f.menu_price.value = "";
          f.menu_price.focus();
          return;
        }

        if (menu_explain == "") {
          alert("메뉴 설명을 입력하세요!");
          f.menu_explain.value = "";
          f.menu_explain.focus();
          return;
        }

        if (photo == "") {
          alert("메뉴사진을 입력하세요!");
          f.photo.value = "";
          f.photo.focus();
          return;
        }

        f.action = "menu_insert.do"; // MenuInsertAction
        f.submit();
      } //end:send()
    </script>
  </head>
  <body>
    <div class="form-container">
      <h2>메뉴 등록</h2>
      <form id="menuForm" enctype="multipart/form-data">
        <div class="form-group">
          <label for="menu_name">메뉴명</label>
          <input type="text" class="form-control" id="menu_name" name="menu_name" required />
        </div>
        <div class="form-group">
          <label for="menu_explain">메뉴 설명</label>
          <textarea class="form-control" id="menu_explain" name="menu_explain" rows="3" required></textarea>
        </div>
        <div class="form-group">
          <label for="menu_price">가격</label>
          <input type="number" class="form-control" id="menu_price" name="menu_price" required />
        </div>
        <div class="form-group">
          <label for="menu_status">상태</label>
          <select class="form-control" id="menu_status" name="menu_status" required>
            <option value="판매중">판매중</option>
            <option value="품절">품절</option>
          </select>
        </div>
        <div class="form-group">
          <label for="photo">메뉴 사진</label>
          <input type="file" class="form-control" id="photo" name="photo" required />
        </div>
        <button type="button" class="btn btn-primary" onclick="submitForm()">등록</button>
      </form>
    </div>

    <script>
      function submitForm() {
        const formData = new FormData($('#menuForm')[0]);
        const shop_idx = "${sessionScope.shop_idx}";
        
        $.ajax({
          url: 'menu_insert.do',
          type: 'POST',
          data: formData,
          processData: false,
          contentType: false,
          success: function(response) {
            alert('메뉴가 성공적으로 등록되었습니다.');
            loadContent('menu_list.do');
          },
          error: function(xhr, status, error) {
            alert('메뉴 등록 중 오류가 발생했습니다: ' + error);
          }
        });
      }
    </script>
  </body>
</html>
