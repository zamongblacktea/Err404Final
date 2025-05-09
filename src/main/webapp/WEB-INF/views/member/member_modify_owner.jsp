<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  		<!-- bootstrap 사용설정 -->
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
      <link rel="icon" href="${pageContext.request.contextPath}/images/잇띵로고최종.png" type="image/x-icon">
      <!-- css,js -->
      <link rel="stylesheet" href="/css/ownerInfo.css">
  <title>사장님 마이 페이지</title>


<script type="text/javascript">

  const regular_email = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;

  function send(f) {

    //입력값 체크
    let owner_idx = f.owner_idx.value;
    let owner_pwd	= f.owner_pwd.value;




    if (owner_pwd == "") {

    alert("비밀번호를 입력하세요!");
    f.owner_pwd.value = "";
    f.owner_pwd.focus();
    return;
    }


    f.method = "POST";
    f.action = "../member/modify_owner.do";// MemberModifyAction
    f.submit();

  }//end:send()




    function adminSend(f) {

    //입력값 체크
    let owner_idx = f.owner_idx.value;
    let owner_pwd	= f.owner_pwd.value;




    if (owner_pwd == "") {

    alert("비밀번호를 입력하세요!");
    f.owner_pwd.value = "";
    f.owner_pwd.focus();
    return;
    }


    f.method = "POST";
    f.action = "../admin/admin_modify_owner.do?owner_idx="+ owner_idx;// MemberModifyAction
    f.submit();

  }//end:send()



</script>





</head>
<body>
  <div class="signup-container">
    <h2>사장님 마이 페이지</h2>
    <!-- 파일전송 method 설정 -->
    <form>
	<input type="hidden" value="${param.owner_idx}" name="owner_idx">
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
				style="width: 30%; padding-right: 80px !important;" readonly="readonly">
		</td>
	</tr>

	<tr>
		<th>비밀번호</th>
		<td>
			<input class="form-control" type="password" name="owner_pwd"
				value="${ vo.owner_pwd }" style="width: 30%; padding-left: 20px; text-align: left;">
		</td>
	</tr>

	<!-- 이메일 -->
	<tr>
		<th>이메일</th>
		<td><input class="form-control" type="email" name="owner_email"
				value="${ vo.owner_email }" style="width: 50%;" readonly>
		</td>
	</tr>


	<!-- 승인 상태 -->
	<tr>
		<th>승인 상태</th>
		<td><input class="form-control" type="text" name="owner_status"
				value="${ vo.owner_approve }" style="width: 15%;" readonly>
		</td>
	</tr>




	               <!-- 로그인 유저가 관리자면 -->
           <c:if test="${ sessionScope.user.mem_grade eq '관리자' }">
            <tr>
	           <td colspan="2" align="center">
                    <input id="btn" type="button" value="수정하기" style="width: 20%;"onclick="adminSend(this.form)">

	               
	               <input id="delBtn" class="btn btn-danger" type="button" value="탈퇴하기" style="width: 20%;" onclick="location.href='admin_delete.do?mem_idx=${user.mem_idx}';">
	           </td>
            </tr>
           </c:if>


		<!-- 버튼 -->
		<tr>
			<td colspan="2" align="center">
				<input id="btn" type="button" value="수정하기" style="width: 20%;" onclick="send(this.form);">
				<input id="delBtn" class="btn btn-danger" type="button" value="탈퇴하기" style="width: 20%;" onclick="location.href='delete_owner.do?owner_idx=${user.owner_idx}';">
            </td>
		</tr>


      </div>
      </table>

    </form>
  </div>


</body>
</html>
