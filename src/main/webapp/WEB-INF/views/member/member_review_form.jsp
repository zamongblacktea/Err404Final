<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>배달 리뷰 작성</title>
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
      <style>
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
          let mem_idx = f.mem_idx.value;
          let review_content = f.review_content.value;
          let shop_idx = f.shop_idx.value;
          let menu_idx = f.menu_idx.value;
          let menu_name = f.menu_name.value;
          let photo = f.photo.value.trim();
          let mem_nickname = f.mem_nickname.value;
          let delivery_idx = f.delivery_idx.value;
          let order_idx = f.order_idx.value;
          let shop_name = f.shop_name.value;
          const review_rating = f.querySelector('#ratingValue').value;
          //콘솔 출력
          console.log('선택한 별점:', review_rating);


          if (review_content == "") {

            alert("리뷰 내용을 입력해주세요.");
            f.review_content.value = "";
            f.review_content.focus();
            return;

          }

          if (review_rating === "0" || review_rating === "") {
            alert("별점을 선택해주세요.");

          }

          f.action = "insert_review.do";
          f.method = "POST";
          f.submit();

        }




      </script>
    </head>

    <body class="bg-light py-5">
      <div class="container">
        <div class="card shadow rounded-4 p-4">
          <form method="POST" enctype="multipart/form-data">
            <h2 class="mb-4">리뷰 작성</h2>
            <input type="hidden" value="${param.mem_idx}" name="mem_idx">
            <input type="hidden" value="${param.shop_idx}" name="shop_idx">
            <input type="hidden" value="${param.menu_idx}" name="menu_idx">
            <input type="hidden" value="${param.order_idx}" name="order_idx">
            <input type="hidden" value="${order.menu_name}" name="menu_name">
            <input type="hidden" value="${param.delivery_idx}" name="delivery_idx">
            <input type="hidden" value="${user.mem_nickname}" name="mem_nickname">
            <input type="hidden" value="${shop.shop_name}" name="shop_name">
            <!-- 별점 -->
            <div class="mb-3">
              <label class="form-label">별점</label>
              <div id="starRating" class="star-rating">
                <span data-value="1">★</span>
                <span data-value="2">★</span>
                <span data-value="3">★</span>
                <span data-value="4">★</span>
                <span data-value="5">★</span>
              </div>
            </div>
            <!-- 별점 value 저장용 input -->
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
            <div class="d-flex justify-content-end gap-2">
              <button class="btn btn-secondary"
                onclick="location.href='review_list.do?mem_idx=${ param.mem_idx }'">취소</button>
              <button class="btn btn-primary" onclick="send(this.form);">등록</button>
            </div>

          </form>
        </div>
      </div>

  <script>
    //별점 선택 함수
  document.querySelectorAll('#starRating span').forEach(star => {
  star.addEventListener('click', function () {
    const value = this.dataset.value;
    document.getElementById('ratingValue').value = value;

    // 선택한 별점 콘솔 확인
    console.log('선택한 별점:', value);

    // 별 색칠 효과 (선택사항)
    document.querySelectorAll('#starRating span').forEach(s => {
      s.style.color = s.dataset.value <= value ? 'gold' : 'gray';
    });
  });
});

  </script>
    </body>

    </html>