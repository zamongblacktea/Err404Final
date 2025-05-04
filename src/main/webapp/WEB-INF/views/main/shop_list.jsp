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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/shop_list.css">


  </head>
  <body>
    <div class="navbar">
      <%@ include file="navbar.jsp" %>
    </div>
    <div class="header">
      <form id="search_form" action="">
          <input type="text" id="search" class="form-control">
          <input type="button" class="btn btn-info btn_search" value="검색" onclick="">
      </form>
  </div>
    <div class="category">
      <%@ include file="catebar.jsp"%>
    </div>
    <div id="main">

      <div class="list">
           
         <div id="category_display"></div>
        
      </div>
      </div>
    </div>
    <footer>풋터</footer>
  </body>
</html>
