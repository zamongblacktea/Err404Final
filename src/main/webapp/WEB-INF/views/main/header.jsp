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
        <div id="search_form">
        <form action="">
            <input type="text" id="search" class="form-control">
            <input type="button" class="btn btn-info btn_search" value="검색" onclick="">
        </form>
    </div>


    </div>
</body>
</html>