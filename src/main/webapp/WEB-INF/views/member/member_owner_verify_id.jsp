<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!DOCTYPE html>
    <html lang="ko">

    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>사업자 아이디/비밀번호 찾기</title>
      <!-- bootstrap 사용설정 -->
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
      <link rel="icon" href="${pageContext.request.contextPath}/images/잇띵로고최종.png" type="image/x-icon">
      <link rel="icon" href="${pageContext.request.contextPath}/images/잇띵로고최종.png" type="image/x-icon">
      <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
      <style>
        body {
          font-family: 'Noto Sans KR', sans-serif;
          background-color: #fff;
          margin: 0;
          padding: 0;
        }

        .container {
          max-width: 400px;
          margin: 100px auto;
          padding: 30px;
          border: 1px solid #ddd;
          box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
        }

        .logo {
          text-align: center;
          margin-bottom: 20px;
        }

        .logo img {
          width: 150px;
          height: 50px;
        }

        .tabs {
          display: flex;
          border-bottom: 1px solid #ddd;
          margin-bottom: 20px;
        }

        .tab {
          flex: 1;
          text-align: center;
          padding: 10px 0;
          cursor: pointer;
          color: #666;
        }

        .tab.active {
          font-weight: bold;
          border-bottom: 2px solid #0076ff;
          color: #0076ff;
        }

        .form-section {
          display: none;
        }

        .form-section.active {
          display: block;
        }

        .info {
          font-size: 14px;
          color: #333;
          margin-bottom: 15px;
        }

        .input-box {
          width: 100%;
          padding: 10px;
          font-size: 14px;
          margin-bottom: 15px;
          align-items: center;
          border: 1px solid #ccc;
          border-radius: 4px;
        }

        .btn {
          width: 100%;
          background-color: #0076ff;
          color: #fff;
          padding: 10px;
          border: none;
          font-size: 16px;
          border-radius: 4px;
          margin-top: 20px;
          margin-bottom: 20px;
          cursor: pointer;
        }

        .find-other {
          text-align: center;
          margin-top: 20px;
          font-size: 13px;
          color: #444;
          cursor: pointer;
        }

        .copyright {
          text-align: center;
          font-size: 12px;
          color: #aaa;
          margin-top: 40px;
        }
      </style>





    </head>

    <body>
      <div class="container">
        <div class="logo">
          <img src="${pageContext.request.contextPath}/images/로고.png" >
        </div>
        <div class="info">귀하의 아이디는<br><h4>${owner_id}</h4>입니다.</div>
          <!-- 로그인 버튼 -->
          <input type="button" value="로그인" class="btn id-btn" id="verifyBtn" onclick="location.href='login_form.do'">
          <!-- 비밀번호 찾기 버튼 -->
          <input type="button" value="비밀번호 찾기" class="btn pw-btn" id="verifyBtn" onclick="location.href='owner_find.do'">
      </div>





    </body>

    </html>