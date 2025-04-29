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
				let mem_idx = f.mem_idx.value;
				let mem_name = f.mem_name.value.trim();
				let mem_zipcode = f.mem_zipcode.value.trim();
				let mem_addr = f.mem_addr.value.trim();
				let mem_phone = f.mem_phone.value;

				if (mem_name == "") {

					alert("이름을 입력하세요!");
					f.mem_name.value = "";
					f.mem_name.focus();
					return;
				}



				if (mem_zipcode == "") {

					alert("우편번호 입력하세요!");
					f.mem_zipcode.value = "";
					f.mem_zipcode.focus();
					return;
				}

				if (mem_addr == "") {

					alert("주소를 입력하세요!");
					f.mem_addr.value = "";
					f.mem_addr.focus();
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
						$("#mem_addr").val(data.address);

					}
				}).open({
					left: (window.screen.width / 2) - (width / 2),
					top: (window.screen.height / 2) - (height / 2)
				});


			}

		</script>





	</head>

	<body>
		<nav>
			<%@include file="../main/navbar.jsp" %>
		</nav>

		<form class="form-inline">
			<div id="box">
				<%@ include file="member_bar.jsp" %>
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h4>회원수정</h4>
					</div>
					<div class="panel-body">
						<input type="hidden" value="${vo.mem_idx}" name="mem_idx">
						<table class="table">


							<!-- 이름 -->
							<tr>
								<th>이름</th>
								<td><input class="form-control" readonly name="mem_name" value="${ vo.mem_name }"
										style="width: 30%;"></td>
							</tr>

							<!-- 아이디 -->
							<tr>
								<th>아이디</th>
								<td>
									<input class="form-control" name="mem_id" value="${ vo.mem_id }" style="width: 30%;"
										readonly="readonly">
								</td>
							</tr>
							<!-- 아이디 -->
							<tr>
								<th>닉네임</th>
								<td>
									<input class="form-control" name="mem_nickname" value="${ vo.mem_nickname }"
										style="width: 30%;" required>
								</td>
							</tr>
							<!-- 전화번호 -->
							<tr>
								<th>전화번호</th>
								<td><input class="form-control" type="text" name="mem_phone" value="${vo.mem_phone}"
										 placeholder="휴대전화 번호 입력" required></td>
								</td>
							</tr>
							<!-- 우편번호 -->
							<tr>
								<th>우편번호</th>
								<td>
									<input class="form-control" required="required" id="mem_zipcode" name="mem_zipcode"
										value="${ vo.mem_zipcode }" style="width: 30%;">
									<input class="btn btn-info" type="button" value="주소검색" onclick="find_curaddr();">
								</td>
							</tr>

							<!-- 주소 -->
							<tr>
								<th>주소</th>
								<td><input class="form-control" required="required" name="mem_addr" id="mem_addr"
										value="${ vo.mem_addr }" style="width: 100%;"></td>
							</tr>

							<!-- 아이디 -->
							<tr>
								<th>연동 SNS</th>
								<td>
									<input class="form-control" name="mem_type" value="${ vo.mem_type }"
										style="width: 30%;" readonly="readonly">
								</td>
							</tr>


							<!-- 버튼 -->
							<tr>
								<td colspan="2" align="center">
									<input class="btn btn-success" type="button" value="목록보기"
										onclick="location.href='../main/main.do'">
									<input class="btn btn-primary" type="button" value="수정하기"
										onclick="send(this.form);">
								</td>
							</tr>

						</table>

					</div>
				</div>

			</div>
		</form>

	</body>

	</html>