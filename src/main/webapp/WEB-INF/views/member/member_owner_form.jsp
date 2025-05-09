<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  		<!-- bootstrap 사용설정 -->
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
      <link rel="icon" href="${pageContext.request.contextPath}/images/잇띵로고최종.png" type="image/x-icon">
      <link rel="stylesheet" href="/css/ownerSignUp.css">
      <script src="/js/ownerSignUp.js"></script>
  <title>사장님 회원가입</title>


</head>
<body>
  <div class="signup-container">
    <h2>사장님 회원 가입</h2>
    <!-- 파일전송 method 설정 -->
    <form method="post" class="form-inline" enctype="multipart/form-data">
      <table class="table">

        <!-- 이름 -->
        <tr>
          <th>이름</th>
          <td><input class="form-control" required="required" name="owner_name" style="width: 50%;">
          </td>
        </tr>

        <!-- 아이디 -->
        <tr>
          <th>아이디</th>
          <td>
            <input class="form-control" id="owner_id" name="owner_id" style="width: 50%;"
              onkeyup="check_id();"><br>
            <span id="id_msg"></span>
          </td>
        </tr>

        <!-- 비밀번호 -->
        <tr>
          <th>비밀번호</th>
          <td><input type="password" class="form-control" style="width: 50%;" placeholder="비밀번호 입력" id="pwd" name="owner_pwd"></td>

        </tr>
        <tr>
          <th>비밀번호 확인</th>
          <td><input type="password" class="form-control" style="width: 50%;" placeholder="비밀번호 확인" id="authPwd" >
          <span id="pwdWarn"></span></td>

        </tr>


        <!-- 이메일 -->
        <tr>
          <th>이메일</th>
          <td><input class="form-control" placeholder="이메일" required="required" id="owner_email" name="owner_email">
            <input type="button" style="width: 30%;" value="인증" class="btn btn-primary" id="emailAuth"></td>
        </tr>
        <tr>
          <th>이메일 인증</th>          
          <td><input class="form-control" placeholder="인증 코드 6자리를 입력해주세요." maxlength="6" disabled="disabled" name="authCode" id="authCode" type="text" autofocus>
            <span id="emailAuthWarn"></span></td>

        </tr>

        <!-- 이미지 -->
        <tr>
          <th>사업자 등록증 사본</th>
          <td><input class="form-control" required="required" type="file"  name="photo"></td>
        </tr>


        <!-- 버튼 -->
        <tr>
          <td colspan="2" align="center">
              <button type="button" id="registerBtn" disabled="disabled" onclick="send(this.form)">회원가입</button>
          </td>
        </tr>
      </div>
      </table>

    </form>
  </div>


</body>
</html>
