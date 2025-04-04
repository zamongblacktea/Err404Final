<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
    <!-- bootstrap 사용설정 -->
    <link
      rel="stylesheet"
      href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
    />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  </head>
  <body>
    장바구니목록<br />
    가게명:
    <table class="table">
      <tr>
        <th>메뉴명</th>
        <th>수량</th>
        <th>가격</th>
        <th>총가격</th>
        <th></th>
      </tr>
      <tr>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td>
          <input type="button" class="btn btn-info" value="삭제" />
          <input type="button" class="btn btn-info" value="수정" />
        </td>
      </tr>
      <tr>
        <th>가격 :</th>
        <td></td>
      </tr>
    </table>
  </body>
</html>
