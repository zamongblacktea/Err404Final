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
      </style>

      <script>
        function send(f) {
          let mem_idx         = f.mem_idx.value;
          let review_content  = f.review_content.value;
          let review_pwd      = f.review_pwd.value;
          let photo           = f.photo.value.trim();
          

          if (review_content == "") {

            alert("리뷰 내용을 입력해주세요.");
            f.review_content.value = "";
            f.review_content.focus();
            return;

          }

          if (review_rating === "0" || review_rating === "") {
            alert("별점을 선택해주세요.");

          }

          f.action = "review_insert.do";
          f.method = "POST";
          f.submit();

        }



      </script>
    </head>

    <body class="bg-light py-5">
      <div class="container">
        <div class="card shadow rounded-4 p-4">
          <form action="multipart/form-data">
            <h2 class="mb-4">리뷰 작성</h2>
            <input type="hidden" value="${mem_idx}" name="mem_idx">
            <!-- 별점 -->
            <div class="mb-3">
              <label class="form-label">별점</label>
              <div id="starRating" class="star-rating" >
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
            <div class="mb-3" style="float: left;">
              <label class="form-label">닉네임</label>
              <div>
                <h5>${ user.mem_nickname }</h5>
              </div>
            </div>

            <!-- 비밀번호 -->
            <div class="mb-3" style="float: right;">
              <label class="form-label">비밀번호</label>
              <div>
                <input type="password" name="review_pwd" required placeholder="비밀번호 입력">
              </div>
            </div>

            <!-- 내용 + 이미지 업로드 -->
            <div class="mb-3">
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
            <div style="clear: both;"></div>
          </form>
        </div>
      </div>

      <script>
        let selectedRating = 0;
        const stars = document.querySelectorAll('#starRating span');

        stars.forEach(star => {
          star.addEventListener('click', () => {
            selectedRating = parseInt(star.getAttribute('data-value'));
            updateStars();
          });
        });

        function updateStars() {
          stars.forEach(star => {
            const value = parseInt(star.getAttribute('data-value'));
            star.classList.toggle('filled', value <= selectedRating);
          });
        }

        function resetForm() {
          selectedRating = 0;
          updateStars();
          document.getElementById('reviewContent').value = '';
          document.getElementById('reviewImage').value = '';
        }

        function submitReview() {
          const content = document.getElementById('reviewContent').value;
          const image = document.getElementById('reviewImage').files[0];
          if (selectedRating === 0) {
            alert('별점을 선택해주세요.');
            return;
          }
          if (!content.trim()) {
            alert('내용을 입력해주세요.');
            return;
          }
          // 실제 등록 처리 로직은 여기에 추가
          alert(`등록 완료!\n별점: ${selectedRating}점\n내용: ${content}\n이미지: ${image ? image.name : '없음'}`);
          resetForm();
        }
      </script>
    </body>

    </html>