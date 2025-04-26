<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  </head>
  <style>
    * {
      border: 1px solid black;
      margin: 0;
      padding: 0;
    }
    html,
    body {
      height: 100%;
      margin: 0;
    }

    .page {
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }

    .content {
      flex: 1;
    }

    #mybox {
      margin: 0 auto;
      /* width: 1150px; */
      /* width: 800px; */
      width: 750px;
      padding-left: 10px;
      display: inline-block;
    }

    table.table-borderless td,
    table.table-borderless th,
    table.table-borderless tr {
      border: none !important;
    }
  </style>

  <body>
    <div>가게 정보</div>
    <form>
      <input type="hidden" id="mem_idx" name="mem_idx" value="${user.mem_idx}" />
      <input type="hidden" id="shop_idx" name="shop_idx" value="${shop.shop_idx}" />

      <div class="row">
        <div class="notice">
          📢사장님 알림
          <hr />
          <div class="notice_content">${shop.shop_notice}</div>
        </div>
        <div class="intro">
          🤗가게 소개
          <hr />
          <div class="intro_content">${shop.shop_intro}</div>
        </div>
        <div class="info">
          🍴업체정보
          <hr />
          <div class="info_content">
            <table class="table table-borderless">
              <tr>
                <th>영업시간</th>
                <td>${shop.shop_optime} - ${shop.shop_cltime}</td>
              </tr>
              <tr>
                <th>전화번호</th>
                <td>${shop.shop_phone}</td>
              </tr>
              <tr>
                <th>주소</th>
                <td>${shop.shop_addr1} ${shop.shop_addr2}</td>
              </tr>
            </table>
          </div>
        </div>
        <div class="pay_info">
          💳결제 정보
          <hr />
          <div class="pay_info_content">
            <table class="table table-borderless">
              <tr>
                <th>최소주문금액</th>
                <td><fmt:formatNumber value="${shop.shop_minprice}" pattern="#,#00" />원</td>
              </tr>
            </table>
          </div>
        </div>
        <div class="owner_info">
          👤사업자 정보
          <hr />
          <div class="owner_content">
            <table class="table table-borderless">
              <tr>
                <th>상호명</th>
                <td>${shop.shop_company}</td>
              </tr>
              <tr>
                <th>사업자등록번호</th>
                <td>${shop.shop_bnumber}</td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </form>
  </body>
  .
</html>
