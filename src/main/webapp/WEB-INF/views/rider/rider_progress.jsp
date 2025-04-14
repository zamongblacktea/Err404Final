<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문현황 페이지</title>

    <script>    
    function complete(){
        $.ajax({ //key value jason형식
          tyep :"GET",				   //요청타입 : GET/POST 생략시 GET
          async: true,				   //동기/비동기 : true(동기) false(비동기) 생략시 true
          url  : "complete.do",
          success: function(result_data){
              
              //result_data <=서버로부터 응답받은 데이터
              //document.getElementById("disp").innerHTML = result_data;
              $("#disp").html(result_data);
          },
          error  : function(err){
              alert(err.responseText);
          }
      });
    }//end : function complete()
    
    </script>
</head>
<body>
    <!-- 아래 내용을 하나의 패널이나 네모안에 넣고 오른쪽에 경로보기 버튼누르기 -->
     <!-- 하나의 div넣고 경로보기랑 픽업완료도 div로 넣고 그리드로 넣어야 할듯 -->

    <c:forEach var="vo" items="${rider_list}"> 
        <div>주문번호 : ${vo.order_idx}</div> 
        <div>주문상태 : ${vo.order_status}</div> 
        <div>가게이름 :  ${vo.shop_name}</div>
        <div>가게위치 : ${vo.shop_addr1} ${vo.shop_addr2}</div> 
        <div>회원번호 :  ${vo.mem_idx}</div>
        <div>배달장소 :${vo.mem_caddr} ${vo.mem_caddr}</div> 
        <div>배달요청사항 :  ${vo.rider_request}</div>
        <div>배달상태: ${vo.delivery_status}</div>  
 
        <input type="button" value="경로보기" onclick="location.href='../route/route.do'">
        <!-- 원래는 배달예상시간 버튼 누르고 나서 픽업완료가 뜸(이전기수)
        여기서는 가게가 조리 완료를 누르면 픽업완료가 뜰 수 있도록 하기 -->
        <input type="button" value="픽업완료">
        <!-- 픽업완료 버튼을 누르면
        픽업 완료 버튼이 배달완료 버튼으로 바뀌게 하기
        픽업이 완료되었다는 정보가 가게,고객에게 전달됨 -->
        <input type="button" value="배달완료" onclick="complete()">
        <!-- 배달이 완료되었다는 정보가 가게,고객에게 전달됨 -->
    </c:forEach>
    


</body>
</html>