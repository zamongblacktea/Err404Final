<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <!-- bootstrap 3.x 사용설정 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <style>
        #box{
            width: 1000px;
            margin:auto;
            margin-top: 30px;
        }

        #title{
            text-align: center;
            font-size: 28px;
            font-weight: bold;
            color: rgb(51,122,183);
            text-shadow: 1px 1px 1px black;
            margin-bottom: 80px;
        }

        .my-menu{

            font-size: 14px;
            font-weight: bold;
           
        }

       

    </style>

</head>

<body>
         

         <!-- 상품등록/로그인 -->
         <div class="row" style="margin-bottom: 10px;">
            
            <div class="col-sm-4">
                <!-- 관리자만 상품등록 하도록...  -->
                <c:if test="${  user.mem_grade eq '관리자'  }">
                    <input class="btn btn-primary" type="button" value="상품등록"
                           onclick="location.href='insert_form.do?cate_idx=${ (empty param.cate_idx) ? 1 : param.cate_idx }'">
                </c:if>

            </div>

            <div class="col-sm-8" style="text-align: right;">
                <!-- 로그인이 안된경우 -->
                <c:if test="${ empty user }">
                    <input class="btn btn-primary" type="button" value="로그인" 
                           onclick="location.href='../member/login_form.do'">
                </c:if> 

                <!-- 로그인이 된경우 -->
                <c:if test="${ not empty user }">
                    <b>${ user.mem_name }</b>님 환영합니다
                    <input class="btn btn-primary" type="button" value="로그아웃" 
                           onclick="location.href='../member/logout.do'">
                    <input class="btn btn-primary" type="button" value="장바구니보기" onclick="location.href='../cart/list.do?mem_idx=${user.mem_idx}'">
                </c:if>  
            </div>
         </div>
         
         <!-- 타이틀 -->
         <h1 id="title">::::Global IT Shop::::</h1>
      
         <!-- 메뉴 -->
         <div style="margin-bottom: 5px;">
            <ul class="nav nav-pills nav-justified  my-menu" role="tablist">
                <!-- for(CategoryVo category : category_list) -->
                <c:forEach var="category" items="${ cate_list }" varStatus="i">
                    <c:if test="${ (category.cate_idx eq param.cate_idx) or (empty param.cate_idx and i.index eq 0) }">
                        <li class="active"><a href="#">${ category.cate_name }</a></li>
                    </c:if>
                    <c:if test="${( (not empty param.cate_idx)  and  (category.cate_idx ne param.cate_idx) )  or (empty param.cate_idx and i.index ne 0) }">
                        <li><a href="list.do?cate_idx=${category.cate_idx}">${ category.cate_name }</a></li>
                    </c:if>
                </c:forEach>
                <!-- <li><a href="?cate_idx=1">컴퓨터</a></li>                
                <li><a href="?cate_idx=2">전자제품</a></li>                
                <li><a href="?cate_idx=3">스포츠</a></li>                
                <li><a href="?cate_idx=4">의류</a></li>                 -->
            </ul>             
         </div> 

         
 
</body>

</html>