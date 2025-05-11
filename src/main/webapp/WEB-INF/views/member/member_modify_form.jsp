<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>마이 페이지</title>
  
    <!-- Poppins 폰트 -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600&display=swap" rel="stylesheet">

    <!-- Boxicons 아이콘 -->
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet"/>
    <!-- bootstrap 사용설정 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <!-- 다음 주소검색 API -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <!-- css -->
      <link rel="stylesheet" href="/css/myPage.css">



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

    function adminSend(f) {

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


        f.action = "../admin/admin_modify.do?mem_idx=${ vo.mem_idx }";// MemberModifyAction
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
                //$("#mem_zipcode").val(data.zonecode);
                $("#mem_zipcode").val(data.address);

            }
        }).open({
            left: (window.screen.width / 2) - (width / 2),
            top: (window.screen.height / 2) - (height / 2)
        });


    }

</script>


</head>
<div class="signup-container">
    <h2>마이 페이지</h2>
    <!-- 파일전송 method 설정 -->
    <form>
	<input type="hidden" value="${param.mem_idx}" name="mem_idx">
      <table class="table">

	<!-- 이름 -->
	<tr>
		<th>이름</th>
		<td><input class="form-control" name="mem_name" value="${ vo.mem_name }"
				style="width: 30%;" readonly></td>
	</tr>
  	<!-- 아이디 -->
	<tr>
		<th>아이디</th>
		<td>
			<input class="form-control" name="mem_id" value="${ vo.mem_id }" style="width: 40%;" readonly="readonly">
		</td>
	</tr>

  	<!-- 닉네임 -->
	<tr>
		<th>닉네임</th>
		<td>
			<input class="form-control" name="mem_nickname" value="${ vo.mem_nickname }" style="width: 30%; padding-right: 80px !important;" >
		</td>
	</tr>
  	<!-- 전화번호 -->
	<tr>
		<th>전화번호</th>
		<td>
			<input class="form-control" name="mem_phone" value="${ vo.mem_phone }" style="width: 30%;" >
		</td>
	</tr>

	<!-- 주소 -->
	<tr>
		<th>주소</th>
		<td>
			<input type="text" name="mem_zipcode" id="mem_zipcode" value="${vo.mem_zipcode}" placeholder="우편번호" required style="display: inline-block;">
		</td>
	</tr>
	<!-- 상세주소 -->
	<tr>
		<th>상세주소</th>
		<td>
    <input type="text" name="mem_addr" id="mem_addr" value="${vo.mem_addr}" placeholder="주소" required style="text-align: left;"/>
    <div>
    <button type="button" class="btn btn-sm btn-info" style="margin-left: 150px;" onclick="find_curaddr();">주소검색</button>
    </div>
		</td>
	</tr>
	<!-- SNS -->
	<tr>
		<th>연동 SNS</th>
		<td>
			<input class="form-control" name="mem_tpye" value="${ vo.mem_type }"
				style="width: 30%; padding-right: 80px !important;" readonly="readonly">
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

         <c:if test="${ sessionScope.user.mem_grade eq '일반' }">
		<!-- 버튼 -->
		<tr>
			<td colspan="2" align="center">
				<input id="btn" type="button" value="수정하기" style="width: 20%;" onclick="send(this.form);">
				<input id="delBtn" class="btn btn-danger" type="button" value="탈퇴하기" style="width: 20%;" onclick="location.href='delete.do?mem_idx=${user.mem_idx}';">
            </td>
		</tr>
        </c:if>
      </div>
      </table>

    </form>
  </div>


</body>
</html>




