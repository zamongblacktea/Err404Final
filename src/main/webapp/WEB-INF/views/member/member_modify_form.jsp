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
	   let mem_name 	= f.mem_name.value.trim();
	   let mem_pwd  	= f.mem_pwd.value.trim();
	   let mem_email	= f.mem_email.value;
	   let mem_zipcode 	= f.mem_zipcode.value.trim();
	   let mem_curaddr 	= f.mem_curaddr.value.trim();
	   
	   if(mem_name == ""){
		   
		   alert("이름을 입력하세요!");
		   f.mem_name.value="";
		   f.mem_name.focus();
		   return;
	   }
	   
	   if(mem_pwd == ""){
		   
		   alert("비밀번호 입력하세요!");
		   f.mem_pwd.value="";
		   f.mem_pwd.focus();
		   return;
	   }
	   
	   if(regular_email.test(mem_email)==false){
		   
		   alert("형식이 맞는 이메일을 입력하세요!");
		   f.mem_email.value="";
		   f.mem_email.focus();
		   return;
	   }
	   
	   if(mem_zipcode == ""){
		   
		   alert("우편번호 입력하세요!");
		   f.mem_zipcode.value="";
		   f.mem_zipcode.focus();
		   return;
	   }
	   
	   if(mem_curaddr == ""){
		   
		   alert("주소를 입력하세요!");
		   f.mem_curaddr.value="";
		   f.mem_curaddr.focus();
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
	            $("#mem_zipcode").val(data.zonecode);
	            $("#mem_curaddr").val(data.address);
	   
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
	            $("#mem_zipcode").val(data.zonecode);
	            $("#mem_curaddr").val(data.address);
	   
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
	   $("#mem_grade").val("${ vo.mem_grade }");
	   
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
			      <tr>
			         <th>회원번호</th>
			         <td><input  class="form-control" readonly="readonly" name="mem_idx" value="${ vo.mem_idx }" style="width: 30%;"></td>
			      </tr>
			      
			      <!-- 이름 -->
			      <tr>
			         <th>이름</th>
			         <td><input  class="form-control" required="required" name="mem_name" value="${ vo.mem_name }" style="width: 30%;"></td>
			      </tr>
			      
			      <!-- 아이디 -->
			      <tr>
			         <th>아이디</th>
			         <td>
			             <input  class="form-control"  name="mem_id"  value="${ vo.mem_id }" style="width: 30%;" readonly="readonly">
			         </td>
			      </tr>
			      
			      <!-- 비밀번호 -->
			      <tr>
			         <th>비밀번호</th>
			         <td><input  class="form-control" required="required" type="password"  name="mem_pwd"  
			                     value="${ vo.mem_pwd }" style="width: 30%;"></td>
			      </tr>
			      
			      <!-- 이메일 -->
			      <tr>
			         <th>이메일</th>
			         <td><input  class="form-control"  required="required"  type="email" name="mem_email" 
			                     value="${ vo.mem_email }" style="width: 30%;">
			         </td>
			      </tr>
			      
			      <!-- 우편번호 -->
			      <tr>
			         <th>우편번호</th>
			         <td>
			            <input  class="form-control"  required="required" id="mem_zipcode" name="mem_zipcode" 
			                    value="${ vo.mem_zipcode }" style="width: 30%;">
			            <input  class="btn btn-info"  type="button" value="주소검색" onclick="find_curaddr();">   
 		             </td>
			      </tr>
			      
			      <!-- 주소 -->
			      <tr>
			         <th>주소</th>
			         <td><input  class="form-control"  required="required"   name="mem_curaddr" id="mem_curaddr" 
			                     value="${ vo.mem_curaddr }" style="width: 100%;"></td>
			      </tr>
			      
			      <!-- 등급  -->
			      <tr>
			         <th>등급</th>
			         <td>
			             <select class="form-control"  name="mem_grade" id="mem_grade">
			                <option value="일반">일반</option>
			                <option value="관리자">관리자</option>
			             </select> 
			         </td>
			      </tr>
			      
			     
			      <!-- 버튼 -->
			      <tr>
			         <td colspan="2" align="center">
			             <input class="btn btn-success" type="button"  value="목록보기" onclick="location.href='list.do'">
			             <input class="btn btn-primary" type="button"  value="수정하기" onclick="send(this.form);">
			         </td>
			      </tr> 
			   
			   </table>
			
			</div>
		</div>

	</div>
</form>

</body>
</html>