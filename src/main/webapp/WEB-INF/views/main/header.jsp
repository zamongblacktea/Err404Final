<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        .header{
            background: url("${pageContext.request.contextPath}/images/헤더이미지1.png");
            background-size: cover;
            background-position: center 50%;
        }

        #search_form{
            width: 550px;
            margin: 0 auto;
            /* margin-top: 165px; */
            z-index: 5;
        }

        #search{
            width: 450px;
            height: 50px;
            display: inline;
            margin-top: 165px;
        }

        .btn_search{
            width: 70px;
            height: 50px;
            display: inline-block;
        }

    </style>
</head>
<body>
    <div class="header">
        <form id="search_form" action="${pageContext.request.contextPath}/main/list.do" method="get">
            <input type="text" name="search" id="search" class="form-control" placeholder="메뉴를 검색해주세요.">
            <input type="submit" class="btn btn-outline-success btn_search" value="검색">
        </form>
    </div>


    </div>
</body>
</html>