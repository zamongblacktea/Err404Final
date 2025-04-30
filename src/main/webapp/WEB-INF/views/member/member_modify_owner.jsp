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
				let owner_idx = f.owner_idx.value;
				let owner_name = f.owner_name.value.trim();
				let owner_email = f.owner_email.value.trim();
				let owner_pwd	= f.owner_pwd.value;

				if (owner_name == "") {

					alert("이름을 입력하세요!");
					f.owner_name.value = "";
					f.owner_name.focus();
					return;
				}


				if (regular_email.test(owner_email) == false) {

					alert("형식이 맞는 이메일을 입력하세요!");
					f.owner_email.value = "";
					f.owner_email.focus();
					return;
				}



				f.action = "../member/modify_owner.do";// MemberModifyAction
				f.submit();

			}//end:send()





		</script>






	</head>

	<body>

		<form class="form-inline">
			<div id="box">

				<div class="panel panel-primary">
					<div class="panel-heading">
						<h4>사장님 마이 페이지</h4>
					</div>
					<div class="panel-body">
						<input type="hidden" value="${vo.owner_idx}" name="owner_idx">
						<table class="table">

							<!-- 이름 -->
							<tr>
								<th>이름</th>
								<td><input class="form-control" name="owner_name" value="${ vo.owner_name }"
										style="width: 30%;" readonly></td>
							</tr>


							<!-- 아이디 -->
							<tr>
								<th>아이디</th>
								<td>
									<input class="form-control" name="owner_id" value="${ vo.owner_id }"
										style="width: 30%;" readonly="readonly">
								</td>
							</tr>

							<tr>
								<th>비밀번호</th>
								<td>
									<input class="form-control" type="password" name="owner_pwd"
										value="${ vo.owner_pwd }" style="width: 30%;">
								</td>
							</tr>

							<!-- 이메일 -->
							<tr>
								<th>이메일</th>
								<td><input class="form-control" type="email" name="owner_email"
										value="${ vo.owner_email }" style="width: 30%;" readonly>
								</td>
							</tr>


							<!-- 승인 상태 -->
							<tr>
								<th>승인 상태</th>
								<td><input class="form-control" type="text" name="owner_status"
										value="${ vo.owner_approve }" style="width: 30%;" readonly>
								</td>
							</tr>



							<!-- 버튼 -->
							<tr>
								<td colspan="2" align="center">
									<input class="btn btn-success" type="button" value="메인으로"
										onclick="location.href='../shop/main.do'">
									<input class="btn btn-primary" type="button" value="수정하기"
										onclick="send(this.form);">
									<input class="btn btn-primary" type="button" value="탈퇴하기"
										onclick="location.href='delete_owner.do?owner_idx=${user.owner_idx}';">
								</td>
							</tr>

						</table>

					</div>
				</div>

			</div>
		</form>

	</body>

	</html>