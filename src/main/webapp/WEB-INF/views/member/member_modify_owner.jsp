<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
  
  #box{
     width: 800px;
     margin: auto;
     margin-top: 80px;
  }
  
  th{
     width: 100px;
     vertical-align: middle !important;
  }

  #id_msg{
     margin-left: 10px;
  }
</style>


<script type="text/javascript">

   const regular_email = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
   
   function send(f){
	   
	   //입력값 체크
	   let owner_name 	= f.owner_name.value.trim();
	   let owner_email	= f.owner_email.value.trim();

	   
	   if(owner_name == ""){
		   
		   alert("이름을 입력하세요!");
		   f.owner_name.value="";
		   f.owner_name.focus();
		   return;
	   }
	   
	   
	   if(regular_email.test(owner_email)==false){
		   
		   alert("형식이 맞는 이메일을 입력하세요!");
		   f.owner_email.value="";
		   f.owner_email.focus();
		   return;
	   }
	   
	   if(owner_zipcode == ""){
		   
		   alert("우편번호 입력하세요!");
		   f.owner_zipcode.value="";
		   f.owner_zipcode.focus();
		   return;
	   }
	   
	   if(owner_curaddr == ""){
		   
		   alert("주소를 입력하세요!");
		   f.owner_curaddr.value="";
		   f.owner_curaddr.focus();
		   return;
	   }
	   	   
	   
	   f.action = "modify.do";// MemberModifyAction
	   f.submit();
	   
   }//end:send()

     
     
   
   //주소검색
   function find_curaddr(){
	   
	   /* new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
	            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
	            //data : JOSN형식
	            //  data = { "zonecode":"06789", "address":"서울시 관악구 남부순환로 111", .... }
	            //console.log(data);
	            $("#owner_zipcode").val(data.zonecode);
	            $("#owner_curaddr").val(data.address);
	   
	        }
	    }).open(); */
	    
	    
	   const width  = 500; //팝업의 너비
	   const height = 600; //팝업의 높이
	   new daum.Postcode({
	       width: width, //생성자에 크기 값을 명시적으로 지정해야 합니다.
	       height: height,
	       oncomplete: function(data) {
	            //data : JOSN형식
	            //  data = { "zonecode":"06789", "address":"서울시 관악구 남부순환로 111", .... }
	            //console.log(data);
	            $("#owner_zipcode").val(data.zonecode);
	            $("#owner_curaddr").val(data.address);
	   
	        }
	   }).open({
	       left: (window.screen.width / 2) - (width / 2),
	       top:  (window.screen.height / 2) - (height / 2)
	   });
	   
	   
   }
   
</script>



<script type="text/javascript">
   //javascript
   //window.onload = function(){};
   
   //jQuery초기화
   $(document).ready(function(){
	   
	   //select value에 원본데이터 넣기
	   $("#owner_grade").val("${ vo.owner_grade }");
	   
   });

</script>



</head>
<body>

<form class="form-inline">
	<div id="box">

		<div class="panel panel-primary">
			<div class="panel-heading"><h4>회원수정</h4></div>
			<div class="panel-body">
			   
			   <table class="table">
			      
			      <!-- 회원번호 -->
			      <!-- <tr>
			         <th>회원번호</th>
			         <td><input  class="form-control" readonly="readonly" name="owner_idx" value="${ vo.owner_idx }" style="width: 30%;"></td>
			      </tr> -->
			      
			      <!-- 이름 -->
			      <tr>
			         <th>이름</th>
			         <td><input  class="form-control" name="owner_name" value="${ vo.owner_name }" style="width: 30%;" readonly></td>
			      </tr>

			      
			      <!-- 아이디 -->
			      <tr>
			         <th>아이디</th>
			         <td>
			             <input  class="form-control"  name="owner_id"  value="${ vo.owner_id }" style="width: 30%;" readonly="readonly">
			         </td>
			      </tr>
				  
				   <!-- 비밀번호 -->
				   <tr>
					<th>비밀번호</th>
					<td><input  class="form-control" required="required" type="password"  name="owner_pwd"  
								value="${ vo.owner_pwd }" style="width: 30%;"></td>
				 </tr>
				 
				 <!-- 이메일 -->
				 <tr>
					<th>이메일</th>
					<td><input  class="form-control"  required="required"  type="email" name="owner_email" 
								value="${ vo.owner_email }" style="width: 30%;">
					</td>
				 </tr>

				 <tr>
					<th>사업자 번호 사본</th>
					<td>
						<input  class="form-control"  name="owner_id"  value="${ vo.owner_id }" style="width: 30%;" readonly="readonly">
					</td>
				 </tr>


			    <tr>
					<th>승인 상태</th>
					<td>
						<input  class="form-control"  name="owner_status"  value="${ vo.owner_status }" style="width: 30%;" readonly="readonly">
					</td>
				 </tr>
			      


			      
			     
			      <!-- 버튼 -->
			      <tr>
			         <td colspan="2" align="center">
			             <input class="btn btn-success" type="button"  value="목록보기" onclick="location.href='list.do'">
			             <input class="btn btn-primary" type="button"  value="수정하기" onclick="send(this.form);">
			             <input class="btn btn-primary" type="button"  value="탈퇴하기" onclick="location.href='delete.do?owner_idx=${sessionScope.user.owner_idx}';">
			         </td>
			      </tr> 
			   
			   </table>
			
			</div>
		</div>

	</div>
</form>

</body>
</html>