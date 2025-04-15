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
  <title>라이더 회원가입</title>
  <style>
    :root {
      --green: #ff694a;
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
      border-bottom: 1px solid #ff694a;
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
  let rider_id = f.rider_id.value.trim();
  let rider_name = f.rider_name.value.trim();
  let rider_pwd = f.rider_pwd.value.trim();
  let rider_email = f.rider_email.value;
  let rider_nickname = f.rider_nickname.value;
  let rider_account = f.rider_account.value;
  let rider_loc = f.rider_loc.value;
  let rider_type = f.rider_type.value;
  let rider_img = f.rider_img.value;
  
 
  if (rider_id == "") {

	alert("아이디를 입력하세요!");
	f.rider_id.value = "";
	f.rider_id.focus();
	return;
	}

  if (rider_name == "") {

    alert("이름을 입력하세요!");
    f.rider_name.value = "";
    f.rider_name.focus();
    return;
  }

  if (rider_pwd == "") {

    alert("비밀번호 입력하세요!");
    f.rider_pwd.value = "";
    f.rider_pwd.focus();
    return;
  }

  if (regular_email.test(rider_email) == false) {

    alert("형식이 맞는 이메일을 입력하세요!");
    f.rider_email.value = "";
    f.rider_email.focus();
    return;
  }




  f.action = "insert_rider.do";// MemberInsertAction
  f.submit();

}//end:send()



//중복아이디 체크함수
function check_id() {
  //           document.getElementById("rider_id").value;  
  let rider_id = $("#rider_id").val();

  //가입버튼 비활성화
  $("#btn_register").prop("disabled", true);

  if (rider_id.length < 3) {
    $("#id_msg").html("아이디는 3자리 이상문자을 사용해야 합니다").css("color", "red");
    return;
  }

  //$("#id_msg").html("사용가능한 아이디 입니다").css("color","blue");

  // 서버로 입력된 아이디를 전송->중복 아이디 체크
  // Ajax통해서 background로 요청
  $.ajax({
    url: "check_id.do",     //MemberCheckIdAction
    data: { "rider_id": rider_id },//parameter  :  check_id.do?rider_id=hong
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


//이메일 인증하기 버튼을 눌렀을 때 동작
//DOM 로딩위해서 미리 초기화 해주고 불러오기
$(document).ready(function() {
$("#emailAuth").click(function() {
    	const email = $("#rider_email").val(); //사용자가 입력한 이메일 값 얻어오기
    		
    	//Ajax로 전송
        $.ajax({
        	url : "/EmailAuth",
        	data : {
        		email : email
        	},
        	type : "POST",
        	dataType : "json",
        	success : function(res_data) {

            //이메일 중복가입 방지
            if(res_data == -1){//이미 가입된 이메일이 있을 때



            alert("이미 가입된 이메일입니다.");

          }else{//DB에 같은 이메일이 없을 때 (사용 가능)
            //결과 확인용 콘솔
            console.log("result : " + res_data);
        		$("#authCode").attr("disabled", false);
        		code = res_data;
        		alert("인증 코드가 입력하신 이메일로 전송 되었습니다.");

          }
       		}
        }); //End Ajax
    });
  });
  </script>
<script type="text/javascript">
	//인증 코드 비교
  $(document).ready(function() {
    $("#authCode").on("focusout", function() {
    	const inputCode = $("#authCode").val(); //인증번호 입력 칸에 작성한 내용 가져오기
    	
    	console.log("입력코드 : " + inputCode);
    	console.log("인증코드 : " + code);
    		
    	if(Number(inputCode) === code){
        	$("#emailAuthWarn").html('인증번호가 일치합니다.');
        	$("#emailAuthWarn").css('color', 'green');
    		$('#emailAuth').attr('disabled', true);
    		$('#email').attr('readonly', true);
    		$("#registerBtn").attr("disabled", false);
    	}else{
        	$("#emailAuthWarn").html('인증번호가 불일치 합니다. 다시 확인해주세요!');
        	$("#emailAuthWarn").css('color', 'red');
        	$("#registerBtn").attr("disabled", true);
    	}
    });
  });
</script>



</head>
<body>
  <div class="signup-container">
    <h2>라이더 회원 가입</h2>
    <form>
      <table class="table">

        <!-- 이름 -->
        <tr>
          <th>이름</th>
          <td><input class="form-control" required="required" name="rider_name" >
          </td>
        </tr>

        <!-- 아이디 -->
        <tr>
          <th>아이디</th>
          <td>
            <input class="form-control" id="rider_id" name="rider_id" 
              onkeyup="check_id();">
            <span id="id_msg"></span>
          </td>
        </tr>

        <!-- 비밀번호 -->
        <tr>
          <th>비밀번호</th>
          <td><input class="form-control" required="required" type="password" name="rider_pwd"></td>
        </tr>
        <!-- 닉네임 -->
        <tr>
          <th>닉네임</th>
          <td><input class="form-control" required="required" name="rider_nickname">
          </td>
        </tr>

        <!-- 이메일 -->
        <tr>
          <th>이메일</th>
          <td><input class="form-control" placeholder="이메일" required="required" id="rider_email" name="rider_email"></td>
          <td><input type="button" value="인증" class="btn btn-primary" id="emailAuth"></td>
        </tr>
        <tr>
          <th>이메일 인증</th>          
          <td><input class="form-control" placeholder="인증 코드 6자리를 입력해주세요." maxlength="6" disabled="disabled" name="authCode" id="authCode" type="text" autofocus></td>
          <td><span id="emailAuthWarn"></span></td>
        </tr>

        <!-- 계좌번호 -->
        <tr>
          <th>지급 계좌</th>
          <td><input class="form-control" required="required" type="text" name="rider_account"></td>
        </tr>
        <!-- 배달지역 -->
        <tr>
          <th>배달 지역</th>
          <td><input class="form-control" required="required" type="text" name="rider_loc"></td>
        </tr>
        <!-- 운송수단 -->
        <tr>
          <th>운송 수단</th>
          <td><input class="form-control" required="required" type="text" name="rider_type"></td>
        </tr>
        <!-- 이미지 -->
        <tr>
          <th>운전면허증 등록</th>
          <td><input class="form-control" required="required" type="email"  name="rider_img"></td>
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
