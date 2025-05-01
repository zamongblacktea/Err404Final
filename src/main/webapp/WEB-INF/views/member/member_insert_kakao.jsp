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


    <title>간편 회원가입</title>
    <style>
      :root {
        --green: #ff6b3f;
        --text-light: rgba(0, 0, 0, 0.5);
      }

      body {
        margin: 0;
        padding: 0;
        font-family: 'Segoe UI', sans-serif;
        background: #f9f9f9;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
      }

      .signup-container {
        width: 400px;
        background: #fff;
        box-shadow: 0 0 70px rgba(0, 0, 0, 0.05);
        border-top: 5px solid var(--green);
        padding: 40px 30px;
        box-sizing: border-box;
      }

      .signup-container h2 {
        color: var(--green);
        text-transform: uppercase;
        font-size: 18px;
        font-weight: bold;
        margin: 0 0 30px;
      }

      .signup-container input {
        width: 100%;
        margin: 10px;
        padding: 10px 0;
        border: none;
        border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        outline: none;
        font-size: 14px;
        color: #333;
        transition: border-color 0.2s ease-out;
      }

      .signup-container input:valid {
        border-bottom: 1px solid var(--green);
      }

      .signup-container input:focus:invalid {
        border-bottom: 1px solid #EF6161;
      }

      .signup-container ::placeholder {
        color: var(--text-light);
      }

      .signup-container button {
        margin-top: 40px;
        padding: 10px 25px;
        background-color: var(--green);
        color: #fff;
        font-weight: bold;
        font-size: 14px;
        border: none;
        border-radius: 25px;
        cursor: pointer;
        transition: all 0.2s ease-out;
      }

      .signup-container button:hover {
        background-color: #fff;
        color: var(--green);
        border: 2px solid var(--green);
      }

      th {
        width: 100px;
        vertical-align: middle !important;
      }
    </style>

    <script>
      const regular_email = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;

      function send(f) {

        //입력값 체크
        let mem_name = f.mem_name.value.trim();
        let mem_nickname = f.mem_nickname.value.trim();
        let mem_phone = f.mem_phone.value.trim();
        let mem_addr1 = f.mem_zipcode.value;
        let mem_addr2  = f.mem_addr.value;




        if (mem_name == "") {

          alert("이름을 입력하세요!");
          f.mem_name.value = "";
          f.mem_name.focus();
          return;
        }


        if (mem_nickname == "") {

          alert("닉네임을 입력하세요!");
          f.mem_nickname.value = "";
          f.mem_nickname.focus();
          return;
        }

        if (mem_zipcode == "") {

          alert("우편번호 입력하세요!");
          f.mem_zipcode.value = "";
          f.mem_zipcode.focus();
          return;
        }

        if (mem_addr == "") {

          alert("주소를 입력하세요!");
          f.mem_addr.value = "";
          f.mem_addr.focus();
          return;
        }

        if (mem_phone == "") {

        alert("전화번호를 입력하세요!");
        f.mem_phone.value = "";
        f.mem_phone.focus();
        return;
        }



        f.action = "insert.do"// MemberInsertAction
        f.submit();

      }//end:send()

      //주소검색
      function find_curaddr() {

        /* new daum.Postcode({
           oncomplete: function(data) {
             // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
             // 예제를 참고하여 다양한 활용법을 확인해 보세요.
             //data : JOSN형식
             //  data = { "zonecode":"06789", "address":"서울시 관악구 남부순환로 111", .... }
             //console.log(data);
             $("#mem_zipcode").val(data.zonecode);
             $("#mem_addr").val(data.address);
          
           }
         }).open(); */


        const width = 500; //팝업의 너비
        const height = 600; //팝업의 높이
        new daum.Postcode({
          width: width, //생성자에 크기 값을 명시적으로 지정해야 합니다.
          height: height,
          oncomplete: function (data) {
            //data : JOSN형식
            //  data = { "zonecode":"06789", "address":"서울시 관악구 남부순환로 111", .... }
            //console.log(data);
            $("#mem_zipcode").val(data.zonecode);
            $("#mem_addr").val(data.address);

          }
        }).open({
          left: (window.screen.width / 2) - (width / 2),
          top: (window.screen.height / 2) - (height / 2)
        });


      }



    </script>
  </head>

  <body>
    <div class="signup-container">
      <h2>간편 회원 가입</h2>
      <form>
        <input type="hidden" name="mem_id" value="${param.mem_id}">
        <input type="hidden" name="mem_type" value="${param.mem_type}">
        <table class="table">
            

          <!-- 이름 -->
          <tr>
            <th>이름</th>
            <td><input class="form-control" required="required" name="mem_name" >
            </td>
          </tr>

          <!-- 닉네임 -->
          <tr>
            <th>닉네임</th>
            <td><input class="form-control" required="required" name="mem_nickname" value="${param.mem_nickname}">
            </td>
          </tr>

          <!-- 전화번호 -->
          <tr>
            <th>전화번호</th>
            <td><input type="tel" name="mem_phone" value="${mem_phone}" pattern="^01[016789]-\d{3,4}-\d{4}$" placeholder="휴대전화 번호 입력" required></td>
            </td>
          </tr>

          <!-- 우편번호 -->
          <tr>
            <th>우편번호</th>
            <td>
              <input class="form-control" required="required" id="mem_zipcode" name="mem_zipcode" style="width: 30%;">
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