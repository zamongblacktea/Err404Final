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
  <title>사장님 회원가입</title>
  <style>
    :root {
      --green: #ff6b3f;
      --text-light: rgba(0, 0, 0, 0.5);
    }

    body {
      margin: 0;
      padding: 0;
      font-family: 'Segoe UI', sans-serif;
      background: #f9f9f9;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }

    .signup-container {
      width: 400px;
      background: #fff;
      box-shadow: 0 0 70px rgba(0, 0, 0, 0.05);
      border-top: 5px solid var(--green);
      padding: 40px 30px;
      box-sizing: border-box;
    }

    .signup-container h2 {
      color: var(--green);
      text-transform: uppercase;
      font-size: 18px;
      font-weight: bold;
      margin: 0 0 30px;
    }

    .signup-container input {
      width: 100%;
      margin: 10px;
      padding: 10px 0;
      border: none;
      border-bottom: 1px solid rgba(0, 0, 0, 0.1);
      outline: none;
      font-size: 14px;
      color: #333;
      transition: border-color 0.2s ease-out;
    }

    .signup-container input:valid {
      border-bottom: 1px solid var(--green);
    }

    .signup-container input:focus:invalid {
      border-bottom: 1px solid #EF6161;
    }

    .signup-container ::placeholder {
      color: var(--text-light);
    }

    .signup-container button {
      margin-top: 40px;
      padding: 10px 25px;
      background-color: var(--green);
      color: #fff;
      font-weight: bold;
      font-size: 14px;
      border: none;
      border-radius: 25px;
      cursor: pointer;
      transition: all 0.2s ease-out;
    }

    .signup-container button:hover {
      background-color: #fff;
      color: var(--green);
      border: 2px solid var(--green);
    }

    th {
				width: 100px;
				vertical-align: middle !important;
			}

  </style>

  <script>
    			const regular_email = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;

function send(f) {

  //입력값 체크
  let owner_name = f.owner_name.value.trim();
  let owner_id = f.owner_id.value.trim();
  let owner_pwd = f.owner_pwd.value.trim();
  let owner_email = f.owner_email.value;
  let owner_num = f.owner_num.value;
  let photo = f.photo.value.trim();

	if (owner_id == "") {

	alert("이름을 입력하세요!");
	f.owner_id.value = "";
	f.owner_id.focus();
	return;

	}


  if (owner_name == "") {

    alert("이름을 입력하세요!");
    f.owner_name.value = "";
    f.owner_name.focus();
    return;
  }

  if (owner_pwd == "") {

    alert("비밀번호 입력하세요!");
    f.owner_pwd.value = "";
    f.owner_pwd.focus();
    return;
  }

  if (regular_email.test(owner_email) == false) {

    alert("형식이 맞는 이메일을 입력하세요!");
    f.owner_email.value = "";
    f.owner_email.focus();
    return;
  }




  f.action = "insert_owner.do";// MemberInsertAction
  f.submit();

}//end:send()


//중복아이디 체크함수
function check_id() {
  //           document.getElementById("owner_id").value;  
  let owner_id = $("#owner_id").val();

  //가입버튼 비활성화
  $("#btn_register").prop("disabled", true);

  if (owner_id.length < 3) {
    $("#id_msg").html("아이디는 3자리 이상문자을 사용해야 합니다").css("color", "red");
    return;
  }

  //$("#id_msg").html("사용가능한 아이디 입니다").css("color","blue");

  // 서버로 입력된 아이디를 전송->중복 아이디 체크
  // Ajax통해서 background로 요청
  $.ajax({
    url: "check_id_owner.do",     //MemberCheckIdAction
    data: { "owner_id": owner_id },//parameter  :  check_id.do?owner_id=hong
    dataType: "json",            //결과수신을 JSON으로 받겠다		   
    success: function (res_data) {
      //                  사용가능                      이미사용중임  
      //  res_data = {"result": true} or res_data = {"result": false}  

      if (res_data.result == true) {

        $("#id_msg").html("사용가능한 아이디 입니다").css("color", "blue");

        //가입버튼 활성화
        //document.getElementById("btn_register").disabled = false;
        $("#btn_register").prop("disabled", false);

      } else {
        $("#id_msg").html("이미 사용중인 아이디 입니다").css("color", "red");
      }


    },
    error: function (err) {
      alert(err.responseText);
    }
  });

}//end:check_id()


    //비밀번호 비교
    $(document).ready(function () {
    $("#authPwd").on("focusout", function() {
    	const inputPwd = $("#authPwd").val(); //비밀번호 입력 칸에 작성한 내용 가져오기
    	const pwd = $("#pwd").val();

    		
    	if(inputPwd === pwd){
        	$("#pwdWarn").html('비밀번호가 일치합니다.');
        	$("#pwdWarn").css('color', 'green');
    		$(".pw-btn").attr("disabled", false);

    	}else{
        	$("#pwdWarn").html('비밀번호가 불일치 합니다. 다시 확인해주세요!');
        	$("#pwdWarn").css('color', 'red');
        	$(".pw-btn").attr("disabled", true);
    	}
    });
  });//end : authpwd

  </script>
</head>
<body>
  <div class="signup-container">
    <h2>사장님 회원 가입</h2>
    <form>
      <table class="table">

        <!-- 이름 -->
        <tr>
          <th>이름</th>
          <td><input class="form-control" required="required" name="owner_name" >
          </td>
        </tr>

        <!-- 아이디 -->
        <tr>
          <th>아이디</th>
          <td>
            <input class="form-control" id="owner_id" name="owner_id" 
              onkeyup="check_id();">
            <span id="id_msg"></span>
          </td>
        </tr>

        <!-- 비밀번호 -->
        <tr>
          <th>비밀번호</th>
          <td><input class="form-control" required="required" type="password" name="owner_pwd"></td>
        </tr>

        <!-- 이메일 -->
        <tr>
          <th>이메일</th>
          <td><input class="form-control" required="required" type="email" name="owner_email"></td>
        </tr>

        <!-- 이미지 -->
        <tr>
          <th>사업자 등록증</th>
          <td><input class="form-control" required="required" type="file"  name="photo"></td>
        </tr>


        <!-- 버튼 -->
        <tr>
          <td colspan="2" align="center">
              <button type="button" onclick="send(this.form)">회원가입</button>
          </td>
        </tr>

      </table>

    </form>
  </div>


</body>
</html>
