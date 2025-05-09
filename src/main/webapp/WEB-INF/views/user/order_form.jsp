<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
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
  </head>
  <body>
    <nav class="navbar">네비바 로그인/로그아웃</nav>
    <header class="header">헤더</header>
    <div class="content">
      <div id="mybox">
        <div>회원정보</div>
        <div>요청사항</div>
        <div>결제방식</div>
        <div>메뉴</div>
      </div>
    </div>

    <footer class="footer">푸터</footer>
  </body>
</html>
