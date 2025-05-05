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
    <footer>풋터</footer>
  </body>
</html>
