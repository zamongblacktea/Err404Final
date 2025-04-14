<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
  </head>
  <style>
    * {
      border: 1px solid black;
      margin: 0;
      padding: 0;
    }

    #mybox {
      margin: 0 auto;
      width: 1150px;
      padding-left: 10px;
    }

    .category {
      border: 1px solid red;
      width: 270px;
      height: 220px;
      display: inline-block;
      margin: 5px auto;
    }

    .navbar {
      width: 100%;
      height: 80px;
    }
    .header {
      width: 100%;
      height: 300px;
    }

    .footer {
      width: 100%;
      height: 150px;
    }
  </style>

  <body>
    <nav class="navbar">    <div class="col-sm-9 col-md-9" style="text-align: right">
     
      <!-- 로그인이 안되었을 경우(session에 user가 없냐?) -->
      <c:if test="${ empty sessionScope.user }">
	      <input class="btn btn-primary"  type="button" value="로그인" 
		            onclick="location.href='login_form.do'">
	  </c:if>  
	  
	  <!-- 로그인이 되어있을 경우(session에 user가 있냐?) -->
      <c:if test="${ not empty sessionScope.user }">
          <b>${ user.mem_name }</b>님 환영합니다
	      <input class="btn btn-primary"  type="button" value="로그아웃" 
		         onclick="location.href='logout.do'">
	  </c:if>   </nav>
    <header class="header">
      <%@ include file="header.jsp" %> 헤더</header>
    <div class="content">
      <div id="mybox">
        <div class="category">카테고리(이미지)</div>
        <div class="category">카테고리(이미지)</div>
        <div class="category">카테고리(이미지)</div>
        <div class="category">카테고리(이미지)</div>
        <div class="category">카테고리(이미지)</div>
        <div class="category">카테고리(이미지)</div>
        <div class="category">카테고리(이미지)</div>
        <div class="category">카테고리(이미지)</div>
        <div class="category">카테고리(이미지)</div>
        <div class="category">카테고리(이미지)</div>
      </div>
    </div>

    <footer class="footer">푸터</footer>
  </body>
</html>
