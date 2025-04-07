<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ page import="java.net.URLEncoder" %>
		<%@ page import="java.security.SecureRandom" %>
			<%@ page import="java.math.BigInteger" %>

				<!DOCTYPE html>
				<html>

				<head>
					<meta charset="UTF-8">
					<title>Insert title here</title>
					<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
					<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
					<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
					
					<!-- Naver API -->
					<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>

					<!-- SweetAlert2 설정 -->
					<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>


					<style type="text/css">
						#box {
							width: 500px;
							margin: auto;
							margin-top: 150px;
						}

						th {
							vertical-align: middle !important;
						}

						input[type='button'] {
							width: 100px;
						}
					</style>


					<script type="text/javascript">

						function send(f) {

							let mem_id = f.mem_id.value.trim();
							let mem_pwd = f.mem_pwd.value.trim();

							if (mem_id == "") {
								//alert("아이디를 입력하세요!!");
								//Swal.fire("아이디를 입력하세요!!");

								Swal.fire({
									title: "입력오류",
									html: "<h5>아이디를 입력하세요!!</h5>",
									icon: "warning",
									returnFocus: false
								}).then(() => {

									f.mem_id.value = "";
									f.mem_id.focus();
								});

								return;
							}

							if (mem_pwd == "") {
								//alert("비밀번호를 입력하세요!!");
								/* Swal.fire("비밀번호를 입력하세요!!");
								f.mem_pwd.value="";
								f.mem_pwd.focus(); */

								Swal.fire({
									title: "입력오류",
									html: "<h5>비밀번호를 입력하세요!!</h5>",
									icon: "warning",
									returnFocus: false
								}).then(() => {
									f.mem_pwd.value = "";
									f.mem_pwd.focus();
								});

								return;
							}

							//f.method = "POST";
							f.action = "login.do"; //MemberLoginAction
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
						// /member/login_form.do?reason=fail_pwd&mem_id=hong
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

						//네이버 로그인 API


						function doNaverLogin() {
							const clientId = "6xqf_Lv8IjbPahrzz4EC";
							const redirectUri = "http://192.168.219.85:5500/callback";
							const state = '1234';

							const url = 'https://nid.naver.com/oauth2.0/authorize?response_type=code' +
								'&client_id=' + clientId +
								'&redirect_uri=' + encodeURIComponent(redirectUri) +
								'&state=' + state;

							showSocialLoginPopup(url);
						}

						function showSocialLoginPopup(url) {
							const width = 500;
							const height = 600;
							const left = (window.screen.width / 2) - (width / 2);
							const top = (window.screen.height / 2) - (height / 2);

							window.open(
								url,
								'NaverLogin',
								`width=${width},height=${height},left=${left},top=${top},resizable=no,scrollbars=yes`
							);
						}


					</script>



				</head>

				<body>

					<form>
						<input type="hidden" name="url" value="${ param.url }">
						<div id="box">
							<div class="panel panel-primary">
								<div class="panel-heading">
									<h3>로그인</h3>
								</div>
								<div class="panel-body">
									<table class="table">
										<tr>
											<th>아이디</th>
											<td><input class="form-control" id="mem_id" name="mem_id"
													value="${ param.mem_id }"></td>
										</tr>

										<tr>
											<th>비밀번호</th>
											<td><input class="form-control" type="password" id="mem_pwd" name="mem_pwd">
											</td>
										</tr>

										<tr>
											<td colspan="2" align="center">
												<input class="btn  btn-primary" type="button" value="로그인"
													onclick="send(this.form);">

												<input class="btn  btn-info" type="button" value="목록보기"
													onclick="location.href='../member/list.do'">
											</td>
										</tr>

									</table>
									<div>
										<p>네이버 URL: ${naverUrl}</p>
										<a href="${ naverUrl }"><img src="../images/naver.png"
												style="width: 70px; height: 70px;"></a>

									</div>
								</div>
							</div>
						</div>
					</form>

				</body>

				</html>