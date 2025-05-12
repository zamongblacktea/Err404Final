<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="icon" href="${pageContext.request.contextPath}/images/잇띵로고최종.png" type="image/x-icon">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/shop_list.css">
    
    <script>
      
    function find(){
    let keyword = document.getElementById("search").value;
    $.ajax({
      url   : "../main/search_list.do",
      data  : {"search": keyword},
      success :   function(res_data){     
                  $("#category_display").html(res_data);

      },
        error   :   function(err){
        alert(err.responseText)
      }
    });
  }

    // 영업시간 비교
    const today = new Date();
    const dayNames = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
    const todayDay = dayNames[today.getDay()]; // 오늘 요일 (영어)

    const now = new Date();
    const nowStr = now.toTimeString().slice(0, 5); // 예: "14:05"
    </script>


  </head>
  <body>
    <div class="navbar">
      <%@ include file="navbar.jsp" %>
    </div>
    <div class="header">
      <form id="search_form" action="">
          <input type="text" id="search" class="form-control" value="${param.search}" placeholder="메뉴를 검색해주세요.">
          <input type="button" class="btn btn-outline-success btn_search" value="검색" onclick="find();">
      </form>
  </div>
    <div class="category">
     
      <%@ include file="catebar.jsp"%>
    </div>
    <div id="main">

      <div class="list">
           
         <div id="category_display">
          <c:if test="${empty shop_list}">
            <p>검색 결과가 없습니다.</p>
          </c:if>
          <%@ include file="category_list.jsp" %>
         </div>
        
      </div>
      </div>
    </div>
	<div class="footer">
	
	<div class="footer-box" style="text-align: center; margin-top: 10px;"> 
	<p>주식회사 Eatting ｜ 공동대표 !Err404 박태섭 안소현 남가은 ｜ 서울특별시 관악구 청룡동 862-1 | http://www.gith.co.kr/</p>
	<p>고객센터: 02-6020-0052 (평일 오전 9시 ~ 오후 6시)</p>
	<p>Eatting은 통신판매 중개자로서 통신판매의 당사자가 아니며 상품 거래정보 및 거래 등에 대해 책임을 지지 않습니다.</p>
	<p>이용약관전자금거래 이용약관개인정보 처리방침</p>
	
	</div>
  </div>
  </body>
</html>
