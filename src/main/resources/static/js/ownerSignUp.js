const regular_email = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;

function send(f) {

  //입력값 체크
  let owner_id = f.owner_id.value.trim();
  let owner_name = f.owner_name.value.trim();
  let owner_pwd = f.owner_pwd.value.trim();
  let owner_email = f.owner_email.value;

  let photo = f.photo.value.trim();
  
 
  if (owner_id == "") {

	alert("아이디를 입력하세요!");
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


//이메일 인증하기 버튼을 눌렀을 때 동작
//DOM 로딩위해서 미리 초기화 해주고 불러오기
$(document).ready(function() {
$("#emailAuth").click(function() {
    	const email = $("#owner_email").val(); //사용자가 입력한 이메일 값 얻어오기
    		
    	//Ajax로 전송
        $.ajax({
        	url : "/EmailAuthO",
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
  });