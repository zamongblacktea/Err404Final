<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>

    <!-- bootstrap 사용설정 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <!-- 다음 주소검색 API -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <style type="text/css">
      #box {
        width: 800px;
        margin: auto;
        margin-top: 80px;
      }

      th {
        width: 130px;
        vertical-align: middle !important;
      }

      #id_msg {
        margin-left: 10px;
      }
    </style>

    <script type="text/javascript">
      function send(f) {
        //입력값 체크
        let shop_name = f.shop_name.value.trim();
        let shop_company = f.shop_company.value.trim();
        let shop_bnumber = f.shop_bnumber.value.trim();
        let shop_cate_idx = f.shop_cate_idx.value.trim();
        let shop_addr1 = f.shop_addr1.value.trim();
        let shop_addr2 = f.shop_addr2.value.trim();
        let shop_phone = f.shop_phone.value.trim();
        let shop_dfee = f.shop_dfee.value.trim();
        let shop_notice = f.shop_notice.value.trim();
        let shop_intro = f.shop_intro.value.trim();
        let shop_minprice = f.shop_minprice.value.trim();
        let shop_mintime = f.shop_mintime.value.trim();
        let shop_maxtime = f.shop_maxtime.value.trim();
        let shop_optime = f.shop_optime.value.trim();
        let shop_cltime = f.shop_cltime.value.trim();
        let shop_closeday = f.shop_closeday.value.trim();
        let shop_loc = f.shop_loc.value.trim();

        if (shop_name == "") {
          alert("가게명을 입력하세요");
          f.shop_name.value = "";
          f.shop_name.focus();
          return;
        }

        if (shop_company == "") {
          alert("상호명을 입력하세요");
          f.shop_company.value = "";
          f.shop_company.focus();
          return;
        }

        if (shop_bnumber == "") {
          alert("사업자번호를 입력하세요");
          f.shop_bnumber.value = "";
          f.shop_bnumber.focus();
          return;
        }

        if (shop_cate_idx == "") {
          alert("가게 카테고리를 입력하세요");
          f.shop_cate_idx.value = "";
          f.shop_cate_idx.focus();
          return;
        }

        if (shop_addr1 == "") {
          alert("주소를 입력하세요");
          f.shop_addr1.value = "";
          f.shop_addr1.focus();
          return;
        }

        if (shop_phone == "") {
          alert("가게 전화번호를 입력하세요");
          f.shop_phone.value = "";
          f.shop_phone.focus();
          return;
        }
        if (shop_dfee == "") {
          alert("배달료를 입력하세요");
          f.shop_dfee.value = "";
          f.shop_dfee.focus();
          return;
        }
        if (shop_notice == "") {
          alert("가게공지를 입력하세요");
          f.shop_notice.value = "";
          f.shop_notice.focus();
          return;
        }
        if (shop_intro == "") {
          alert("소개글을 입력하세요");
          f.shop_intro.value = "";
          f.shop_intro.focus();
          return;
        }
        if (shop_minprice == "") {
          alert("최소주문금액을 입력하세요");
          f.shop_minprice.value = "";
          f.shop_minprice.focus();
          return;
        }
        if (shop_mintime == "") {
          alert("최소배달예상시간을 입력하세요");
          f.shop_mintime.value = "";
          f.shop_mintime.focus();
          return;
        }
        if (shop_maxtime == "") {
          alert("최대배달예상시간을 입력하세요");
          f.shop_maxtime.value = "";
          f.shop_maxtime.focus();
          return;
        }
        if (shop_optime == "") {
          alert("오픈시간을 입력하세요");
          f.shop_optime.value = "";
          f.shop_optime.focus();
          return;
        }
        if (shop_cltime == "") {
          alert("클로즈타임을 입력하세요");
          f.shop_cltime.value = "";
          f.shop_cltime.focus();
          return;
        }
        if (shop_loc == "") {
          alert("배달지역을 입력하세요");
          f.shop_loc.value = "";
          f.shop_loc.focus();
          return;
        }

        // f.action = "modify.do"; // ShopModifyAction
        // f.submit();

        const formData = new FormData(f);

        $.ajax({
          url: "modify.do",
          type: "POST",
          data: formData,
          processData: false,
          contentType: false,
          success: function (result) {
            alert("가게 정보가 수정되었습니다");
            location.href = "order_list.do";
          },
          error: function (err) {
            alert(err.responseText);
          },
        });
      } //end:send()

      //주소검색
      function find_addr() {
        const width = 500; //팝업의 너비
        const height = 600; //팝업의 높이
        new daum.Postcode({
          width: width, //생성자에 크기 값을 명시적으로 지정해야 합니다.
          height: height,
          oncomplete: function (data) {
            //data : JOSN형식
            //  data = { "zonecode":"06789", "address":"서울시 관악구 남부순환로 111", .... }
            //console.log(data);
            $("#shop_addr1").val(data.address);
          },
        }).open({
          left: window.screen.width / 2 - width / 2,
          top: window.screen.height / 2 - height / 2,
        });
      }

      // db를 select box에 띄우는 작업 - 카테고리

      document.addEventListener("DOMContentLoaded", function () {
        const selectedCate = "${shop.shop_cate_idx}";
        const selectedClo = "${shop.shop_closeday}";

        if (selectedCate) {
          document.getElementById("cate-select").value = selectedCate;
        }
        if (selectedClo) {
          document.getElementById("close-select").value = selectedClo;
        }
      });
    </script>

    <!-- 이미지 수정 코드 -->
    <script>
      function img_update() {
        $("#ajaxFileImg").click();
      }

      function logo_update() {
        $("#ajaxFileLogo").click();
      }

      function ajaxFileImgChange(type) {
        //파일 선택이 취소되면
        if ($("#ajaxFileImg")[0].files[0] == undefined) return;
        // Ajax를 이용해서 파일 업로드
        const form = $("#ajaxFormImg")[0];
        const formData = new FormData(form);
        // 전송 해야할 parameter 세팅
        formData.append("shop_idx", "${vo.shop_idx}");
        formData.append("photo", $("#ajaxFileImg")[0].files[0]);

        // Ajax 전송
        $.ajax({
          url: "photo_upload.do",
          type: "POST",
          data: formData,
          processData: false,
          contentType: false,
          dataType: "json",
          success: function (res_data) {
            $("#my_img").attr("src", "${pageContext.request.contextPath}/images/" + res_data.shop_img);
            $("#shop_img").val(res_data.shop_img);
          },
          error: function (err) {
            alert(err.responseText);
            console.log(err);
          },
        });
      }

      function ajaxFileLogoChange() {
        //파일 선택이 취소되면
        if ($("#ajaxFileLogo")[0].files[0] == undefined) return;

        // Ajax를 이용해서 파일 업로드
        const form = $("#ajaxFormLogo")[0];
        const formData = new FormData(form);
        // 전송 해야할 parameter 세팅
        formData.append("shop_idx", "${vo.shop_idx}");
        formData.append("photo", $("#ajaxFileLogo")[0].files[0]);

        // Ajax 전송
        $.ajax({
          url: "logo_upload.do",
          type: "POST",
          data: formData,
          processData: false,
          contentType: false,
          dataType: "json",
          success: function (res_data) {
            $("#my_logo").attr("src", "${pageContext.request.contextPath}/images/" + res_data.shop_logo);
            $("#shop_logo").val(res_data.shop_logo);
          },
          error: function (err) {
            alert(err.responseText);
            console.log(err);
          },
        });
      }
    </script>
  </head>
  <body>
    <!-- 가게 로고 선택/폼 -->
    <form method="POST" enctype="multipart/form-data" id="ajaxFormLogo" style="display: none">
      <input type="file" id="ajaxFileLogo" onchange="ajaxFileLogoChange();" />
    </form>

    <!-- 가게 이미지 선택/폼 -->
    <form method="POST" enctype="multipart/form-data" id="ajaxFormImg" style="display: none">
      <input type="file" id="ajaxFileImg" onchange="ajaxFileImgChange();" />
    </form>

    <!-- shop_logo 이미지 수정 -->
    <div style="text-align: center; padding: 10px">
      <img id="my_logo" src="${pageContext.request.contextPath}/images/${vo.shop_logo}" style="width: 100px; height: 100px" /><br /><br />
      <input class="btn btn-info" type="button" value="로고 수정" onclick="logo_update();" />
    </div>

    <!-- shop_img 이미지 수정 -->
    <div style="text-align: center; padding: 10px">
      <img id="my_img" src="${pageContext.request.contextPath}/images/${vo.shop_img}" style="width: 100px; height: 100px" /><br /><br />
      <input class="btn btn-info" type="button" value="이미지 수정" onclick="img_update();" />
    </div>

    <form class="form-inline" enctype="multipart/form-data">
      <input type="hidden" name="shop_idx" value="${vo.shop_idx}" />
      <div id="box">
        <div class="panel panel-primary">
          <div class="panel-heading"><h4>가게정보수정</h4></div>
          <div class="panel-body">
            <table class="table">
              <!-- 이름 -->
              <tr>
                <th>가게명</th>
                <td><input class="form-control" required="required" name="shop_name" style="width: 30%" value="${shop.shop_name}" /></td>
              </tr>

              <!-- 아이디 -->
              <tr>
                <th>상호명</th>
                <td>
                  <input class="form-control" id="shop_company" name="shop_company" style="width: 30%" value="${shop.shop_company}" />
                </td>
              </tr>

              <!-- 사업자번호 -->
              <tr>
                <th>사업자번호</th>
                <td><input class="form-control" required="required" type="text" name="shop_bnumber" style="width: 30%" value="${shop.shop_bnumber}" /></td>
              </tr>

              <!-- 주소 -->
              <tr>
                <th>가게주소</th>
                <td>
                  <input class="form-control" required="required" name="shop_addr1" id="shop_addr1" style="width: 50%" value="${shop.shop_addr1}" />
                  <input class="btn btn-info" type="button" value="주소검색" onclick="find_addr();" />
                  <input class="form-control" name="shop_addr2" id="shop_addr2" style="width: 50%" placeholder="상세주소입력" value="${shop.shop_addr2}" />
                </td>
              </tr>

              <!-- 가게전화번호 -->
              <tr>
                <th>가게전화번호</th>
                <td><input class="form-control" required="required" type="tel" name="shop_phone" style="width: 30%" value="${shop.shop_phone}" /></td>
              </tr>

              <!-- 가게 카테고리 -->
              <tr>
                <th>가게 카테고리</th>
                <td>
                  <select name="shop_cate_idx" class="form-control" id="cate-select">
                    <option value="1">치킨</option>
                    <option value="2">피자/양식</option>
                    <option value="3">중국집</option>
                    <option value="4">한식</option>
                    <option value="5">일식/돈까스</option>
                    <option value="6">족발/보쌈</option>
                    <option value="7">야식</option>
                    <option value="8">분식</option>
                    <option value="9">카페/디저트</option>
                  </select>
                </td>
              </tr>

              <!-- 배달료 -->
              <tr>
                <th>배달료</th>
                <td><input class="form-control" required="required" name="shop_dfee" style="width: 30%" value="${shop.shop_dfee}" /></td>
              </tr>

              <!-- 가게 공지 -->
              <tr>
                <th>가게공지</th>
                <td><textarea class="form-control" required="required" name="shop_notice">${shop.shop_notice}</textarea></td>
              </tr>

              <!-- 소개글 -->
              <tr>
                <th>소개글</th>
                <td><textarea class="form-control" required="required" name="shop_intro">${shop.shop_intro}</textarea></td>
              </tr>

              <!-- 최소주문금액 -->
              <tr>
                <th>최소주문금액</th>
                <td><input class="form-control" required="required" name="shop_minprice" style="width: 30%" value="${shop.shop_minprice}" /></td>
              </tr>

              <!-- 최소배달예상시간 -->
              <tr>
                <th>최소배달예상시간</th>
                <td><input class="form-control" required="required" name="shop_mintime" style="width: 30%" value="${shop.shop_mintime}" /></td>
              </tr>

              <!-- 최대배달예상시간 -->
              <tr>
                <th>최대배달예상시간</th>
                <td><input class="form-control" required="required" name="shop_maxtime" style="width: 30%" value="${shop.shop_maxtime}" /></td>
              </tr>

              <!-- 오픈타임 -->
              <tr>
                <th>오픈타임</th>
                <td><input class="form-control" required="required" type="time" name="shop_optime" style="width: 30%" value="${shop.shop_optime}" /></td>
              </tr>

              <!-- 클로즈타임 -->
              <tr>
                <th>클로즈타임</th>
                <td><input class="form-control" required="required" type="time" name="shop_cltime" style="width: 30%" value="${shop.shop_cltime}" /></td>
              </tr>

              <!-- 휴무일 -->
              <tr>
                <th>휴무일</th>
                <td>
                  <!-- <input type="checkbox" name="shop_closeday" id="" value="" /><label for="">연중무휴</label>&nbsp;
                  <input type="checkbox" name="shop_closeday" id="monday" value="monday" /><label for="monday"> 월</label>&nbsp;
                  <input type="checkbox" name="shop_closeday" id="tuesday" value="tuesday" /><label for="tuesday"> 화</label>&nbsp;
                  <input type="checkbox" name="shop_closeday" id="wednesday" value="wednesday" /><label for="wednesday"> 수</label>&nbsp;
                  <input type="checkbox" name="shop_closeday" id="thursday" value="thursday" /><label for="thursday"> 목</label>&nbsp;
                  <input type="checkbox" name="shop_closeday" id="friday" value="friday" /><label for="friday"> 금</label>&nbsp;
                  <input type="checkbox" name="shop_closeday" id="saturday" value="saturday" /><label for="saturday"> 토</label>&nbsp;
                  <input type="checkbox" name="shop_closeday" id="sunday" value="sunday" /><label for="sunday"> 일</label> -->

                  <select name="shop_closeday" class="form-control" id="close-select">
                    <option value="">연중무휴</option>
                    <option value="Monday">월요일</option>
                    <option value="Tuesday">화요일</option>
                    <option value="Wednesday">수요일</option>
                    <option value="Thursday">목요일</option>
                    <option value="Friday">금요일</option>
                    <option value="Saturday">토요일</option>
                    <option value="Sunday">일요일</option>
                  </select>
                </td>
              </tr>

              <!-- 배달지역 -->
              <tr>
                <th>배달지역</th>
                <td><input class="form-control" required="required" type="text" name="shop_loc" style="width: 30%" value="${shop.shop_loc}" /></td>
              </tr>

              <!-- 버튼 -->
              <tr>
                <td colspan="2" align="center">
                  <input class="btn btn-success" type="button" value="목록보기" onclick="location.href='../main/list.do'" />
                  <input class="btn btn-primary" type="button" value="정보수정" onclick="send(this.form);" id="btn_register" />
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </form>
  </body>
</html>
