<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <title>Insert title here</title>
                <!-- bootstrap 사용설정 -->
                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
                <style>
                    #box {
                        width: 800px;
                        margin: auto;
                        margin-top: 50px;

                    }

                    label {
                        display: inline-block;
                        width: 50px;
                        text-align: right;
                    }

                    td {
                        text-align: center;
                    }

                    img {
                        width: 750px;

                    }
                </style>

                <script>
                    //장바구니 등록
                    function insert_cart(){
                        //로그인 체크
                        if("${empty user}"=="true"){

                            if(confirm("로그인 후 이용해주세요.")==false)return;

                            //로그인 폼 이동시키고 로그인 후 URI주소로 롤백시키기
                            location.href="../member/login_form.do?url="+ encodeURIComponent(location.href);
                        }

                        //ajax 이용해서 JSON으로 장바구니 등록시키기
                        $.ajax({    url     : "/cart/insert.do",
                                    data    : { "prod_idx" : "${vo.prod_idx}",
                                                "mem_idx" : "${user.mem_idx}"
                                              },
                                    dataType: "json",
                                    success : function(res_data){
                                        //담기 , 취소 , 존재 3개로 나눠서 로직 처리
                                        if(res_data.result == "exist"){ //이미 존재
                                            alert("이미 장바구니에 있는 상품입니다.");
                                            return;
                                        }
                                        if(res_data.result == "fail"){ //실패
                                            alert("등록에 실패했습니다.");
                                            return;
                                        }

                                        //장바구니 등록 성공시 출력하기
                                        if(confirm("장바구니 등록 완료 \n장바구니 목록으로 이동하시겠습니까?")==false) return;

                                        //장바구니 목록 이동
                                        location.href="../cart/list.do?mem_idx=${user.mem_idx}";

                                    },          
                                    error   : function(err){
                                        alert(err.responseText);
                                    },       


                        });

                    }

                </script>
            </head>

            <body>
                <div id="box">
                    <div class="panel-heading">
                        <h4>${vo.prod_name}</h4>
                    </div>
                    <div class="panel-body">
                        <table class="table">
                            <tr>
                                <th colspan="2">제조회사</th>
                                <td style="text-align: left;">${vo.prod_company}</td>
                            </tr>
                            <tr>
                                <th>가격</th>
                                <td style="text-align: left;">
                                    <label>정가:</label> <fmt:formatNumber value="${vo.prod_price }" type="currency" /><br>    
                                    <label>할인가:</label> <fmt:formatNumber value="${vo.prod_saleprice }" type="currency" />(<font color="red">${vo.getDcRate()}% DC</font>)
                                </td>
                            </tr>
                            <tr>
                                <th colspan="2">상품 설명</th>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <img src="../images/${vo.prod_image_l}">
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    ${vo.prod_description}
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <input class="btn btn-primary" type="button" value="장바구니 담기" onclick="insert_cart();">
                                    <input class="btn btn-success" type="button" value="목록으로" onclick="location.href='list.do?cate_idx=${param.cate_idx}'">
                                </td>
                            </tr>
                        </table>
                    </div>


                </div>
            </body>

            </html>