<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>


<!-- SweetAlert2 설정 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>


<!-- Naver 로그인 API -->
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>

<!-- kakao 로그인 API -->
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.4/kakao.min.js"
  integrity="sha384-DKYJZ8NLiK8MN4/C5P2dtSmLQ4KwPaoqAfyA/DfmEc1VDxu4yyC7wy6K1Hs90nka" crossorigin="anonymous"></script>
<script>
  Kakao.init('76c0b7bcbbe38b1ff825aa48ad565606'); // 사용하려는 앱의 JavaScript 키 입력
</script>


<script>
  function loginWithKakao() {
    Kakao.Auth.authorize({
      redirectUri: 'https://localhost:5050/kakao/callback',
    });
  }

  displayToken()
  function displayToken() {
    var token = getCookie('authorize-access-token');

    if(token) {
      Kakao.Auth.setAccessToken(token);
      Kakao.Auth.getStatusInfo()
        .then(function(res) {
          if (res.status === 'connected') {
            document.getElementById('token-result').innerText
              = 'login success, token: ' + Kakao.Auth.getAccessToken();
          }
        })
        .catch(function(err) {
          Kakao.Auth.setAccessToken(null);
        });
    }
  }

  function getCookie(name) {
    var parts = document.cookie.split(name + '=');
    if (parts.length === 2) { return parts[1].split(';')[0]; }
  }
</script>




<!-- 로그인 페이지 js -->
<script>
  const naverUrl = "${naverUrl}";
  const kakaoUrl = "${kakaoUrl}";

$(document).ready(function(){
    $(".input__block").hide();
    let owner = $(".links").find("li").find("#owner") ; 
    let member = $(".links").find("li").find("#member") ; 
    let rider = $(".links").find("li").find("#rider") ; 
    //let first_input = $("form").find(".first-input");
    //let hidden_input = $("form").find(".input__block").find(".first-input__block");
    let form_inputs = $("form .input__block"); // 전체 input div들
    let sns = $(".sns");
    let mem = $(".mem");
    let owner_btn = $("form").find("#owner_btn");
    let owner_info = $("form").find(".owner_info");
    let rider_btn = $("form").find("#rider_btn");
    let rider_info = $("form").find(".rider_info");
    let signin_btn  = $("form").find(".signin__btn");
    sns.hide();
  
   //----------- member ---------------------
   member.on("click",function(e){
      e.preventDefault();
      $(this).parent().parent().siblings("h1").text("로그인");
      $(this).parent().css("opacity","1");
      $(this).parent().siblings().css("opacity",".6");
      form_inputs.hide();
      mem.show();
      sns.hide();
      // hidden_input.css({
      //   "opacity" : "1",
      //   "display" : "none"
      // });
      signin_btn.text("Login");
    });

    //----------- owner ---------------------
    owner.on("click",function(e){
      e.preventDefault();
      $(this).parent().parent().siblings("h1").text("로그인");
      $(this).parent().css("opacity","1");
      $(this).parent().siblings().css("opacity",".6");
      form_inputs.show();
      sns.show();
      mem.hide();
      rider_btn.hide();
      rider_info.hide();
      // hidden_input.css({
      //   "opacity" : "1",
      //   "display" : "none"
      // });
      signin_btn.text("Login");
    });

  //----------- rider ---------------------
      rider.on("click",function(e){
      e.preventDefault();
      $(this).parent().parent().siblings("h1").text("로그인");
      $(this).parent().css("opacity","1");
      $(this).parent().siblings().css("opacity",".6");
      form_inputs.show();
      sns.show();
      mem.hide();
      owner_btn.hide();
      owner_info.hide();
      // hidden_input.css({
      //   "opacity" : "1",
      //   "display" : "none"
      // });
      signin_btn.text("Login");
    });
    

   

});


</script>

