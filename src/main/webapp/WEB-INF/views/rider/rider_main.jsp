<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>라이더 배달현황페이지</title>
  </head>
  <body>
    <!-- 바인딩해둔곳 추가하기 -->
    라이더 페이지 ${rider_id}님 환영합니다.
    <div class="nav">
      <input type="button" value="로그아웃" />

      <input type="button" value="마이페이지" />
    </div>



    <div class="panel panel-default">
      <div class="panel-heading">라이더 배달 현황</div>
      <div class="panel-body">
        <div class="body">
          <!-- onclick=location.href="넣어야함" -->
          <input type="button" value="주문대기" />
          <input type="button" value="배달현황" />
          <input type="button" value="배달완료" />
        </div>

      </div>
    </div>
  </body>
</html>
