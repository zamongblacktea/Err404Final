<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


<!-- bootstrap 3.x 사용설정 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>


<style type="text/css">
  #box{
     float: right;
     width: 1200px;
     margin: auto;
     margin-top: 50px;
     margin-right: 40px;
  }
  
  #title{
     text-align: center;
     font-size: 28px;
     font-weight: bold;
     color: green;
     
     text-shadow: 1px 1px 2px black;
  }
  
  td{
    vertical-align: middle !important;
  }
  
  .bar{
      float: left;


  }
</style>

<!-- SweetAlert2 설정 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script type="text/javascript">

  function del(mem_idx){
	  
	  //삭제 확인?                           (취소)
	  //if(confirm("정말 삭제 하시겠습니까?")==false) return;
	  Swal.fire({
		  title: "정말 삭제 하시겠습니까?",
		  html: "<font color='red'>삭제버튼 클릭시 회원정보가 삭제됩니다</font>",
		  icon: "question",
		  showCancelButton: true,
		  confirmButtonColor: "#3085d6",
		  cancelButtonColor: "#d33",
		  confirmButtonText: "삭제",
		  cancelButtonText: "취소"
		}).then((result) => {
		  if (result.isConfirmed) { //삭제버튼 클릭
		    
			  //삭제처리       delete.do?mem_idx=1
			  location.href = "delete.do?mem_idx=" + mem_idx;	// MemberDeleteAction  
		  }
		});
	  
	  
	  
	  
	  
	  
	  
  }

</script>


</head>
<body>
   <div class="bar">
      <%@ include file="member_bar.jsp" %>

   </div>
<div id="box">

  
  <h1 id="title">::::회원 목록::::</h1>
  
  <!-- 로그인/회원가입  -->
  
  <div class="row"  style="margin-top: 30px; margin-bottom: 5px;">
    <div class="col-sm-3 col-md-3" >
      <input class="btn btn-primary"  type="button" value="회원가입" 
	            onclick="location.href='insert_form.do'">
    </div>
    <div class="col-sm-9 col-md-9" style="text-align: right">
     
      <!-- 로그인이 안되었을 경우(session에 user가 없냐?) -->
      <c:if test="${ empty sessionScope.user }">
	      <input class="btn btn-primary"  type="button" value="로그인" 
		            onclick="location.href='login_form.do'">
	  </c:if>  
	  
	  <!-- 로그인이 되어있을 경우(session에 user가 있냐?) -->
      <c:if test="${ not empty sessionScope.user }">
          <b>${ user.mem_name }</b>님 환영합니다
	      <input class="btn btn-primary"  type="button" value="로그아웃" 
		         onclick="location.href='logout.do'">
	  </c:if>             
	            
	            
    </div>
  </div>
   
  
  
  <!-- 회원목록 출력 -->
  <table class="table table-hover">
     <!-- title -->
     <tr class="info">
        <th>번호</th>
        <th>이름</th>
        <th>아이디</th>
        <th>비밀번호</th>
        <th>닉네임</th>
        <th>이메일</th>
        <th>주소</th>
        <th>아이피</th>
        <th>가입일자</th>
        <th>등급</th>
        
        <!-- 로그인 유저가 관리자면 -->
        <c:if test="${ sessionScope.user.mem_grade eq '관리자' }">
           <th>편집</th>
        </c:if>
        
     </tr>
     
     <!-- 데이터 출력 -->
     
     <!-- 데이터가 없을경우 -->
     <c:if test="${ empty list }">
        <tr>
           <td colspan="10" align="center">
              <font color="red">가입된 회원정보가 없습니다</font>
           </td>
        </tr>
     </c:if>
     
     <!-- 데이터가 있는경우 -->
     <!-- for(MemberVo vo : list) 동일  -->
     <c:forEach var="vo" items="${ list }">
        <tr>
           <td>${ vo.mem_idx }</td>
           <td>${ vo.mem_name }</td>
           <td>${ vo.mem_id }</td>
           <td>${ vo.mem_pwd }</td>
           <td>${ vo.mem_nickname }</td>
           <td>${ vo.mem_email }</td>
           <td>${ vo.mem_zipcode } ${ vo.mem_curaddr }</td>
           <td>${ vo.mem_ip }</td>
           <td>${ vo.mem_regdate }</td>
           <td>${ vo.mem_grade }</td>
           
           <!-- 로그인 유저가 관리자면 -->
           <c:if test="${ sessionScope.user.mem_grade eq '관리자' }">
	           <td>
	               <input class="btn btn-success" type="button"  value="수정"
	                      onclick="location.href='modify_form.do?mem_idx=${ vo.mem_idx }'" >
	                      
	               <input class="btn btn-danger"  type="button"  value="삭제"
	                      onclick="del('${ vo.mem_idx }');">
	           </td>
           </c:if>
           
        </tr>
     </c:forEach>
     
     
     
  </table>

</div>

</body>
</html>