<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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

      textarea{
        resize: none;
        width: 60%;
        height: 100px;
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

        // 체크박스 상태를 숨겨진 input에 반영
        const isCloseDay = document.getElementById("shop_closeday").checked;
        // document.getElementById("shop_closeday").value = isCloseDay ? shop_closeday : "연중무휴";

        const formData = new FormData(f);

        // 휴무일 값 수동 추가
        let closedayArray = [];
        document.querySelectorAll('input[name="shop_closeday"]:checked').forEach((checkbox) => {
          closedayArray.push(checkbox.value);
        });
        formData.set("shop_closeday", closedayArray.join(","));

        $.ajax({
          url: "modify.do",
          type: "POST",
          data: formData,
          processData: false,
          contentType: false,
          success: function (result) {
            alert("가게 정보가 수정되었습니다");
            location.href = "main.do";
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
        formData.append("shop_idx", "${shop.shop_idx}");
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
        formData.append("shop_idx", "${shop.shop_idx}");
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
    <h2>가게정보수정</h2>
    <!-- 가게 로고 선택/폼 -->
    <form method="POST" enctype="multipart/form-data" id="ajaxFormLogo" style="display: none">
      <input type="file" id="ajaxFileLogo" onchange="ajaxFileLogoChange();" />
    </form>

    <!-- 가게 이미지 선택/폼 -->
    <form method="POST" enctype="multipart/form-data" id="ajaxFormImg" style="display: none">
      <input type="file" id="ajaxFileImg" onchange="ajaxFileImgChange();" />
    </form>

    <div style="display: flex; justify-content: center; gap: 20px;" >
    <!-- shop_logo 이미지 수정 -->
    <div style="text-align: center; padding: 10px">
      <p>가게 로고</p>
      <img id="my_logo" src="${pageContext.request.contextPath}/images/${shop.shop_logo}" style="width: 100px; height: 100px" /><br /><br />
      <input class="btn btn-info" type="button" value="로고 수정" onclick="logo_update();" />
    </div>

    <!-- shop_img 이미지 수정 -->
    <div style="text-align: center; padding: 10px">
      <p>가게 이미지</p>
      <img id="my_img" src="${pageContext.request.contextPath}/images/${shop.shop_img}" style="width: 100px; height: 100px" /><br /><br />
      <input class="btn btn-info" type="button" value="이미지 수정" onclick="img_update();" />
    </div>
  </div>

    <form class="form-inline" enctype="multipart/form-data">
      <input type="hidden" name="shop_idx" value="${shop.shop_idx}" />
      <input type="hidden" name="shop_logo" id="shop_logo" value="${shop.shop_logo}" />
      <input type="hidden" name="shop_img" id="shop_img" value="${shop.shop_img}" />
      <div id="box">
        
          
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
                  <option value="1" ${shop.shop_cate_idx == 1 ? 'selected' : ''}>치킨</option>
                  <option value="2" ${shop.shop_cate_idx == 2 ? 'selected' : ''}>피자/양식</option>
                  <option value="3" ${shop.shop_cate_idx == 3 ? 'selected' : ''}>중국집</option>
                  <option value="4" ${shop.shop_cate_idx == 4 ? 'selected' : ''}>한식</option>
                  <option value="5" ${shop.shop_cate_idx == 5 ? 'selected' : ''}>일식/돈까스</option>
                  <option value="6" ${shop.shop_cate_idx == 6 ? 'selected' : ''}>족발/보쌈</option>
                  <option value="7" ${shop.shop_cate_idx == 7 ? 'selected' : ''}>야식</option>
                  <option value="8" ${shop.shop_cate_idx == 8 ? 'selected' : ''}>분식</option>
                  <option value="9" ${shop.shop_cate_idx == 9 ? 'selected' : ''}>카페/디저트</option>
                  </select>
                </td>
              </tr>

              <!-- 배달료 -->
              <tr>
                <th>배달료</th>
                <td><input class="form-control" required="required" name="shop_dfee" style="width: 30%;" value="${shop.shop_dfee}" /></td>
              </tr>

              <!-- 가게 공지 -->
              <tr>
                <th>가게공지</th>
                <td><textarea class="form-control" required="required" name="shop_notice" style="width: 60%; height: 100px;">${shop.shop_notice}</textarea></td>
              </tr>

              <!-- 소개글 -->
              <tr>
                <th>소개글</th>
                <td><textarea class="form-control" required="required" name="shop_intro" style="width: 60%; height: 100px;">${shop.shop_intro}</textarea></td>
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
                  <c:choose>
                    <c:when test="${fn:contains(shop.shop_closeday, 'Monday')}">
                      <input type="checkbox" name="shop_closeday" id="monday" value="Monday" checked />
                      <label for="monday">월요일</label>
                    </c:when>
                    <c:otherwise>
                      <input type="checkbox" name="shop_closeday" id="monday" value="Monday" />
                      <label for="monday">월요일</label>
                    </c:otherwise>
                  </c:choose>

                  <c:choose>
                    <c:when test="${fn:contains(shop.shop_closeday, 'Tuesday')}">
                      <input type="checkbox" name="shop_closeday" id="tuesday" value="Tuesday" checked />
                      <label for="tuesday">화요일</label>
                    </c:when>
                    <c:otherwise>
                      <input type="checkbox" name="shop_closeday" id="tuesday" value="Tuesday" />
                      <label for="tuesday">화요일</label>
                    </c:otherwise>
                  </c:choose>

                  <c:choose>
                    <c:when test="${fn:contains(shop.shop_closeday, 'Wednesday')}">
                      <input type="checkbox" name="shop_closeday" id="wednesday" value="Wednesday" checked />
                      <label for="wednesday">수요일</label>
                    </c:when>
                    <c:otherwise>
                      <input type="checkbox" name="shop_closeday" id="wednesday" value="Wednesday" />
                      <label for="wednesday">수요일</label>
                    </c:otherwise>
                  </c:choose>

                  <c:choose>
                    <c:when test="${fn:contains(shop.shop_closeday, 'Thursday')}">
                      <input type="checkbox" name="shop_closeday" id="thursday" value="Thursday" checked />
                      <label for="thursday">목요일</label>
                    </c:when>
                    <c:otherwise>
                      <input type="checkbox" name="shop_closeday" id="thursday" value="Thursday" />
                      <label for="thursday">목요일</label>
                    </c:otherwise>
                  </c:choose>

                  <c:choose>
                    <c:when test="${fn:contains(shop.shop_closeday, 'Friday')}">
                      <input type="checkbox" name="shop_closeday" id="friday" value="Friday" checked />
                      <label for="friday">금요일</label>
                    </c:when>
                    <c:otherwise>
                      <input type="checkbox" name="shop_closeday" id="friday" value="Friday" />
                      <label for="friday">금요일</label>
                    </c:otherwise>
                  </c:choose>

                  <c:choose>
                    <c:when test="${fn:contains(shop.shop_closeday, 'Saturday')}">
                      <input type="checkbox" name="shop_closeday" id="saturday" value="Saturday" checked />
                      <label for="saturday">토요일</label>
                    </c:when>
                    <c:otherwise>
                      <input type="checkbox" name="shop_closeday" id="saturday" value="Saturday" />
                      <label for="saturday">토요일</label>
                    </c:otherwise>
                  </c:choose>

                  <c:choose>
                    <c:when test="${fn:contains(shop.shop_closeday, 'Sunday')}">
                      <input type="checkbox" name="shop_closeday" id="sunday" value="Sunday" checked />
                      <label for="sunday">일요일</label>
                    </c:when>
                    <c:otherwise>
                      <input type="checkbox" name="shop_closeday" id="sunday" value="Sunday" />
                      <label for="sunday">일요일</label>
                    </c:otherwise>
                  </c:choose>

                  <!-- 연중무휴 체크박스를 처리하는 로직 -->
                  <input type="hidden" name="shop_closeday" id="shop_closeday" value="" />
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
                  <!-- <input class="btn btn-success" type="button" value="목록보기" onclick="location.href='../main/list.do'" /> -->
                  <input class="btn btn-primary" type="button" value="정보수정" onclick="send(this.form);" id="btn_register" />
                </td>
              </tr>
            </table>
          </div>
    </form>
  </body>
</html>
