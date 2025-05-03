<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>

		<!-- bootstrap 사용설정 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
		<link rel="icon" href="${pageContext.request.contextPath}/images/잇띵로고최종.png" type="image/x-icon">



		<style type="text/css">
			#box {
				width: 800px;
				margin: auto;
				margin-top: 80px;
			}

			th {
				width: 100px;
				vertical-align: middle !important;
			}

			#id_msg {
				margin-left: 10px;
			}
		</style>


		<script type="text/javascript">

			const regular_email = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;

			function send(f) {

				//입력값 체크
				let rider_idx = f.rider_idx.value;
				let rider_name = f.rider_name.value.trim();
				let rider_email = f.rider_email.value.trim();
				let rider_phone = f.rider_phone.value;
				let rider_pwd	= f.rider_pwd.value;

				if (rider_name == "") {

					alert("이름을 입력하세요!");
					f.rider_name.value = "";
					f.rider_name.focus();
					return;
				}


				if (regular_email.test(rider_email) == false) {

					alert("형식이 맞는 이메일을 입력하세요!");
					f.rider_email.value = "";
					f.rider_email.focus();
					return;
				}



				f.action = "modify_rider.do";// MemberModifyAction
				f.submit();

			}//end:send()





		</script>

<!-- 챗봇 AI -->
<script>
	(function(){var w=window;if(w.ChannelIO){return w.console.error("ChannelIO script included twice.");}var ch=function(){ch.c(arguments);};ch.q=[];ch.c=function(args){ch.q.push(args);};w.ChannelIO=ch;function l(){if(w.ChannelIOInitialized){return;}w.ChannelIOInitialized=true;var s=document.createElement("script");s.type="text/javascript";s.async=true;s.src="https://cdn.channel.io/plugin/ch-plugin-web.js";var x=document.getElementsByTagName("script")[0];if(x.parentNode){x.parentNode.insertBefore(s,x);}}if(document.readyState==="complete"){l();}else{w.addEventListener("DOMContentLoaded",l);w.addEventListener("load",l);}})();
  
	ChannelIO('boot', {
	  "pluginKey": "6f7a9234-fd72-433f-b10a-7aeef84a830c",
	  "memberId": "${ user.rider_idx }", // fill user's member id
	  "profile": { // fill user's profile
		"name": "${user.rider_name}", // fill user's name
		"landlineNumber": "USER_LANDLINE_NUMBER", // fill user's landline number  
		"CUSTOM_VALUE_1": "VALUE_1", // custom property
		"CUSTOM_VALUE_2": "VALUE_2" // custom property
	  }
	});
  </script>




	</head>

	<body>

		<form class="form-inline">
			<div id="box">
				<input type="hidden" value="${vo.rider_idx}" name="rider_idx">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h4>라이더 마이 페이지</h4>
					</div>
					<div class="panel-body">

						<table class="table">

							<!-- 회원번호 -->
							<!-- <tr>
			         <th>회원번호</th>
			         <td><input  class="form-control" readonly="readonly" name="rider_idx" value="${ vo.rider_idx }" style="width: 30%;"></td>
			      </tr> -->

							<!-- 이름 -->
							<tr>
								<th>이름</th>
								<td><input class="form-control" name="rider_name" value="${ vo.rider_name }"
										style="width: 30%;" readonly></td>
							</tr>


							<!-- 아이디 -->
							<tr>
								<th>아이디</th>
								<td>
									<input class="form-control" name="rider_id" value="${ vo.rider_id }"
										style="width: 30%;" readonly="readonly">
								</td>
							</tr>

							<tr>
								<th>비밀번호</th>
								<td>
									<input class="form-control" type="password" name="rider_pwd"
										value="${ vo.rider_pwd }" style="width: 30%;">
								</td>
							</tr>

							<!-- 이메일 -->
							<tr>
								<th>이메일</th>
								<td><input class="form-control" type="email" name="rider_email"
										value="${ vo.rider_email }" style="width: 30%;" readonly>
								</td>
							</tr>
							<!-- 전화번호 -->
							<tr>
								<th>전화번호</th>
								<td><input class="form-control" name="rider_phone" value="${vo.rider_phone}"
										pattern="^01[016789]-\d{3,4}-\d{4}$" placeholder="휴대전화 번호 입력" required></td>
								</td>
							</tr>

							<!-- 배달지역 -->
							<tr>
								<th>배달 지역</th>
								<td><input class="form-control" type="text" name="rider_loc" value="${ vo.rider_loc }"
										style="width: 30%;" readonly>
								</td>
							</tr>

							<!-- 배달지역 -->
							<tr>
								<th>승인 상태</th>
								<td><input class="form-control" type="text" name="rider_approve"
										value="${ vo.rider_approve }" style="width: 30%;" readonly>
								</td>
							</tr>



							<!-- 버튼 -->
							<tr>
								<td colspan="2" align="center">
									<input class="btn btn-success" type="button" value="메인으로"
										onclick="location.href='../rider/main.do'">
									<input class="btn btn-primary" type="button" value="수정하기"
										onclick="send(this.form);">
									<input class="btn btn-primary" type="button" value="탈퇴하기"
										onclick="location.href='delete_rider.do?rider_idx=${user.rider_idx}';">
										<input class="btn btn-warning" type="button" value="정산내역"
										onclick="location.href='../rider/deliveryfee.do?rider_idx=${user.rider_idx}'">
									</td>
							</tr>

						</table>

					</div>
				</div>

			</div>
		</form>

	</body>

	</html>