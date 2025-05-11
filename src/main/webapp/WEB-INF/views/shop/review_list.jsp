<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
      <!DOCTYPE html>
      <html lang="ko">

      <head>
        <meta charset="UTF-8">
        <title>가게 리뷰 목록</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <style>

          .review-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            padding: 1.5rem;
            margin-bottom: 2rem;
            width: 1000px;
            margin: 30px auto;
          }

          .review-header {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
          }

          .user-icon,
          .owner-icon {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 24px;
            font-weight: bold;
            margin-right: 1rem;

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
          .owner-icon img {
          width: 100%;
          height: 100%;
          object-fit: cover; /* 비율 무시하고 div에 딱 맞게 채우기 */
          overflow: hidden;  
          display: block;
        }
        .user-icon img {
          width: 100%;
          height: 100%;
          object-fit: cover; /* 비율 무시하고 div에 딱 맞게 채우기 */
          overflow: hidden;  
          display: block;
        }
        </style>
        <script>
          function sendReply(reviewIdx) {
            const replyContent = $("#reply_content_" + reviewIdx).val().trim();
            const ownerIdx = $("#owner_idx_" + reviewIdx).val();
            const orderIdx = $("#order_idx_" + reviewIdx).val();
            const shopIdx = $("#shop_idx_" + reviewIdx).val();
            const memIdx = $("#mem_idx_" + reviewIdx).val();

            if (replyContent === "") {
              alert("답글을 입력해주세요.");
              return;
            }

            $.ajax({
              url: '/shop/reply_insert.do',
              type: 'POST',
              contentType: 'application/json',
              data: JSON.stringify({
                reply_content: replyContent,
                owner_idx: ownerIdx,
                order_idx: orderIdx,
                review_idx: reviewIdx,
                shop_idx: shopIdx,
                mem_idx: memIdx,
              }),
              success: function (response) {
                alert('답글 등록 완료');
                loadContent("review_list.do");
              },
              error: function (xhr, status, error) {
                alert('등록 실패: ' + error);
              }
            });
          }
        </script>
      </head>

      <body>

        <div class="container">
          <c:forEach var="vo" items="${list}">
            <div class="review-card">

              <!-- 공통 리뷰 표시 -->
              <div class="review-header">
                <div class="user-icon"><img src="/images/user.png"></div>
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
                  <img src="../../../images/${vo.review_img}" onerror="this.onerror=null; this.style.display='none'" style="max-width:300px; height:300px;">
                </div>
              </div>

              <c:choose>


                <c:when test="${vo.review_available == 1}">
                  <form>
                    <input type="hidden" id="order_idx_${vo.review_idx}" value="${vo.order_idx}">
                    <input type="hidden" id="mem_idx_${vo.review_idx}" value="${vo.mem_idx}">
                    <input type="hidden" id="shop_idx_${vo.review_idx}" value="${vo.shop_idx}">
                    <input type="hidden" id="owner_idx_${vo.review_idx}" value="${user.owner_idx}">
                    <div class="owner-reply">
                      <div class="owner-icon"><img src="/images/owner.png"></div>
                      <div class="ms-3" style="flex: 1;">
                        <strong>사장님 답글</strong><br>
                        <div style="display: flex; align-items: center; margin-top: 10px; gap: 10px;">
                          <textarea style="width: 100%; height: 200px; resize: none;" name="reply_content"
                            id="reply_content_${vo.review_idx}" placeholder="답글을 입력하세요."></textarea>

                          <input type="button" class="btn btn-primary" value="답글"
                            onclick="sendReply('${vo.review_idx}')" style="height: 200px;">
                        </div>
                      </div>
                    </div>
                  </form>
                </c:when>

                <c:when test="${vo.review_available == 2}">
                  <div class="owner-reply">
                    <div class="owner-icon"><img src="/images/owner.png"></div>
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