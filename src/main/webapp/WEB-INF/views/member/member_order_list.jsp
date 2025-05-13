<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/shop_order_list.css">
<!-- bootstrap 사용설정 -->
<!-- 기존 3.7.1 제거하고 ↓ 이렇게 교체 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
 <!-- 웹소캣 -->
 <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

<!-- modal -->
<script>
    $(document).ready(function () {
      $(document).off('click', '.openReviewModalBtn').on('click', '.openReviewModalBtn', function () {
  // AJAX 요청 처리
    });

   //리뷰 모달 열기
    $(document).on('click', '.openReviewModalBtn', function () {
      const mem_idx = $(this).data('mem-idx');
      const order_idx =  $(this).data("order-idx");


      $.ajax({
        url: '../member/review_form.do',
        type: 'GET',
        data: { 
                mem_idx : mem_idx,
                order_idx : order_idx 
              },
        success: function (data) {
          $('#reviewModalBody').html(data);
          $('#myModal').modal('show'); // Bootstrap 3 방식
        },
        error: function (xhr, status, error) {
          alert('로딩 실패: ' + error);
        }
      });
    });





        // 모달 닫기
        $(document).on('click', '.close-modal-btn', function () {
        $('#myModal').modal('hide');
        });

  });
</script>

  
</head>
<body>

     <!-- 주문 목록이 없을 때 메시지 표시 -->
     <c:if test="${empty list}">
        <p style="color: red; font-size: 30px;">주문목록이 없습니다.</p>
      </c:if>

        <c:forEach var="vo" items="${ list }">
          <div id="box">
            <div class="order_idx">
              ${ vo.order_idx }
            </div>
            <table class="table table-borderless order_text">
              <tr>
                <th>주문일자</th>
                <td>${ vo.order_regdate }</td>
              </tr>
              <tr>
                <th>주문가격</th>
                <td><fmt:formatNumber value="${vo.amount}" pattern="#,#00" />원</td>
              </tr>
              <tr>
                <th>고객 주소</th>
                <td>${ vo.mem_addr1 } ${ vo.mem_addr2 }</td>
              </tr>
              <tr>
                <th>주문요청사항</th>
                <td>${ vo.order_request }</td>
              </tr>
              <tr>
                <th>배달요청사항</th>
                <td>${ vo.rider_request }</td>
              </tr>
              <tr>
                <th>배달상태</th>
                <td>
                  ${vo.order_status}
                </td>
              </tr>
              <tr>
                <th>메뉴</th>
                <td>${ vo.menu_name }</td>
              </tr>
              <tr>
                <th>결제</th>
                <td>${ vo.pay_type }</td>
              </tr>
  
            </table>
            <div class="btn-div">  
              <c:if test="${vo.delivery_status eq '배달완료' && vo.review_available == 0 }">            
              <button class="btn status-btn openReviewModalBtn" data-mem-idx="${vo.mem_idx}" data-order-idx="${vo.order_idx}" style="font-weight: bold; font-size: 18px;" >리뷰쓰기</button>
              </c:if>
        
              
            </div>
        </div>

        </c:forEach>

        <!-- 모달 구조 -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
          <div class="modal-dialog">
            <div class="modal-content">
        
              <div class="modal-header">
              
                <h4 class="modal-title" id="myModalLabel">리뷰 작성</h4>
              </div>
        
              <div class="modal-body" id="reviewModalBody">

              </div>
        
              <div class="modal-footer">
                <!-- <button type="button" class="btn btn-primary" id="insertReview">등록</button> -->
                <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
              </div>
        
            </div>
          </div>
        </div>

</body>
</html>