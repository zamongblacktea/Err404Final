<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>메뉴 수정</title>

    <!-- bootstrap 사용설정 -->
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
        let menu_idx = f.menu_idx.value.trim();
        let menu_name = f.menu_name.value.trim();
        let menu_price = f.menu_price.value;
        let menu_explain = f.menu_explain.value.trim();
        // let photo = f.photo.value.trim();
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

        // 체크박스 상태를 숨겨진 input에 반영
        const isSoldOut = document.getElementById("menu_soldout").checked;
        document.getElementById("menu_status").value = isSoldOut ? "품절" : "판매";

        f.action = "menu_modify.do"; // MenuModifyAction
        f.submit();
      } //end:send()
    </script>

    <!-- 이미지 업로드용 -->
    <script>
      function photo_update() {
        $("#ajaxFile").click();
      }

      function ajaxFileChange() {
        //파일 선택이 취소되면
        if ($("#ajaxFile")[0].files[0] == undefined) return;

        // Ajax를 이용해서 파일 업로드
        const form = $("#ajaxForm")[0];
        const formData = new FormData(form);
        // 전송 해야할 parameter 세팅
        formData.append("menu_idx", "${vo.menu_idx}");
        formData.append("photo", $("#ajaxFile")[0].files[0]);

        // Ajax 전송
        $.ajax({
          url: "menu_photo_upload.do",
          type: "POST",
          data: formData,
          processData: false,
          contentType: false,
          dataType: "json",
          success: function (res_data) {
            $("#my_img").attr("src", "${pageContext.request.contextPath}/images/" + res_data.menu_img);
            $("#menu_img").val(res_data.menu_img);
          },
          error: function (err) {
            alert(err.responseText);
            console.log(err);
          },
        });
      }

      function submitModifyForm() {
        const formData = new FormData($('#menuModifyForm')[0]);
        
        $.ajax({
          url: 'menu_modify.do',
          type: 'POST',
          data: formData,
          processData: false,
          contentType: false,
          success: function(response) {
            if (response.success) {
              alert('메뉴가 성공적으로 수정되었습니다.');
              loadContent('menu_list.do');
            } else {
              alert(response.message);
            }
          },
          error: function(xhr, status, error) {
            alert('메뉴 수정 중 오류가 발생했습니다: ' + error);
          }
        });
      }
    </script>
  </head>
  <body>
    <!-- 이미지 선택/폼 -->
    <form method="POST" enctype="multipart/form-data" id="ajaxForm" style="display: none">
      <input type="file" id="ajaxFile" onchange="ajaxFileChange();" />
    </form>

    <div style="text-align: center; padding: 10px">
      <img id="my_img" src="${pageContext.request.contextPath}/images/${vo.menu_img}" style="width: 100px; height: 100px" /><br /><br />
      <input class="btn btn-info" type="button" value="이미지 수정" onclick="photo_update();" />
    </div>

    <div class="form-container">
      <h2>메뉴 수정</h2>
      <form id="menuModifyForm" enctype="multipart/form-data">
        <input type="hidden" name="menu_idx" value="${vo.menu_idx}" />
        <div class="form-group">
          <label for="menu_name">메뉴명</label>
          <input type="text" class="form-control" id="menu_name" name="menu_name" value="${vo.menu_name}" required />
        </div>
        <div class="form-group">
          <label for="menu_explain">메뉴 설명</label>
          <textarea class="form-control" id="menu_explain" name="menu_explain" rows="3" required>${vo.menu_explain}</textarea>
        </div>
        <div class="form-group">
          <label for="menu_price">가격</label>
          <input type="number" class="form-control" id="menu_price" name="menu_price" value="${vo.menu_price}" required />
        </div>
        <div class="form-group">
          <label for="menu_status">상태</label>
          <select class="form-control" id="menu_status" name="menu_status" required>
            <option value="판매중" ${vo.menu_status == '판매중' ? 'selected' : ''}>판매중</option>
            <option value="품절" ${vo.menu_status == '품절' ? 'selected' : ''}>품절</option>
          </select>
        </div>
        <button type="button" class="btn btn-primary" onclick="submitModifyForm()">수정</button>
        <button type="button" class="btn btn-secondary" onclick="loadContent('menu_list.do')">취소</button>
      </form>
    </div>

    <script>
      
    </script>
  </body>
</html>
