<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <title>Document</title>
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
      <link rel="icon" href="${pageContext.request.contextPath}/images/잇띵로고최종.png" type="image/x-icon">

      <!-- SweetAlert2 설정 -->
      <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>
    <style>
      * {
        border: 1px solid black;
        margin: 0;
        padding: 0;
      }

      .header {
        width: 100%;
        height: 300px;
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


      .footer {
        width: 100%;
        height: 150px;
      }
    </style>

    <body>
      <nav class="navbar">
        <%@ include file="navbar.jsp" %>
      </nav>
      <header class="header">
        <%@ include file="header.jsp" %> 헤더
      </header>
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