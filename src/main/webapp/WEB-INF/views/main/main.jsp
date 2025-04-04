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
      height: 160px;
    }

    .footer {
      width: 100%;
      height: 150px;
    }
  </style>

  <body>
    <nav class="navbar">네비바 로그인/로그아웃</nav>
    <header class="header">헤더</header>
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
