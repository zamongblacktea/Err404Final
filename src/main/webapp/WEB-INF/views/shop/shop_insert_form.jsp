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
	   let mem_addr 	= f.mem_addr.value.trim();
	   
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
	   
	   if(mem_addr == ""){
		   
		   alert("주소를 입력하세요!");
		   f.mem_addr.value="";
		   f.mem_addr.focus();
		   return;
	   }
	   	   
	   
	   f.action = "insert.do";// MemberInsertAction
	   f.submit();
	   
   }//end:send()

   
   //중복아이디 체크함수
   function check_id(){
	   //           document.getElementById("mem_id").value;  
	   let mem_id = $("#mem_id").val();
	   
	   //가입버튼 비활성화
	   $("#btn_register").prop("disabled",true);
	   
	   if(mem_id.length < 3){
		   $("#id_msg").html("아이디는 3자리 이상문자을 사용해야 합니다").css("color","red");
		   return;
	   }
	   
	   //$("#id_msg").html("사용가능한 아이디 입니다").css("color","blue");
	   
	   // 서버로 입력된 아이디를 전송->중복 아이디 체크
	   // Ajax통해서 background로 요청
	   $.ajax({
		   url		:	"check_id.do",     //MemberCheckIdAction
		   data 	:   {"mem_id": mem_id},//parameter  :  check_id.do?mem_id=hong
		   dataType	:   "json",            //결과수신을 JSON으로 받겠다		   
		   success	: function(res_data){
			   //                  사용가능                      이미사용중임  
			   //  res_data = {"result": true} or res_data = {"result": false}  
			   
			   if(res_data.result==true){
				   
				   $("#id_msg").html("사용가능한 아이디 입니다").css("color","blue");
				   
				   //가입버튼 활성화
				   //document.getElementById("btn_register").disabled = false;
				   $("#btn_register").prop("disabled",false);
				   
			   }else{
				   $("#id_msg").html("이미 사용중인 아이디 입니다").css("color","red");
			   }
			   
			   
		   },
		   error  	: function(err){
			   alert(err.responseText);
		   }
	   });
	   
   }//end:check_id()
     
   
   //주소검색
   function find_addr(){
	   const width  = 500; //팝업의 너비
	   const height = 600; //팝업의 높이
	   new daum.Postcode({
	       width: width, //생성자에 크기 값을 명시적으로 지정해야 합니다.
	       height: height,
	       oncomplete: function(data) {
	            //data : JOSN형식
	            //  data = { "zonecode":"06789", "address":"서울시 관악구 남부순환로 111", .... }
	            //console.log(data);
	            $("#shop_addr").val(data.address);
	   
	        }
	   }).open({
	       left: (window.screen.width / 2) - (width / 2),
	       top:  (window.screen.height / 2) - (height / 2)
	   });
	   
	   
   }
   
</script>

</head>
<body>

<form class="form-inline">
	<div id="box">

		<div class="panel panel-primary">
			<div class="panel-heading"><h4>가게정보입력</h4></div>
			<div class="panel-body">
			   
			   <table class="table">
			      
			      <!-- 이름 -->
			      <tr>
			         <th>가게명</th>
			         <td><input  class="form-control" required="required" name="shop_name" style="width: 30%;"></td>
			      </tr>
			      
			      <!-- 아이디 -->
			      <tr>
			         <th>상호명</th>
			         <td>
			             <input  class="form-control" id="shop_company" name="shop_company" style="width: 30%;">		         
			         </td>
			      </tr>
			      
			      <!-- 사업자번호 -->
			      <tr>
			         <th>사업자번호</th>
			         <td><input  class="form-control" required="required" type="text"  name="shop_bnumber" style="width: 30%;"></td>
			      </tr>
			      
			      
			      <!-- 주소 -->
			      <tr>
					  <th>가게주소</th>
					  <td>
						  <input  class="form-control"  required="required"   name="shop_addr" id="shop_addr"  style="width: 50%;">
						  <input  class="btn btn-info"  type="button" value="주소검색" onclick="find_addr();">   
						</td>
					</tr>
					
					<!-- 가게전화번호 -->
					<tr>
					   <th>가게전화번호</th>
					   <td><input  class="form-control"  required="required"  type="tel" name="shop_phone" style="width: 30%;"></td>
					</tr>
					
					<!-- 배달료 -->
					<tr>
					   <th>배달료</th>
					   <td><input  class="form-control"  required="required" name="shop_dfee" style="width: 30%;"></td>
					</tr>
					
					<!-- 가게로고 -->
					<tr>
					   <th>가게로고</th>
					   <td><input required="required"  type="file" name="shop_logo" style="width: 30%;"></td>
					</tr>
					
					<!-- 가게내부사진 -->
					<tr>
					   <th>가게내부사진</th>
					   <td><input required="required"  type="file" name="shop_img" style="width: 30%;"></td>
					</tr>
					
					<!-- 가게 공지 -->
					<tr>
					   <th>가게공지</th>
					   <td><textarea  class="form-control"  required="required" name="shop_notice"></textarea></td>
					</tr>
					
					<!-- 소개글 -->
					<tr>
					   <th>소개글</th>
					   <td><textarea class="form-control"  required="required" name="shop_intro"></textarea></td>
					</tr>
					
					<!-- 최소주문금액 -->
					<tr>
					   <th>최소주문금액</th>
					   <td><input  class="form-control"  required="required"  name="shop_minprice" style="width: 30%;"></td>
					</tr>
					
					<!-- 최소배달예상시간 -->
					<tr>
					   <th>최소배달예상시간</th>
					   <td><input  class="form-control"  required="required" name="shop_mintime" style="width: 30%;"></td>
					</tr>
					
					<!-- 최대배달예상시간 -->
					<tr>
					   <th>최대배달예상시간</th>
					   <td><input  class="form-control"  required="required" name="shop_maxtime" style="width: 30%;"></td>
					</tr>
					
					<!-- 오픈타임 -->
					<tr>
					   <th>오픈타임</th>
					   <td><input  class="form-control"  required="required"  type="time" name="shop_optime" style="width: 30%;"></td>
					</tr>

					<!-- 클로즈타임 -->
					<tr>
					   <th>클로즈타임</th>
					   <td><input  class="form-control"  required="required"  type="time" name="shop_cltime" style="width: 30%;"></td>
					</tr>
					
					<!-- 휴무일 -->
					<tr>
					   <th>휴무일</th>
					   <td><input  class="form-control"  required="required"  type="checkbox" name="shop_closeday" style="width: 30%;"></td>
					</tr>
					
					<!-- 배달지역 -->
					<tr>
					   <th>배달지역</th>
					   <td><input  class="form-control"  required="required"  type="text" name="shop_loc" style="width: 30%;"></td>
					</tr>
					
			      <!-- 버튼 -->
			      <tr>
			         <td colspan="2" align="center">
			             <input class="btn btn-success" type="button"  value="목록보기" onclick="location.href='../product/list.do'">
			             <input class="btn btn-primary" type="button"  value="정보입력" onclick="send(this.form);"
			                    id="btn_register"  disabled="disabled">
			         </td>
			      </tr> 
			   
			   </table>
			
			</div>
		</div>

	</div>
</form>

</body>
</html>