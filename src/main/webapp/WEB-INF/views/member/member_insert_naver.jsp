<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <html lang="en">

  <head>
    <meta charset="UTF-8">
    <!-- bootstrap 사용설정 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="icon" href="${pageContext.request.contextPath}/images/잇띵로고최종.png" type="image/x-icon">
    <!-- 다음 주소검색 API -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <!-- css,js -->
    <link rel="stylesheet" href="/css/memberSignUp.css">
    <script src="/js/memberSignUp.js"></script>

    <title>간편 회원가입</title>
   
  </head>

  <body>
    <div class="signup-container">
      <h2>간편 회원 가입</h2>
      <form>
        <input type="hidden" name="mem_id" value="${param.naver_id}">
        <input type="hidden" name="mem_email" value="${param.mem_email}">
        <input type="hidden" name="mem_type" value="${param.mem_type}">
        <table class="table">
            

          <!-- 이름 -->
          <tr>
            <th>이름</th>
            <td><input class="form-control" required="required" name="mem_name" value="${param.mem_name}">
            </td>
          </tr>

          <!-- 닉네임 -->
          <tr>
            <th>닉네임</th>
            <td><input class="form-control" required="required" name="mem_nickname">
            </td>
          </tr>

          
          <!-- 전화번호 -->
          <tr>
            <th>전화번호</th>
            <td><input type="tel" name="mem_phone" pattern="^01[016789]-\d{3,4}-\d{4}$" placeholder="휴대전화 번호 입력" required></td>
            </td>
          </tr>

          <!-- 우편번호 -->
          <tr>
            <th>우편번호</th>
            <td>
              <input class="form-control" required="required" style="width: 30%;" id="mem_zipcode" >
              <input class="btn btn-info" type="button" value="주소검색" onclick="find_curaddr();">
            </td>
          </tr>

          <!-- 주소 -->
          <tr>
            <th>주소</th>
            <td><input class="form-control" required="required" name="mem_addr" id="mem_addr"
                style="width: 100%;">
            </td>
          </tr>

          <tr>
            <th>상세 주소</th>
            <td><input class="form-control" required="required" name="mem_addr2" id="mem_addr2"
                style="width: 100%;">
            </td>
          </tr>


          <!-- 버튼 -->
          <tr>
            <td colspan="2" align="center">
              <button type="button" onclick="send(this.form)">회원가입</button>
            </td>
          </tr>

        </table>

      </form>
    </div>


  </body>

  </html>