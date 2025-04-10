<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
    <!-- bootstrap 사용설정 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  </head>
  <body>
    메뉴목록<br />

    <c:forEach var="list" items="${list}">
      <div>
        <img src="${pageContext.request.contextPath}/images/${list.menu_img}" alt="메뉴사진" style="width: 80px; height: 80px" /><br /> 메뉴이름 : ${list.menu_name}<br />
        메뉴설명: ${list.menu_explain}<br /> 메뉴가격 : ${list.menu_price}<br />
        상태 : ${list.menu_status}<br>
        <input type="button" class="btn btn-info" value="상세보기" onclick="" />
        <input type="button" class="btn btn-info" value="수정" onclick="location.href='menu_modify_form.do'" />
        <input type="button" class="btn btn-info" value="삭제" />
      </div>
    </c:forEach>
  </body>
</html>
