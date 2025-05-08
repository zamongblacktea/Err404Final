<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Eatting Login</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="icon" href="${pageContext.request.contextPath}/images/잇띵로고최종.png" type="image/x-icon">

<!-- SweetAlert2 설정 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- css,js -->
<link rel="stylesheet" href="/css/login.css">
<script src="/js/login.js"></script>




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
  //API url 변수 설정
  const naverUrl = "${naverUrl}";
  const kakaoUrl = "${kakaoUrl}";



</script>






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
      <div class="sns find rider_info"><a href="rider_find.do">▶아이디 / 비밀번호 찾기</a></div>
      <div class="sns find owner_info"><a href="owner_find.do">▶아이디 / 비밀번호 찾기</a></div>
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
