<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>마이 페이지</title>
  
    <!-- Poppins 폰트 -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600&display=swap" rel="stylesheet">

    <!-- Boxicons 아이콘 -->
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet"/>
    <!-- bootstrap 사용설정 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <!-- 다음 주소검색 API -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <!-- css -->
    <link rel="stylesheet" href="/css/myPage.css">


  <script type="text/javascript">

    const regular_email = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;

    function send(f) {

        //입력값 체크
        let mem_idx = f.mem_idx.value;
        let mem_name = f.mem_name.value.trim();
        let mem_zipcode = f.mem_zipcode.value.trim();
        let mem_addr = f.mem_addr.value.trim();
        let mem_phone = f.mem_phone.value;

        if (mem_name == "") {

            alert("이름을 입력하세요!");
            f.mem_name.value = "";
            f.mem_name.focus();
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


        f.action = "modify.do";// MemberModifyAction
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
                 $("#mem_curaddr").val(data.address);
        
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

    <div class="form-wrapper">
        <form>
            <h3>마이 페이지</h3>
            <hr>
          <!-- mem_idx (hidden) -->
          <input type="hidden" name="mem_idx" value="${vo.mem_idx}">
      
          <!-- 이름 -->

          <div class="input-group">
            <i class='bx bxs-user' style="margin-top: 16px;"></i>
        	<input type="text" style="margin: auto; width: 35%; margin-top: 30px;" name="mem_name" value="${vo.mem_name}" readonly placeholder="이름" />
          </div>
          <!-- 아이디 -->
          <div class="input-group">
            <i class='bx bx-id-card' style="margin-top: 10px;"></i>
            <input type="text" name="mem_id" value="${vo.mem_id}" readonly placeholder="아이디" style="width: 35%;"/>
          </div>
      
          <!-- 닉네임 -->
          <div class="input-group">
            <i class='bx bx-user' style="margin-top: 10px;"></i>
            <input type="text" name="mem_nickname" value="${vo.mem_nickname}" placeholder="닉네임" required style="width: 35%;"/>
          </div>
      
          <!-- 전화번호 -->
          <div class="input-group">
            <i class='bx bx-phone' style="margin-top: 10px;"></i>
            <input type="text" name="mem_phone" value="${vo.mem_phone}" placeholder="휴대전화 번호 입력" required style="width: 35%;" />
          </div>

          <!-- 연동 SNS -->
          <div class="input-group">
            <i class='bx bx-link' style="margin-top: 10px;"></i>
            <input type="text" name="mem_type" value="${vo.mem_type}" readonly placeholder="연동 SNS" style="width: 25%;" />
          </div>
      
          <!-- 우편번호 -->
          <div class="input-group">
            <i class='bx bx-map' style="margin-top: 10px;"></i>
            <input type="text" name="mem_zipcode" id="mem_zipcode" value="${vo.mem_zipcode}" placeholder="우편번호" required style="display: inline-block; width: 23%;">
          </div>
          <!-- 주소 -->
          <div class="input-group">
            <i class='bx bx-home' style="margin-top: 10px;"></i>
            <input type="text" name="mem_addr" id="mem_addr" value="${vo.mem_addr}" placeholder="주소" required />
          </div>
          <div>
            <button type="button" class="btn btn-sm btn-info" onclick="find_curaddr();" style="width: 20%; margin-top: 15px; margin-left: 260px;">주소검색</button>
          </div>
      
          <!-- 버튼 -->
          <div class="input-group" style="display: flex; ">
            <!-- <button type="button" class="btn btn-secondary" onclick="location.href='../main/main.do'" style="width: 20%; margin-right: 50px; margin-top: 20px;">목록보기</button> -->
            <button type="button" class="btn btn-primary" onclick="send(this.form);" style="width: 20%; margin: auto; margin-top: 30px;">수정하기</button>
          </div>
          <div style="clear: both;"></div>
        </form>
      </div>
      

</body>
</html>
