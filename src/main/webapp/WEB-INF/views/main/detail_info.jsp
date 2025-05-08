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

  <body>
    <form>
      <input type="hidden" id="mem_idx" name="mem_idx" value="${user.mem_idx}" />
      <input type="hidden" id="shop_idx" name="shop_idx" value="${shop.shop_idx}" />

      <div class="detail-info">
        <div class="notice">
          <span>📢사장님 알림</span>
          <hr />
          <div class="notice_content">${shop.shop_notice}</div>
        </div>
        <div class="intro">
          <span>🤗가게 소개</span>
          <hr />
          <div class="intro_content">${shop.shop_intro}</div>
        </div>
        <div class="info">
          <span>🍴업체정보</span>
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
          <span>💳결제 정보</span>
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
          <span>👤사업자 정보</span>
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
