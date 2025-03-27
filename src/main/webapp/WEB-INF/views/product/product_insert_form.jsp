<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

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
     <script>
        //초기화 이벤트
        $(document).ready(function(){
            //상품 등록시 url에 있는 cate_idx param 정보 가져와서 넣어주기
            $("#cate_idx").val("${ param.cate_idx }");

        });

        //상품 입력금액 범위 지정
        const regular_number = /^[0-9]{1,10}$/;
        function send(f){
            let prod_name       = f.prod_name.value.trim();
            let prod_company    = f.prod_company.value.trim();
            let prod_price      = f.prod_price.value;
            let prod_saleprice  = f.prod_saleprice.value;
            let prod_description= f.prod_description.value.trim();
            let photo1          = f.photo[0].value;
            let photo2          = f.photo[1].value;
            

            if(prod_name == ''){
                alert("상품명을 입력해주세요.");
                f.prod_name.value='';
                f.prod_name.focus();
                return;
            }
            if(prod_company == ''){
                alert("제조사명을 입력해주세요.");
                f.prod_company.value='';
                f.prod_company.focus();
                return;
            }
            if(prod_description == ''){
                alert("설명을 입력해주세요.");
                f.prod_description.value='';
                f.prod_description.focus();
                return;
            }

            //정규식 체크 조건문
            if(regular_number.test(prod_price)==false){
                alert("가격은 숫자만 입력해주세요.(최대 10자리)");
                f.prod_price.value='';
                f.prod_price.focus();
                return;
            }

            if(photo1 == ''){
                alert("상품 이미지(소)를 선택해주세요");
                f.prod_price.value='';
                f.prod_price.focus();
                return;
            }
            if(photo2 == ''){
                alert("상품 이미지(대)를 선택해주세요");
                f.prod_price.value='';
                f.prod_price.focus();
                return;
            }
            f.action = "insert.do";
            f.submit();
        };

     </script>

     <style>
        #box{
            width: 800px;
            margin: auto;
            margin-top: 50px;
        }

        label{
            display: inline-block;
            width:50px;
            text-align: right;
        }
        th{
            vertical-align: middle !important; 
        }

        textarea{
            resize: none;
        }

        td{
            text-align: center;
        }

        img{
            width: 400px;
        }

        input[type='button']{
            width: 150px;
        }
     </style>

</head>
<body>
    <div id="box">

         <!-- header : 타이틀 + 메뉴 -->
         <%@ include file="header.jsp" %> 

        <form method="POST" enctype="multipart/form-data">
            <div class="panel panel-primary">
                <div class="panel-heading"><h4>상품등록</h4></div>
                <div class="panel-body">
                    <table class="table">
                        <tr>
                            <th>카테고리</th>
                            <td>
                            <select class="form-control" name="cate_idx" id="cate_idx">
                                <c:forEach var="category" items="${ cate_list }">
                                <option value="${category.cate_idx}">${category.cate_name}</option>
                                </c:forEach>
                            </select>
                        </td>
                        </tr>
                        <tr>
                            <th>상품명</th>
                            <td><input class="form-control" name="prod_name"></td>
                        </tr>
                        <tr>
                            <th>제조사</th>
                            <td><input class="form-control" name="prod_company"></td>
                        </tr>
                        <tr>
                            <th>단가</th>
                            <td><input class="form-control" name="prod_price"></td>
                        </tr>
                        <tr>
                            <th>할인가</th>
                            <td><input class="form-control" name="prod_saleprice"></td>
                        </tr>
                        <tr>
                            <th>상품이미지(소)</th>
                            <td><input class="form-control" type="file" name="photo"></td>
                        </tr>
                        <tr>
                            <th>상품이미지(대)</th>
                            <td><input class="form-control" type="file" name="photo"></td>
                        </tr>

                        <tr>
                            <th>상품설명</th>
                            <td><textarea class="form-control" name="prod_description" rows="5"></textarea></td>
                        </tr>

                        <tr>
                            <td colspan="2">
                                <input class="btn btn-primary" type="button" value="상품등록하기" onclick="send(this.form);">
                                <input class="btn btn-primary" type="reset"  value="입력취소하기" onclick="location.href='list.do?cate_idx=${param.cate_idx}'">
                            </td>
                        </tr>


                    </table>  
                </div>
            </div>
       </form> 

    </div>

</body>
</html>