<script type="text/javascript">




  function owner_send(f) {

    let owner_id = f.owner_id.value.trim();
    let owner_pwd = f.owner_pwd.value.trim();

    if (owner_id == "") {
      //alert("아이디를 입력하세요!!");
      //Swal.fire("아이디를 입력하세요!!");

      Swal.fire({
        title: "입력오류",
        html: "<h5>아이디를 입력하세요!!</h5>",
        icon: "warning",
        returnFocus: false
      }).then(() => {

        f.owner_id.value = "";
        f.owner_id.focus();
      });

      return;
    }

    if (owner_pwd == "") {
      //alert("비밀번호를 입력하세요!!");
      /* Swal.fire("비밀번호를 입력하세요!!");
      f.owner_pwd.value="";
      f.owner_pwd.focus(); */

      Swal.fire({
        title: "입력오류",
        html: "<h5>비밀번호를 입력하세요!!</h5>",
        icon: "warning",
        returnFocus: false
      }).then(() => {
        f.owner_pwd.value = "";
        f.owner_pwd.focus();
      });

      return;
    }

    //f.method = "POST";
    f.action = "owner_login.do"; //MemberLoginAction
    f.submit();            //지정 action호출(데이터전송)   
  }

  function rider_send(f) {

let rider_id = f.rider_id.value.trim();
let rider_pwd = f.rider_pwd.value.trim();

if (rider_id == "") {
  //alert("아이디를 입력하세요!!");
  //Swal.fire("아이디를 입력하세요!!");

  Swal.fire({
    title: "입력오류",
    html: "<h5>아이디를 입력하세요!!</h5>",
    icon: "warning",
    returnFocus: false
  }).then(() => {

    f.rider_id.value = "";
    f.rider_id.focus();
  });

  return;
}

if (rider_pwd == "") {
  //alert("비밀번호를 입력하세요!!");
  /* Swal.fire("비밀번호를 입력하세요!!");
  f.rider_pwd.value="";
  f.rider_pwd.focus(); */

  Swal.fire({
    title: "입력오류",
    html: "<h5>비밀번호를 입력하세요!!</h5>",
    icon: "warning",
    returnFocus: false
  }).then(() => {
    f.rider_pwd.value = "";
    f.rider_pwd.focus();
  });

  return;
}

//f.method = "POST";
f.action = "rider_login.do"; //MemberLoginAction
f.submit();            //지정 action호출(데이터전송)   
}
</script>


<script type="text/javascript">

  //현재 HTML문서의 배치가 완료되면 자동호출 함수
  window.onload = function () {

    setTimeout(show_message, 100);//0.1초후에 show_message호출
    //show_message();

  };


  // /member/login_form.do?reason=fail_id
  // /member/login_form.do?reason=fail_pwd&rider_id=hong
  // /member/login_form.do?reason=session_timeout
  function show_message() {

    if ("${ param.reason eq 'fail_id' }" == "true") {
      //alert("아이디가 틀렸습니다!");
      Swal.fire({
        title: "로그인실패",
        html: "<h5>아이디가 틀렸습니다!!</h5>",
        icon: "warning",
        returnFocus: false
      }).then(() => {

        $("#mem_id").focus();

      });
    }

    if ("${ param.reason eq 'fail_pwd' }" == "true") {
      //alert("비밀번호가 틀렸습니다!");
      Swal.fire({
        title: "로그인실패",
        html: "<h5>비밀번호가 틀렸습니다!!</h5>",
        icon: "warning",
        returnFocus: false
      }).then(() => {

        $("#mem_pwd").focus();

      });
    }

    if ("${ param.reason eq 'session_timeout' }" == "true") {
      //alert("아이디가 틀렸습니다!");
      Swal.fire({
        title: "로그아웃",
        html: "<h5>로그아웃 되었습니다!!</h5>",
        icon: "warning",
        returnFocus: false
      }).then(() => {

        $("#mem_id").focus();

      });
    }

  }

</script>




<style>
  body {
  font-family: 'Montserrat', sans-serif;
  background: white;
}

.container {
  display: block;
  max-width: 680px;
  width: 80%;
  margin: 120px auto;
}

h1 {
  color: #ff6b3f;
  font-size: 48px;
  letter-spacing: -3px;
  text-align: center;
  margin: 120px 0 80px 0;
  transition: 0.2s linear;
}

.links {
  list-style-type: none;
}

