<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>배달 리뷰 작성</title>
      <!-- 기존 3.7.1 제거하고 ↓ 이렇게 교체 -->
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
      <style>
        .container{
          width: 500px;

        }

        .star-rating {
          font-size: 2rem;
          color: #ddd;
          cursor: pointer;
        }

        .star-rating .filled {
          color: #ffc107;
        }

        textarea {
          resize: none;
        }

        .menu-nickname, .menu-menu,.menu-content{

          margin-top: 20px;

        }

      </style>

<script>



  function send(f) {
    let rating = document.getElementById("ratingValue").value;
    let content = f.review_content.value.trim();
    let photo = f.photo.value;

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
        <form id="reviewForm" enctype="multipart/form-data">

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
            <div class="menu-nickname">
              <label class="form-label">닉네임</label>
              <div>
                <h5>${ user.mem_nickname }</h5>   
              </div>
            </div>

            <!-- 메뉴 -->
            <div class="menu-menu" >
              <label class="form-label">메뉴</label>
              <div>
                <h6>${ order.menu_name }</h6>
              </div>
            </div>


            <!-- 내용 + 이미지 업로드 -->
            <div class="menu-content">
              <label for="reviewContent" class="form-label">내용</label>
              <textarea id="reviewContent" class="form-control" rows="5" name="review_content"
                placeholder="리뷰 내용을 입력해주세요"></textarea>
              <input type="file" id="reviewImage" class="form-control mt-2" accept="image/*" name="photo">
            </div>

          <!-- 버튼 -->
          <div class="form-group text-right" style="margin-top: 30px;">
            <!-- <button type="button" class="btn btn-default" onclick="location.href='review_list.do?mem_idx=${param.mem_idx}'">취소</button> -->
            <button type="button" class="btn btn-primary" onclick="submitForm();">등록</button>
          </div>

        </form>
      </div>
    </div>
  </div>

  <script>
    function submitForm() {
      const formData = new FormData($("#reviewForm")[0]);
      const mem_idx = "${param.mem_idx}";

      $.ajax({
        url: "insert_review.do",
        type: "POST",
        data: formData,
        processData: false,
        contentType: false,
        success: function (response) {
          alert("리뷰가 성공적으로 등록되었습니다.");
          $('#myModal').modal('hide');

        // 강제 오버레이 제거
        setTimeout(function () {
          $('body').removeClass('modal-open');
          $('.modal-backdrop').remove();
          $('#myModal').hide(); // 혹시 남아 있으면 강제로 숨김
        }, 300);

          //내 리뷰 페이지로 이동
          loadContent("my_review.do");
        },
        error: function (xhr, status, error) {
          alert("등록 오류가 발생했습니다: " + error);
        },
      });
    }
  </script>

</body>
</html>