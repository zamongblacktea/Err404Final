<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>메뉴 목록</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <style>
      .menu-item {
        border: 1px solid #ddd;
        padding: 15px;
        margin-bottom: 15px;
        border-radius: 8px;
        width: 600px;
        margin: 20px auto;
        padding-left: 50px;
      }
      .menu-item img {
        width: 130px;
        height: 130px;
        object-fit: cover;
      }
    </style>
  </head>
  <body>
    <c:forEach var="list" items="${list}">
      <div class="menu-item">
        <img src="${pageContext.request.contextPath}/images/${list.menu_img}" alt="메뉴사진" />
        <div>
          <h3>${list.menu_name}</h3>
          <p>${list.menu_explain}</p>
          <p>가격: ${list.menu_price}원</p>
          <p>상태: ${list.menu_status}</p>
          <button class="btn btn-info" onclick='loadModifyForm("${list.menu_idx}")'>수정</button>
          <button class="btn btn-danger" onclick='deleteMenu("${list.menu_idx}")'>삭제</button>
        </div>
      </div>
    </c:forEach>

    <script>
      function loadModifyForm(menu_idx) {
        $.ajax({
          url: "menu_modify_form.do",
          type: "GET",
          data: { menu_idx: menu_idx },
          success: function (response) {
            $("#disp").html(response);
          },
          error: function (xhr, status, error) {
            alert("수정 폼을 불러오는 중 오류가 발생했습니다: " + error);
          },
        });
      }

      function deleteMenu(menu_idx) {
        if (confirm("정말로 이 메뉴를 삭제하시겠습니까?")) {
          $.ajax({
            url: "menu_delete.do",
            type: "POST",
            data: { menu_idx: menu_idx },
            success: function () {
              alert("메뉴가 삭제되었습니다.");
              loadContent("menu_list.do");
            },
            error: function (xhr, status, error) {
              alert("메뉴 삭제 중 오류가 발생했습니다: " + error);
            },
          });
        }
      }
    </script>
  </body>
</html>
