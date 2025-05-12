<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="${pageContext.request.contextPath}/images/잇띵로고최종.png" type="image/x-icon">

<!-- bootstrap 3.x 사용설정 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>


<style type="text/css">
  #box{
     width: 1400px;
     margin: auto ;
     margin-top: 50px;
     margin-right: 140px;
     text-align: center;
  }
  
  
  #title{
     text-align: center;
     font-size: 28px;
     font-weight: bold;
     color: green;
     
     text-shadow: 1px 1px 2px black;
  }

  th{
          text-align: center;
        }

  
  td{
    vertical-align: middle !important;
    height: 50px;
  }

  
  .bar{
      float: left;


  }
</style>

<!-- SweetAlert2 설정 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script type="text/javascript">

  function del(owner_idx){
	  
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
		    
			  //삭제처리       delete.do?owner_idx=1
			  location.href = "delete.do?owner_idx=" + owner_idx;	// MemberDeleteAction  
		  }
		});
	  
	  
	  
	  
	  
	  
	  
  }

</script>


</head>
<body>
   <div class="bar">
      <%@ include file="admin_bar.jsp" %>

   </div>
<div id="box">

  
  <h1 id="title">::::승인 페이지::::</h1>
  
  <!-- 로그인/회원가입  -->
  
  <div class="row"  style="margin-top: 50px; margin-bottom: 20px;">
    <div class="col-sm-4 col-md-4" >
			<!-- 검색메뉴 -->
<!--           
         <form class="form-inline">
            <div class="form-group">
              <select id="search" class="form-control">
                <option value="all">전체</option>
                <option value="owner">사장님</option>
                <option value="rider">라이더</option>
              </select>
            </div>
          
            <div class="form-group" style="margin-left: 10px;">
              <input class="form-control" id="search_text" value="${param.search_text}">
            </div>
          
            <div class="form-group" style="margin-left: 10px;">
              <input class="btn btn-primary" type="button" value="검색" onclick="find();">
            </div>
          </form> -->
          
        
    </div>
    <div class="col-sm-8 col-md-8" style="text-align: right">
     
	  
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
        <th>사업자 번호</th>
        <th>승인 여부</th>
        <th></th>
        
        <!-- 로그인 유저가 관리자면 -->
        <c:if test="${ sessionScope.user.mem_grade eq '관리자' }">

        </c:if>
        
     </tr>
     
     <!-- 데이터 출력 -->
     
     <!-- 데이터가 없을경우 -->
     <c:if test="${ (empty owner_list) and (empty rider_list) }">
        <tr>
           <td colspan="10" align="center">
              <font color="red">가입된 회원정보가 없습니다</font>
           </td>
        </tr>
     </c:if>
     
     <!-- 데이터가 있는경우 -->
     <!-- for(MemberVo vo : list) 동일  -->
     <c:forEach var="vo" items="${ owner_list }">
        <tr>
           <td>${ vo.owner_idx }</td>
           <td>${ vo.owner_name }</td>
           <td>${ vo.owner_id }</td>
           <td>${ vo.owner_email }</td>
           <td><img src="../images/${vo.owner_num}" alt="사업자 이미지" style="width: 100px; cursor: pointer;" data-toggle="modal" data-target="#riderImageModal"></td>
            
           <td>${ vo.owner_approve }</td>
           
           <!-- 로그인 유저가 관리자면 -->
           <c:if test="${ sessionScope.user.mem_grade eq '관리자' && vo.owner_approve eq '대기'}">
	           <td>
	               <input class="btn btn-success" type="button"  value="승인"
	                      onclick="location.href='owner_approval.do?owner_idx=${ vo.owner_idx }'" >
	                  
	           </td>
           </c:if>
           
        </tr>
     </c:forEach>
     
     
     
  </table>

</div>
<!-- modal -->
      <div class="modal fade" id="riderImageModal" tabindex="-1" role="dialog" aria-labelledby="riderImageModalLabel">
        <div class="modal-dialog" role="document">
          <div class="modal-content">

            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
              <h4 class="modal-title" id="riderImageModalLabel">사업자 이미지</h4>
            </div>

            <div class="modal-body text-center">
              <img id="modalImage" src="" class="img-responsive center-block" alt="라이더 이미지">
            </div>

          </div>
        </div>
      </div>


      <!-- 이미지 변경 스크립트 -->
      <script>
        $(document).ready(function () {
          $('img[data-toggle="modal"]').on('click', function () {
            $('#modalImage').attr('src', $(this).attr('src'));
          });
        });
      </script>
</body>
</html>