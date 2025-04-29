<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  </head>

  <body>
    <c:forEach var="review" items="${review}">

      <input type="hidden" id="shop_idx" name="shop_idx" value="${review.shop_idx}">
      <input type="hidden" id="mem_idx" name="mem_idx" value="${review.mem_idx}">
      <div class="review-box">
        <div> 이름 : ${ review.mem_nickname }</div>
        <div> <img id="review_img" src="../../../images/${ review.review_img }"></div>
        <div> 평점 : ${ review.review_rating }</div>
        <!-- 내용 + 이미지 업로드 -->
        <div class="menu-content">
          <label for="reviewContent" class="form-label">내용</label>
          <textarea id="reviewContent" class="form-control" rows="5" >${review.review_content}</textarea>
        </div>
    </div>
    </c:forEach>      
  </body>
</html>
