<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>리뷰 페이지 테스트</title>

  <!-- Bootstrap 3.4.1 CSS -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />

  <!-- jQuery -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

  <!-- Bootstrap 3.4.1 JS -->
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

</head>

<body>

  <c:forEach var="review" items="${review}">
    <div class="review-card" style="width: 700px; margin: auto;">
      <div class="review-header">
        <div class="user-icon">U</div>
        <input type="hidden" id="shop_idx" name="shop_idx" value="${review.shop_idx}">
        <input type="hidden" id="mem_idx" name="mem_idx" value="${review.mem_idx}">
        <div>
          <h5 class="mb-0">${ review.mem_nickname }</h5>
          <div class="review-meta">어제, 테스트 업로드</div>
        </div>
      </div>

      <div class="star-rating">
        평점 : ${ review.review_rating }
      </div>

      <div class="review-content">
        ${review.review_content}
        <div><img src="../../../images/${ review.review_img }" style="max-width:300px; height:300px;"></div>
      </div>

      <!-- 사장님 댓글 -->
      <div class="owner-reply">
        <div class="owner-icon">O</div>
        <div class="ms-3">
          <strong>사장님 답글</strong><br>
          <p>테스트 회원님, 소중한 리뷰 감사드립니다!<br>
          앞으로도 신선한 재료와 정성으로 보답하겠습니다. 또 방문해주세요!</p>
        </div>
      </div>
    </div>
  </c:forEach>



</body>
</html>

