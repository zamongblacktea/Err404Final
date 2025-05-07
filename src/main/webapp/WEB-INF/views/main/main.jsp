<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="icon" href="${pageContext.request.contextPath}/images/잇띵로고최종.png" type="image/x-icon">
  </head>
  
<!-- 챗봇 AI 연동 api js -->

<script>
  (function(){var w=window;if(w.ChannelIO){return w.console.error("ChannelIO script included twice.");}var ch=function(){ch.c(arguments);};ch.q=[];ch.c=function(args){ch.q.push(args);};w.ChannelIO=ch;function l(){if(w.ChannelIOInitialized){return;}w.ChannelIOInitialized=true;var s=document.createElement("script");s.type="text/javascript";s.async=true;s.src="https://cdn.channel.io/plugin/ch-plugin-web.js";var x=document.getElementsByTagName("script")[0];if(x.parentNode){x.parentNode.insertBefore(s,x);}}if(document.readyState==="complete"){l();}else{w.addEventListener("DOMContentLoaded",l);w.addEventListener("load",l);}})();

  ChannelIO('boot', {
    "pluginKey": "6f7a9234-fd72-433f-b10a-7aeef84a830c",
    "memberId": "${ user.mem_id }", // fill user's member id
    "profile": { // fill user's profile
      "name": "${user.mem_name}", // fill user's name
      "mobileNumber": "${user.mem_phone}", // fill user's mobile number
      "landlineNumber": "USER_LANDLINE_NUMBER", // fill user's landline number  
      "CUSTOM_VALUE_1": "VALUE_1", // custom property
      "CUSTOM_VALUE_2": "VALUE_2" // custom property
    }
  });
</script>


    <body>
      <nav class="navbar">
        <%@ include file="navbar.jsp" %>
      </nav>
      <header class="header">
        <%@ include file="header.jsp" %>
      </header>
      <div class="content">
        <div id="mybox">
          <div class="category"onclick="location.href='../main/list.do'">
            <img src="${pageContext.request.contextPath}/images/카테고리 사진/전체보기.png" alt="카테고리-전체보기">
          </div>
          <div class="category" onclick="location.href='../main/list.do?shop_cate_idx=1'">
            <img src="${pageContext.request.contextPath}/images/카테고리 사진/치킨.png" alt="카테고리-치킨">
          </div>
          <div class="category" onclick="location.href='../main/list.do?shop_cate_idx=2'">
            <img src="${pageContext.request.contextPath}/images/카테고리 사진/피자.png" alt="카테고리-피자/양식">
          </div>
          <div class="category" onclick="location.href='../main/list.do?shop_cate_idx=3'">
            <img src="${pageContext.request.contextPath}/images/카테고리 사진/짜장면.png" alt="카테고리-중국집">
          </div>
          <div class="category" onclick="location.href='../main/list.do?shop_cate_idx=4'">
            <img src="${pageContext.request.contextPath}/images/카테고리 사진/한식.png" alt="카테고리-한식">
          </div>
          <div class="category" onclick="location.href='../main/list.do?shop_cate_idx=5'">
            <img src="${pageContext.request.contextPath}/images/카테고리 사진/일식.png" alt="카테고리-일식/돈까스">
          </div>
          <div class="category" onclick="location.href='../main/list.do?shop_cate_idx=6'">
            <img src="${pageContext.request.contextPath}/images/카테고리 사진/족발.png" alt="카테고리-족발/보쌈">
          </div>
          <div class="category" onclick="location.href='../main/list.do?shop_cate_idx=7'">
            <img src="${pageContext.request.contextPath}/images/카테고리 사진/야식.png" alt="카테고리-야식">
          </div>
          <div class="category" onclick="location.href='../main/list.do?shop_cate_idx=8'">
            <img src="${pageContext.request.contextPath}/images/카테고리 사진/떡볶이.png" alt="카테고리-분식">
          </div>
          <div class="category" onclick="location.href='../main/list.do?shop_cate_idx=9'">
            <img src="${pageContext.request.contextPath}/images/카테고리 사진/카페.png" alt="카테고리-카페/디저트">
          </div>
        </div>
      </div>
  

    <footer class="footer">푸터</footer>
  </body>
</html>
