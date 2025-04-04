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

    <style type="text/css">
      #box {
        width: 800px;
        margin: auto;
        margin-top: 80px;
      }

      th {
        width: 100px;
        vertical-align: middle !important;
      }

      #id_msg {
        margin-left: 10px;
      }
    </style>

    <script type="text/javascript">
      // 메뉴 금액에 대한 수치범위 : 1~10
      const regular_number = /^[0-9]{1,10}$/;

      function send(f) {
        //입력값 체크
        let menu_name = f.menu_name.value.trim();
        let menu_price = f.menu_price.value;
        let menu_explain = f.menu_explain.value.trim();
        let menu_img = f.menu_img.value.trim();
        let menu_status = f.menu_status.value.trim();

        if (menu_name == "") {
          alert("메뉴명을 입력하세요!");
          f.menu_name.value = "";
          f.menu_name.focus();
          return;
        }

        if (menu_price == "") {
          alert("메뉴가격을 입력하세요!");
          f.menu_price.value = "";
          f.menu_price.focus();
          return;
        }

        if (regular_email.test(mem_email) == false) {
          alert("형식이 맞는 이메일을 입력하세요!");
          f.mem_email.value = "";
          f.mem_email.focus();
          return;
        }

        if (menu_explain == "") {
          alert("메뉴 설명을 입력하세요!");
          f.menu_explain.value = "";
          f.menu_explain.focus();
          return;
        }

        if (menu_img == "") {
          alert("메뉴사진을 입력하세요!");
          f.menu_img.value = "";
          f.menu_img.focus();
          return;
        }

        f.action = "insert.do"; // MenuInsertAction
        f.submit();
      } //end:send()
    </script>
  </head>
  <body>
    <form class="form-inline">
      <div id="box">
        <div class="panel panel-primary">
          <div class="panel-heading"><h4>메뉴정보입력</h4></div>
          <div class="panel-body">
            <table class="table">
              <!-- 메뉴명 -->
              <tr>
                <th>메뉴명</th>
                <td>
                  <input
                    class="form-control"
                    name="menu_name"
                    style="width: 30%"
                  />
                </td>
              </tr>

              <!-- 가격 -->
              <tr>
                <th>가격</th>
                <td>
                  <input
                    class="form-control"
                    name="menu_price"
                    style="width: 30%"
                  />
                </td>
              </tr>

              <!-- 메뉴설명 -->
              <tr>
                <th>메뉴설명</th>
                <td>
                  <textarea
                    class="form-control"
                    id="menu_explain"
                    name="menu-explain"
                  ></textarea>
                </td>
              </tr>

              <!-- 메뉴사진 -->
              <tr>
                <th>메뉴사진</th>
                <td>
                  <input
                    type="file"
                    name="menu_img"
                    id="menu_img"
                    style="width: 50%"
                  />
                </td>
              </tr>

              <!-- 메뉴상태 -->
              <tr>
                <th>메뉴상태</th>
                <td>
                  <input id="menu_pop" type="checkbox" name="menu_status" />
                  <label for="menu_pop">인기</label><br />
                  <input id="menu_hide" type="checkbox" name="menu_status" />
                  <label for="menu_hide">숨기기</label><br />
                  <input id="menu_soldout" type="checkbox" name="menu_status" />
                  <label for="menu_soldout">품절</label>
                </td>
              </tr>

              <!-- 버튼 -->
              <tr>
                <td colspan="2" align="center">
                  <input
                    class="btn btn-success"
                    type="button"
                    value="목록보기"
                    onclick="location.href='../product/list.do'"
                  />
                  <input
                    class="btn btn-primary"
                    type="button"
                    value="정보입력"
                    onclick="send(this.form);"
                    id="btn_register"
                    disabled="disabled"
                  />
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </form>
  </body>
</html>