.links li {
  display: inline-block;
  margin: 0 20px 0 0;
  transition: 0.2s linear;
}

.links li:nth-child(2) {
  opacity: 0.6;
}

.links li:nth-child(2):hover {
  opacity: 1;
}

.links li:nth-child(3) {
  opacity: 0.6;
}

.links li:nth-child(3):hover {
  opacity: 1;
}

.links li a {
  text-decoration: none;
  color: #0f132a;
  font-weight: bolder;
  text-align: center;
  cursor: pointer;
}

form {
  width: 100%;
  max-width: 680px;
  margin: 40px auto 10px;
}

form .input__block {
  margin: 20px auto;
  display: block;
  position: relative;
}

/* form .first-input__block::before {
  content: "sdf";
  position: absolute;
  top: -15px;
  left: 50px;
  display: block;
  width: 0;
  height: 0;
  background: transparent;
  border-left: 15px solid transparent;
  border-right: 15px solid transparent;
  border-bottom: 15px solid rgba(15, 19, 42, 0.1);
  transition: 0.2s linear;
} */

form .signup-input__block::before {
  content: "";
  position: absolute;
  top: -15px;
  left: 150px;
  display: block;
  width: 0;
  height: 0;
  background: transparent;
  border-left: 15px solid transparent;
  border-right: 15px solid transparent;
  border-bottom: 15px solid rgba(15, 19, 42, 0.1);
  transition: 0.2s linear;
}

form .input__block input {
  display: block;
  width: 90%;
  max-width: 680px;
  height: 50px;
  margin: 0 auto;
  border-radius: 8px;
  border: none;
  background: rgba(15, 19, 42, 0.1);
  color: rgba(15, 19, 42, 0.3);
  padding: 0 0 0 15px;
  font-size: 14px;
  font-family: 'Montserrat', sans-serif;
}

form .input__block input:focus,
form .input__block input:active {
  outline: none;
  border: none;
  color: rgba(15, 19, 42, 1);
}

form .input__block input.repeat__password {
  opacity: 0;
  display: none;
  transition: 0.2s linear;
}

form .signin__btn {
  background: #ff694a;
  color: white;
  display: block;
  width: 92.5%;
  max-width: 680px;
  height: 50px;
  border-radius: 8px;
  margin: 0 auto;
  border: none;
  cursor: pointer;
  font-size: 14px;
  font-family: 'Montserrat', sans-serif;
  box-shadow: 0 15px 30px rgba(233, 30, 99, 0.36);
  transition: 0.2s linear;
}

form .signin__btn:hover {
  box-shadow: 0 0 0 rgba(233, 30, 99, 0);
}

.separator {
  display: block;
  margin: 30px auto 10px;
  text-align: center;
  height: 40px;
  position: relative;
  background: transparent;
  color: rgba(15, 19, 42, 0.4);
  font-size: 13px;
  width: 90%;
  max-width: 680px;
}

.separator::before {
  content: "";
  position: absolute;
  top: 8px;
  left: 0;
  background: rgba(15, 19, 42, 0.2);
  height: 1px;
  width: 45%;
}

.separator::after {
  content: "";
  position: absolute;
  top: 8px;
  right: 0;
  background: rgba(15, 19, 42, 0.2);
  height: 1px;
  width: 45%;
}

.google__btn,
.naver__btn,
.kakao__btn,
.rider__btn {
  display: block;
  width: 90%;
  max-width: 680px;
  margin: 20px auto;
  height: 50px;
  cursor: pointer;
  font-size: 14px;
  font-family: 'Montserrat', sans-serif;
  border-radius: 8px;
  border: none;
  line-height: 40px;
}

.google__btn {
  background: #5b90f0;
  color: white;
  box-shadow: 0 15px 30px rgba(91, 144, 240, 0.36);
  transition: 0.2s linear;
}

.google__btn:hover {
  box-shadow: 0 0 0 rgba(91, 144, 240, 0);
}

.kakao__btn {
  background: #FEE500;
  color: white;
  box-shadow: 0 15px 30px rgba(37, 40, 45, 0.36);
  transition: 0.2s linear;
}

