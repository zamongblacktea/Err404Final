<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!DOCTYPE html>
    <html lang="ko">

    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>아이디/비밀번호 찾기</title>
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
  <script>
    function changePwd(f){
      let rider_pwd = f.rider_pwd.value;
      let rider_email = f.rider_email.value;



      f.method = "POST";
      f.action = location.href="rider_changePwd.do";
      f.submit();




    }


  //비밀번호 비교
  $(document).ready(function () {
    $("#authCode").on("focusout", function() {
    	const inputCode = $("#authCode").val(); //비밀번호 입력 칸에 작성한 내용 가져오기
    	const pwd = $("#pwd").val();

    		
    	if(inputCode === pwd){
        	$("#pwdWarn").html('비밀번호가 일치합니다.');
        	$("#pwdWarn").css('color', 'green');
    		$(".pw-btn").attr("disabled", false);

    	}else{
        	$("#pwdWarn").html('비밀번호가 불일치 합니다. 다시 확인해주세요!');
        	$("#pwdWarn").css('color', 'red');
        	$(".pw-btn").attr("disabled", true);
    	}
    });
  });


  </script>




    </head>

    <body>
      <div class="container">
        <div class="logo">
          <img src="${pageContext.request.contextPath}/images/로고.png" >
        </div>
        <form>
        <input type="hidden" name="rider_email" value="${param.rider_email}">
        <input type="password" class="input-box" placeholder="비밀번호 변경" id="pwd" name="rider_pwd">
        <span id="pwdWarn"></span>
        <input type="password" class="input-box" placeholder="비밀번호 확인" id="authCode" >
          <!-- 비밀번호 변경 -->
          <input type="button" value="비밀번호 변경" class="btn pw-btn" onclick="changePwd(this.form);" disabled>
        </form>
      </div>





    </body>

    </html>