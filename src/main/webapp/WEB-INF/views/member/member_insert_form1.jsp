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

		<!-- 다음 주소검색 API -->
		<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


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
				let mem_name = f.mem_name.value.trim();
				let mem_pwd = f.mem_pwd.value.trim();
				let mem_email = f.mem_email.value;
				let mem_zipcode = f.mem_zipcode.value.trim();
				let mem_curaddr = f.mem_curaddr.value.trim();

				if (mem_name == "") {

					alert("이름을 입력하세요!");
					f.mem_name.value = "";
					f.mem_name.focus();
					return;
				}

				if (mem_pwd == "") {

					alert("비밀번호 입력하세요!");
					f.mem_pwd.value = "";
					f.mem_pwd.focus();
					return;
				}

				if (regular_email.test(mem_email) == false) {

					alert("형식이 맞는 이메일을 입력하세요!");
					f.mem_email.value = "";
					f.mem_email.focus();
					return;
				}

				if (mem_zipcode == "") {

					alert("우편번호 입력하세요!");
					f.mem_zipcode.value = "";
					f.mem_zipcode.focus();
					return;
				}

				if (mem_curaddr == "") {

					alert("주소를 입력하세요!");
					f.mem_curaddr.value = "";
					f.mem_curaddr.focus();
					return;
				}


				f.action = "insert.do";// MemberInsertAction
				f.submit();

			}//end:send()


			//중복아이디 체크함수
			function check_id() {
				//           document.getElementById("mem_id").value;  
				let mem_id = $("#mem_id").val();

				//가입버튼 비활성화
				$("#btn_register").prop("disabled", true);

				if (mem_id.length < 3) {
					$("#id_msg").html("아이디는 3자리 이상문자을 사용해야 합니다").css("color", "red");
					return;
				}

				//$("#id_msg").html("사용가능한 아이디 입니다").css("color","blue");

				// 서버로 입력된 아이디를 전송->중복 아이디 체크
				// Ajax통해서 background로 요청
				$.ajax({
					url: "check_id.do",     //MemberCheckIdAction
					data: { "mem_id": mem_id },//parameter  :  check_id.do?mem_id=hong
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


			//주소검색
			function find_curaddr() {

				/* new daum.Postcode({
					 oncomplete: function(data) {
						 // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
						 // 예제를 참고하여 다양한 활용법을 확인해 보세요.
						 //data : JOSN형식
						 //  data = { "zonecode":"06789", "address":"서울시 관악구 남부순환로 111", .... }
						 //console.log(data);
						 $("#mem_zipcode").val(data.zonecode);
						 $("#mem_curaddr").val(data.address);
			    
					 }
				 }).open(); */


				const width = 500; //팝업의 너비
				const height = 600; //팝업의 높이
				new daum.Postcode({
					width: width, //생성자에 크기 값을 명시적으로 지정해야 합니다.
					height: height,
					oncomplete: function (data) {
						//data : JOSN형식
						//  data = { "zonecode":"06789", "address":"서울시 관악구 남부순환로 111", .... }
						//console.log(data);
						$("#mem_zipcode").val(data.zonecode);
						$("#mem_curaddr").val(data.address);

					}
				}).open({
					left: (window.screen.width / 2) - (width / 2),
					top: (window.screen.height / 2) - (height / 2)
				});


			}

		</script>

	</head>

	<body>

		<form class="form-inline">
			<div id="box">

				<div class="panel panel-primary">
					<div class="panel-heading">
						<h4>회원가입</h4>
					</div>
					<div class="panel-body">

						<table class="table">

							<!-- 이름 -->
							<tr>
								<th>이름</th>
								<td><input class="form-control" required="required" name="mem_name" style="width: 30%;">
								</td>
							</tr>

							<!-- 아이디 -->
							<tr>
								<th>아이디</th>
								<td>
									<input class="form-control" id="mem_id" name="mem_id" style="width: 30%;"
										onkeyup="check_id();">
									<span id="id_msg"></span>
								</td>
							</tr>

							<!-- 비밀번호 -->
							<tr>
								<th>비밀번호</th>
								<td><input class="form-control" required="required" type="password" name="mem_pwd"
										style="width: 30%;"></td>
							</tr>
							<!-- 닉네임 -->
							<tr>
								<th>닉네임</th>
								<td><input class="form-control" required="required" name="mem_nickname" style="width: 30%;">
								</td>
							</tr>

							<!-- 이메일 -->
							<tr>
								<th>이메일</th>
								<td><input class="form-control" required="required" type="email" name="mem_email"
										style="width: 30%;"></td>
							</tr>

							<!-- 우편번호 -->
							<tr>
								<th>우편번호</th>
								<td>
									<input class="form-control" required="required" id="mem_zipcode" name="mem_zipcode"
										style="width: 30%;">
									<input class="btn btn-info" type="button" value="주소검색" onclick="find_curaddr();">
								</td>
							</tr>

							<!-- 주소 -->
							<tr>
								<th>주소</th>
								<td><input class="form-control" required="required" name="mem_curaddr" id="mem_curaddr"
										style="width: 100%;"></td>
							</tr>


							<!-- 버튼 -->
							<tr>
								<td colspan="2" align="center">
									<input class="btn btn-success" type="button" value="목록보기"
										onclick="location.href='../product/list.do'">
									<input class="btn btn-primary" type="button" value="회원가입" onclick="send(this.form);"
										id="btn_register" disabled="disabled">
								</td>
							</tr>

						</table>

					</div>
				</div>

			</div>
		</form>

	</body>

	</html>