<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>배달 리뷰 작성</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

  <style>
    .container{
      width: 500px;
      margin: auto;

    }
    .star-rating {
      font-size: 24px;
      color: gray;
      cursor: pointer;
    }
    .star-rating .filled {
      color: gold;
    }
    textarea {
      resize: none;
    }
    .form-section {
      margin-top: 20px;
    }
  </style>

<script>
  function send(f) {
    var rating = document.getElementById("ratingValue").value;
    var content = f.review_content.value.trim();
    if (!content) {
      alert("리뷰 내용을 입력해주세요.");
      f.review_content.focus();
      return;
    }
    if (rating === "0" || rating === "") {
      alert("별점을 선택해주세요.");
      return;
    }
    f.action = "insert_review.do";
    f.method = "POST";
    f.submit();
  }

  // 별점 처리
  $('#starRating span').click(function () {
    var value = $(this).data('value');
    $('#ratingValue').val(value);

    $('#starRating span').each(function () {
      $(this).css('color', $(this).data('value') <= value ? 'gold' : 'gray');
    });
  });
</script>
</head>

<body>
  <div class="container" style="margin-top: 40px;">
    <div class="panel panel-default">
      <div class="panel-heading"><h3 class="panel-title">리뷰 작성</h3></div>
      <div class="panel-body">
        <form method="POST" enctype="multipart/form-data">

          <input type="hidden" name="mem_idx" value="${param.mem_idx}">
          <input type="hidden" name="shop_idx" value="${param.shop_idx}">
          <input type="hidden" name="menu_idx" value="${param.menu_idx}">
          <input type="hidden" name="order_idx" value="${order.order_idx}">
          <input type="hidden" name="menu_name" value="${order.menu_name}">
          <input type="hidden" name="delivery_idx" value="${param.delivery_idx}">
          <input type="hidden" name="mem_nickname" value="${user.mem_nickname}">
          <input type="hidden" name="shop_name" value="${shop.shop_name}">

          <!-- 별점 -->
          <div class="form-group">
            <label>별점</label>
            <div id="starRating" class="star-rating">
              <span data-value="1">★</span>
              <span data-value="2">★</span>
              <span data-value="3">★</span>
              <span data-value="4">★</span>
              <span data-value="5">★</span>
            </div>
          </div>
          <input type="hidden" id="ratingValue" name="review_rating" value="0">

          <!-- 닉네임 -->
          <div class="form-group form-section">
            <label>닉네임</label>
            <p class="form-control-static">${user.mem_nickname}</p>
          </div>

          <!-- 메뉴 -->
          <div class="form-group form-section">
            <label>메뉴</label>
            <p class="form-control-static">${order.menu_name}</p>
          </div>

          <!-- 내용 -->
          <div class="form-group form-section">
            <label for="reviewContent">내용</label>
            <textarea id="reviewContent" class="form-control" rows="5" name="review_content"
              placeholder="리뷰 내용을 입력해주세요"></textarea>
            <input type="file" id="reviewImage" class="form-control" accept="image/*" name="photo" style="margin-top: 10px;">
          </div>

          <!-- 버튼 -->
          <div class="form-group text-right" style="margin-top: 30px;">
            <button type="button" class="btn btn-default" onclick="location.href='review_list.do?mem_idx=${param.mem_idx}'">취소</button>
            <button type="button" class="btn btn-primary" onclick="send(this.form)">등록</button>
          </div>

        </form>
      </div>
    </div>
  </div>

</body>
</html>
