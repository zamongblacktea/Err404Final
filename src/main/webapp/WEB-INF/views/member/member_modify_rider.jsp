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
				let rider_name = f.rider_name.value.trim();
				let rider_email = f.rider_email.value.trim();

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



				f.action = "modify.do";// MemberModifyAction
				f.submit();

			}//end:send()




			//주소검색
			function find_curaddr() {

				/* new daum.Postcode({
					 oncomplete: function(data) {
						 // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
						 // 예제를 참고하여 다양한 활용법을 확인해 보세요.
						 //data : JOSN형식
						 //  data = { "zonecode":"06789", "address":"서울시 관악구 남부순환로 111", .... }
						 //console.log(data);
						 $("#rider_zipcode").val(data.zonecode);
						 $("#rider_curaddr").val(data.address);
			    
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
						$("#rider_zipcode").val(data.zonecode);
						$("#rider_curaddr").val(data.address);

					}
				}).open({
					left: (window.screen.width / 2) - (width / 2),
					top: (window.screen.height / 2) - (height / 2)
				});


			}

		</script>



		<script type="text/javascript">
			//javascript
			//window.onload = function(){};

			//jQuery초기화
			$(document).ready(function () {

				//select value에 원본데이터 넣기
				$("#rider_grade").val("${ vo.rider_grade }");

			});

		</script>



	</head>

	<body>

		<form class="form-inline">
			<div id="box">

				<div class="panel panel-primary">
					<div class="panel-heading">
						<h4>회원수정</h4>
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

							<tr>
								<th>닉네임</th>
								<td><input class="form-control" required="required" name="rider_nickname"
										value="${ vo.rider_nickname }" style="width: 30%;"></td>
							</tr>

							<!-- 아이디 -->
							<tr>
								<th>아이디</th>
								<td>
									<input class="form-control" name="rider_id" value="${ vo.rider_id }"
										style="width: 30%;" readonly="readonly">
								</td>
							</tr>

							<!-- 이메일 -->
							<tr>
								<th>이메일</th>
								<td><input class="form-control" type="email" name="rider_email"
										value="${ vo.rider_email }" style="width: 30%;" readonly>
								</td>
							</tr>



							<!-- 버튼 -->
							<tr>
								<td colspan="2" align="center">
									<input class="btn btn-success" type="button" value="목록보기"
										onclick="location.href='list.do'">
									<input class="btn btn-primary" type="button" value="수정하기"
										onclick="send(this.form);">
									<input class="btn btn-primary" type="button" value="탈퇴하기"
										onclick="location.href='delete.do?rider_idx=${sessionScope.user.rider_idx}';">
								</td>
							</tr>

						</table>

					</div>
				</div>

			</div>
		</form>

	</body>

	</html>