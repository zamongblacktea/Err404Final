<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <style>
      * {
        margin: 0;
        padding: 0;
        border: 1px solid black;
      }
      nav {
        height: 80px;
      }
      header {
        height: 100px;
      }

      .list {
        width: 500px;
      }
    </style>
  </head>
  <body>
    <nav>네비게이션바</nav>
    <header>헤더</header>
    <div class="category">가게 카테고리</div>
    <div id="main">
      <div class="row list">
        <div class="col-sm-6">
          <div class="shop-list">가게</div>
        </div>
      </div>
    </div>
    <footer>풋터</footer>
  </body>
</html>
