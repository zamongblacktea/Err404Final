<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>내가 쓴 리뷰</title>

  <!-- Bootstrap 3.4.1 CSS -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />

  <!-- jQuery -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

  <!-- Bootstrap 3.4.1 JS -->
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

  <style>

    .review-card {
      background: white;
      border-radius: 10px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      padding: 1.5rem;
      margin-bottom: 2rem;
    }
    .review-header {
      display: flex;
      align-items: center;
      margin-bottom: 1rem;
    }
    .user-icon, .owner-icon {
      width: 50px;
      height: 50px;
      background-color: #ddd;
      border-radius: 50%;
      display: flex;
      justify-content: center;
      align-items: center;
      font-size: 24px;
      font-weight: bold;
      margin-right: 1rem;
      color: #555;
    }
    .review-meta {
      font-size: 0.9rem;
      color: gray;
    }
    .star-rating {
      color: #ffc107;
      margin-bottom: 0.5rem;
    }
    .owner-reply {
      background-color: #f2f6fa;
      border-radius: 10px;
      padding: 1rem;
      margin-top: 1rem;
      display: flex;
      align-items: flex-start;
    }
    .review-content {
      margin-bottom: 1rem;
    }
  </style>
</head>

<body>

  <div class="container">
    <c:forEach var="vo" items="${list}">
      <div class="review-card">

        <!-- 공통 리뷰 표시 -->
        <div class="review-header">
          <div class="user-icon">U</div>
          <div>
            <h5 class="mb-0">${vo.mem_nickname}</h5>
            <div class="review-meta">${vo.menu_name}</div>
            <div class="review-meta">${vo.timeAgo}</div>
          </div>
        </div>

        <div class="star-rating">
          평점 : ${vo.review_rating}
        </div>

        <div class="review-content">
          ${vo.review_content}
          <div>
            <img src="../../../images/${vo.review_img}" style="max-width:300px; height:300px;">
          </div>
        </div>

        <c:choose>


          <c:when test="${vo.review_available == 1}">

          </c:when>

          <c:when test="${vo.review_available == 2}">
            <div class="owner-reply">
              <div class="owner-icon">O</div>
              <div class="ms-3" style="flex: 1;">
                <strong>사장님 답글</strong><br>
                <div>${vo.reply_content}</div>
              </div>
            </div>
          </c:when>

        </c:choose>

      </div>
    </c:forEach>
  </div>

</body>
</html>

