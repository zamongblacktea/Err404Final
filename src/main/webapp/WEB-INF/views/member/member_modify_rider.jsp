<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  		<!-- bootstrap 사용설정 -->
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
      <link rel="icon" href="${pageContext.request.contextPath}/images/잇띵로고최종.png" type="image/x-icon">
	  <link rel="stylesheet" href="/css/riderInfo.css">
  <title>라이더 마이 페이지</title>
  


<script type="text/javascript">

  const regular_email = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;

  function send(f) {

    //입력값 체크
    let rider_idx = f.rider_idx.value;
    let rider_pwd	= f.rider_pwd.value;




    if (rider_pwd == "") {

    alert("비밀번호를 입력하세요!");
    f.rider_pwd.value = "";
    f.rider_pwd.focus();
    return;
    }


    f.method = "POST";
    f.action = "../member/modify_rider.do";// MemberModifyAction
    f.submit();

  }//end:send()





</script>





</head>
<body>
  <div class="signup-container">
    <h2>라이더 마이 페이지</h2>
    <!-- 파일전송 method 설정 -->
    <form>
	<input type="hidden" value="${vo.rider_idx}" name="rider_idx">
      <table class="table">

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
				value="${ vo.rider_email }" style="width: 50%;" readonly>
		</td>
	</tr>


	<!-- 승인 상태 -->
	<tr>
		<th>승인 상태</th>
		<td><input class="form-control" type="text" name="rider_status"
				value="${ vo.rider_approve }" style="width: 10%; text-align: center;" readonly>
		</td>
	</tr>



		<!-- 버튼 -->
		<tr>
			<td colspan="2" align="center">
				<input id="main" class="btn btn-success" type="button" value="메인으로" onclick="location.href='../rider/main.do'">				
				<input id="accounts" class="btn btn-warning" type="button" value="정산내역" onclick="location.href='../rider/deliveryfee.do?rider_idx=${user.rider_idx}'">
				<input id="btn" type="button" value="수정하기" onclick="send(this.form);">
				<input id="delBtn" class="btn btn-danger" type="button" value="탈퇴하기" onclick="location.href='delete_owner.do?rider_idx=${user.rider_idx}';">
			</td>
		</tr>
      </div>
      </table>

    </form>
  </div>


</body>
</html>
