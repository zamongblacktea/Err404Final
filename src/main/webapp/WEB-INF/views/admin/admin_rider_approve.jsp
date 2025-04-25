<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="${pageContext.request.contextPath}/images/잇띵로고최종.png" type="image/x-icon">

<!-- bootstrap 사용설정 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>




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

  img{
   width: 200px;
   height: 100%;

  }
</style>

<!-- SweetAlert2 설정 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script type="text/javascript">

  function del(rider_idx){
	  
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
		    
			  //삭제처리       delete.do?rider_idx=1
			  location.href = "delete.do?rider_idx=" + rider_idx;	// MemberDeleteAction  
		  }
		});
	  
	  
	  
	  
	  
	  
	  
  }

</script>

<script>
   // 모든 이미지 클릭 이벤트 연결
   document.querySelectorAll('img[data-bs-toggle="modal"]').forEach(img => {
     img.addEventListener('click', function() {
       const modalImg = document.getElementById('modalImage');
       modalImg.src = this.src; // 클릭한 이미지의 경로를 모달에 넣음
     });
   });
 </script>
 


</head>
<body>
   <div class="bar">
      <%@ include file="admin_bar.jsp" %>

   </div>
<div id="box">

  
  <h1 id="title">::::승인 페이지::::</h1>
  
  <!-- 로그인/회원가입  -->
  
  <div class="row"  style="margin-top: 30px; margin-bottom: 5px;">
    <div class="col-sm-3 col-md-3" >
			<!-- 검색메뉴 -->

                <form class="form-inline"> 
                    <select id="search" class="form-control">
                       <option value="all">전체</option>
                       <option value="owner">사장님</option>
                       <option value="rider">라이더</option>
                    </select>
                    
                    <input class="form-control" id="search_text"  value="${ param.search_text }">
                    <input class="btn btn-primary" type="button"  value="검색"
                           onclick="find();">
                </form>
        
    </div>
    <div class="col-sm-9 col-md-9" style="text-align: right">
      
	  
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
        <th>이메일</th>
        <th>면허증 사진</th>
        <th>계좌번호</th>
        <th>승인 여부</th>
        <th></th>
        
        <!-- 로그인 유저가 관리자면 -->
        <c:if test="${ sessionScope.user.mem_grade eq '관리자' }">

        </c:if>
        
     </tr>
     
     <!-- 데이터 출력 -->
     
     <!-- 데이터가 없을경우 -->
     <c:if test="${ (empty rider_list) and (empty rider_list) }">
        <tr>
           <td colspan="10" align="center">
              <font color="red">가입된 회원정보가 없습니다</font>
           </td>
        </tr>
     </c:if>
     
     <!-- 데이터가 있는경우 -->
     <!-- for(MemberVo vo : list) 동일  -->
     <c:forEach var="vo" items="${ rider_list }">
        <tr>
           <td>${ vo.rider_idx }</td>
           <td>${ vo.rider_name }</td>
           <td>${ vo.rider_id }</td>
           <td>${ vo.rider_email }</td>
           <!-- <td><img src="../images/${ vo.rider_img }" > </td> -->
            <!-- 1. 이미지 (트리거 버튼 역할) -->
<td>
   <img src="../images/${vo.rider_img}"
   alt="라이더 이미지"
   style="width: 100px; cursor: pointer;"
   data-bs-toggle="modal"
   data-bs-target="#riderImageModal">
 </td>
 
           <td>${ vo.rider_account }</td>
           <td>${ vo.rider_approve }</td>
           
           <!-- 로그인 유저가 관리자면 -->
           <c:if test="${ sessionScope.user.mem_grade eq '관리자' }">
	           <td>
	               <input class="btn btn-success" type="button"  value="승인"
	                      onclick="location.href='rider_approval.do?rider_idx=${ vo.rider_idx }'" >
	                      
	               <input class="btn btn-danger"  type="button"  value="거부"
	                      onclick="del('${ vo.rider_idx }');">
	           </td>
           </c:if>


           
        </tr>
     </c:forEach>
     
     
     
  </table>

</div>

            <!-- 2. 모달 구조 -->
            <div class="modal fade" id="riderImageModal" tabindex="-1" aria-labelledby="riderImageModalLabel" aria-hidden="true">
               <div class="modal-dialog modal-dialog-centered">
                 <div class="modal-content">
                   
                   <div class="modal-header">
                     <h5 class="modal-title" id="riderImageModalLabel">라이더 이미지</h5>
                     <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
                   </div>
                   
                   <div class="modal-body text-center">
                     <img id="modalImage" src="" class="img-fluid" alt="라이더 이미지">
                   </div>
                   
                 </div>
               </div>
             </div>

<!-- 이미지 변경 스크립트 -->
<script>
   document.querySelectorAll('img[data-bs-toggle="modal"]').forEach(img => {
     img.addEventListener('click', function () {
       const modalImg = document.getElementById('modalImage');
       modalImg.src = this.src;
     });
   });
 </script>

</body>
</html>