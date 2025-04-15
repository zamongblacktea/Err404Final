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
        width: 800px;
        margin: 20px auto;
      }
      .menu-item img {
        width: 100px;
        height: 100px;
        object-fit: cover;
      }
    </style>
  </head>
  <body>
    <h2>메뉴 목록</h2>
    <c:forEach var="list" items="${list}">
      <div class="menu-item">
        <img src="${pageContext.request.contextPath}/images/${list.menu_img}" alt="메뉴사진" />
        <div>
          <h3>${list.menu_name}</h3>
          <p>${list.menu_explain}</p>
          <p>가격: ${list.menu_price}원</p>
          <p>상태: ${list.menu_status}</p>
          <!-- <button class="btn btn-info" onclick="location.href='menu_modify_form.do?shop_idx=${list.shop_idx}&menu_idx=${list.menu_idx}'">수정</button> -->
          <button class="btn btn-info" onclick="location.href='main.do'">수정</button>
          <button class="btn btn-danger">삭제</button>
        </div>
      </div>
    </c:forEach>
  </body>
</html>