.rider__btn {
  background: #708090;
  color: white;
  box-shadow: 0 15px 30px rgba(37, 40, 45, 0.36);
  transition: 0.2s linear;
}


.naver__btn{
  background: #03C75A;
  color: white;
  box-shadow: 0 15px 30px rgba(37, 40, 45, 0.36);
  transition: 0.2s linear;
  align-content: center;
  clear: both;

}

.naver__btn img {
  float: left;
  margin-right: -150px;
  margin-left: 132px;
  width: 50px;
  height: 100%;
  left: 20px;
}


.naver__btn:hover {
  box-shadow: 0 0 0 rgba(37, 40, 45, 0);
}

.kakao__btn:hover {
  box-shadow: 0 0 0 rgba(37, 40, 45, 0);
}

.google__btn .fa,
.kakao__btn .fa {
  font-size: 20px;
  padding: 0 5px 0 0;
}

footer p {
  text-align: center;
}

footer p a {
  text-decoration: none;
  font-size: 17px;
  margin: 0 5px;
}

.find{
  display: block;
  width: 90%;

  max-width: 680px;
  height: 40px;
  margin: 0 auto;
  border: none;
  cursor: pointer;
  font-size: 14px;

}


</style>


</head>




<body>
  <div class="container">
    <!-- Heading -->
    <h1>로그인</h1>
    
    <!-- Links -->
    <ul class="links">
      <li>
        <a href="#" id="member" id="hideBtn">일반 회원</a>
      </li>
      <li>
        <a href="#" id="owner">사업자</a>
      </li>
      <li>
        <a href="#" id="rider">라이더</a>
      </li>
    </ul>
    
    <!-- Form -->
    <form>
        <!-- google button -->
        <button class="google__btn mem">
        <i class="fa fa-google"></i>
        Sign in with Google
        </button>
        <!-- 카카오 로그인 -->
        <button class="kakao__btn mem" type="button" onclick="location.href=kakaoUrl">
        <i class="fa fa-github"> <img src="../images/kakao.png" ></i>
        </button>
        <div class="mem">
        <!-- 네이버 로그인 -->
        <button class="naver__btn mem" type="button" onclick="location.href=naverUrl">
           <img src="../images/naver.png"> Naver 계정 로그인
        </button>
        <div style="clear: both;"></div>

        </div>


      <!-- owner -->
      <!-- id input -->
      <div class="first-input input__block owner_info">
         <input placeholder="사장님 아이디" class="input" id="email" name="owner_id"/>
      </div>
      <!-- password input -->
      <div class="input__block owner_info">
         <input type="password" placeholder="비밀번호" class="input" id="password" name="owner_pwd"   />
      </div>

      <!-- rider -->
      <!-- id input -->
      <div class="first-input input__block rider_info">
         <input placeholder="라이더 아이디" class="input" id="email" name="rider_id"/>
      </div>
      <!-- password input -->
      <div class="input__block rider_info">
         <input type="password" placeholder="비밀번호" class="input" id="password" name="rider_pwd"   />
      </div>
      <div class="sns find"><a href="find_info.do">▶아이디 / 비밀번호 찾기</a></div>
      <!-- 사장님 로그인 버튼 -->
      <input class="signin__btn input__block" id="owner_btn" value="Login" style="text-align: center;" onclick="owner_send(this.form);">
      <!-- 라이더 로그인 버튼 -->
      <input class="signin__btn input__block" id="rider_btn" value="Login" style="text-align: center;" onclick="rider_send(this.form);">
    </form>
    <!-- separator -->
    <div class="sns">
    <div class="separator">
      <p>OR</p>
    </div>
    <!-- 회원가입 사장님 -->
    <button class="google__btn" onclick="location.href='owner_form.do'">
      <i class="fa fa-google"></i>
      사장님 회원 가입
    </button>
    <!-- 회원가입 라이더 -->
    <button class="rider__btn" onclick="location.href='rider_form.do'">
      <i class="fa fa-github"></i>
      라이더 회원 가입
    </button>
  </div>
  </div>
  
  <footer>

  </footer>
</body>
</html>
