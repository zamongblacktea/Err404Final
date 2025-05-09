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
      let code = null;
      $(document).ready(function () {
          $("#emailAuth").click(function () {
            const email = $("#rider_email").val(); //사용자가 입력한 이메일 값 얻어오기
            $.ajax({
              url: "/EmailVerifyR",
              type: "POST",
              dataType : "json",
              data: { email: email },
              success: function (result) {
                if (result === -1) {//DB에 정보 없음 리턴

                  alert("가입된 이메일이 없거나 틀린 이메일입니다.");

                }else{//DB에 이메일 정보 존재

                  //결과 확인용 콘솔
                  console.log("result : " + result);
                  // 이메일 인증 성공 → verifyWrapper div 보여주기
                  $("#verifyWrapper").show();
                  code = result; //code 변수 선언
                  alert("인증번호를 전송했습니다.");


                }
              },
              error: function () {
                alert("서버 통신에 실패했습니다.");
              }
            });//end: ajax          
          });
        });
    //인증 코드 비교
  $(document).ready(function () {
    $("#authCode").on("focusout", function() {
    	const inputCode = $("#authCode").val(); //인증번호 입력 칸에 작성한 내용 가져오기
    	
    	console.log("입력코드 : " + inputCode);
    	console.log("인증코드 : " + code);
    		
    	if(Number(inputCode) === code){
        	$("#emailAuthWarn").html('인증번호가 일치합니다.');
        	$("#emailAuthWarn").css('color', 'green');
    		$('#emailAuth').attr('disabled', true);
    		$('#email').attr('readonly', true);
    		$("#verifyBtn").attr("disabled", false);
    		$("#verifyPwdBtn").attr("disabled", false);
    	}else{
        	$("#emailAuthWarn").html('인증번호가 불일치 합니다. 다시 확인해주세요!');
        	$("#emailAuthWarn").css('color', 'red');
        	$("#verifyBtn").attr("disabled", true);
        	$("#verifyPwdBtn").attr("disabled", true);
    	}
    });
  });

  $(document).ready(function(){
  let id = $("#id");
  let pw = $("#pw");
  let form_section = $(".form-section");
  let id_btn = $(".id-btn").show();
  let pw_btn = $(".pw-btn").hide(); 


  id.on("click", function(e){
    form_section.show();
    id_btn.show();
    pw_btn.hide();
  });

  pw.on("click", function(e){
    form_section.show();
    pw_btn.show();
    id_btn.hide();
  });
});

function findId(f){

let rider_email = f.rider_email.value.trim();


f.action = location.href="rider_verifyId.do?rider_email="+ rider_email;

}
function findpwd(f){

let rider_email = f.rider_email.value.trim();


f.action = location.href="rider_verifyPwd.do?rider_email="+ rider_email;



}




</script>


    </head>

    <body>
      <div class="container">
        <div class="logo">
          <img src="${pageContext.request.contextPath}/images/로고.png" >
        </div>
        <div class="tabs">
          <div class="tab active" id="id">아이디 찾기</div>
          <div class="tab" id="pw">비밀번호 찾기</div>
        </div>
        <form>
        <div class="form-section active">
          <div class="info">Eatting 아이디/비밀번호를 잊어버렸나요?<br>가입시 인증한 이메일로 찾을 수 있습니다.</div>
          <br>
          <input type="email" class="input-box" placeholder="가입 이메일 주소 입력해주세요." id="rider_email" name="rider_email" value="${param.rider_email}">
          <input type="button" class="btn" value="인증" id="emailAuth">
        </div>
        <div id="verifyWrapper" style="display: none;">
          <input class="form-control" placeholder="인증 코드 6자리를 입력해주세요." maxlength="6" name="authCode" id="authCode" type="text" autofocus><br>
          <!-- 인증 경고문 -->
          <span id="emailAuthWarn"></span>
          <!-- 아이디 찾기 버튼 -->
          <input type="button" value="확인" class="btn id-btn active" id="verifyBtn" disabled="disabled" onclick="findId(this.form);">
          <!-- 비밀번호 찾기 버튼 -->
          <input type="button" value="확인" class="btn pw-btn" id="verifyPwdBtn" disabled="disabled" onclick="findpwd(this.form);">
        </div>
      </form>

      </div>



<script>
  // 클릭시 tab active
document.querySelectorAll('.tab').forEach(tab => {
  tab.addEventListener('click', function() {
    // 모든 탭에서 active 제거
    document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));

    // 클릭한 탭에만 active 추가
    this.classList.add('active');
  });
});
</script>

    </body>

    </html>