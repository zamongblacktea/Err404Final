<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>아이디/비밀번호 찾기</title>
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
      box-shadow: 0 4px 10px rgba(0,0,0,0.05);
    }
    .logo {
      text-align: center;
      margin-bottom: 20px;
    }
    .logo img {
      height: 30px;
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
      width: 94%;
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
      <img src="https://img.danawa.com/newdanawa/main/logo_danawa.png" alt="잇팅 로고사진">
    </div>
    <div class="tabs">
      <div class="tab active" onclick="showTab('id')">아이디 찾기</div>
      <div class="tab" onclick="showTab('pw')">비밀번호 찾기</div>
    </div>
    <div id="id" class="form-section active">
      <div class="info">Eating 아이디를 모르시나요?<br>가입시 인증한 이메일로 아이디를 찾을 수 있습니다.</div>
      <br>
      <input type="email" class="input-box" placeholder="이메일 주소 입력">
      <button class="btn">확인</button>
    </div>
    <div id="pw" class="form-section">
      <div class="info">가입시 인증한 이메일로 비밀번호를 재설정할 수 있습니다.</div>
      <input type="text" class="input-box" placeholder="이메일 주소 입력">
      <button class="btn">확인</button>
    </div>

    <footer>푸터</footer>
  </div>

  <script>
    function showTab(tabId) {
      document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
      document.querySelectorAll('.form-section').forEach(s => s.classList.remove('active'));

      document.querySelector('.tab[onclick="showTab(\'' + tabId + '\')"]').classList.add('active');
      document.getElementById(tabId).classList.add('active');
    }
  </script>
</body>
</html>
