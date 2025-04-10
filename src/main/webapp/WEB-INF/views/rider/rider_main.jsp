<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>라이더 배달현황페이지</title>
    <!-- bootstrap 3.x 사용설정 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
  #box{
    width: 1000px;
    height: 700px;
    margin: auto;
  }
  
  .buttons{
        background-color: #f0bba8;
        color: white;
        border: none;
        border-radius: 5px;
        padding: 10px 15px;
        cursor: pointer;
        transition: background-color 0.3s ease;
      }

  .buttons:hover {
    background-color: #e090b5;
  }

</style>
<script>
  function standby(){
  		$.ajax({ //key value jason형식
			tyep :"GET",				   //요청타입 : GET/POST 생략시 GET
			async: true,				   //동기/비동기 : true(동기) false(비동기) 생략시 true
			url  : "standby.do",
			success: function(result_data){
				
				//result_data <=서버로부터 응답받은 데이터
				//document.getElementById("disp").innerHTML = result_data;
				$("#disp").html(result_data);
			},
			error  : function(err){
			    alert(err.responseText);
			}
		});

  }//end : function standby()

  function prograss(){
  		$.ajax({ //key value jason형식
			tyep :"GET",				   //요청타입 : GET/POST 생략시 GET
			async: true,				   //동기/비동기 : true(동기) false(비동기) 생략시 true
			url  : "prograss.do",
			success: function(result_data){
				
				//result_data <=서버로부터 응답받은 데이터
				//document.getElementById("disp").innerHTML = result_data;
				$("#disp").html(result_data);
			},
			error  : function(err){
			    alert(err.responseText);
			}
		});

  }//end : function prograss()

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
    <div  class="nav" style="text-align: center;">
    <!-- 바인딩해둔곳 추가하기 -->
    라이더 페이지 ${rider_id}님 환영합니다.
      <input type="button" value="로그아웃" />

      <input type="button" value="마이페이지" />
    </div>
   

    
      <div id="box">


<!-- 컬러색 #F08650 -->

         <!-- 각 페이지일 경우 ex주문대기 페이지 주문대기버튼이 활성화 되어있음으로 만들기 -->
          <div class="panel panel-warning"   >
            <div class="panel-heading" style="background-color:#FFE6C9;">라이더 배달 현황</div>
            <div class="panel-body">
              <div class="body">
                <!-- onclick=location.href="넣어야함" -->
                <input class="buttons" type="button" value="주문대기" onclick="standby();" />
                <input class="buttons" type="button" value="배달현황" onclick="prograss()" />
                <input class="buttons" type="button" value="배달완료" onclick="complete()"/>
              </div>
              </div>
          </div>

          <!-- ajax내용불러올것넣기
            자바스크립트안에서 호출하기 ->ajax standby.do 여기서 호출 -->
          <div id="disp"></div>
    </div>
  </body>
</html>
