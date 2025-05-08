<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>라이더 배달현황페이지</title>
    <!-- 파비콘 -->
    <link rel="icon" href="${pageContext.request.contextPath}/images/잇띵로고최종.png" type="image/x-icon">
     <!-- 웹소캣 -->
     <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
     <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <!-- bootstrap 3.x 사용설정 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <!-- 구글 폰트 hi-melody  -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
<style type="text/css">
    
  *  {
  font-family: "Jua", sans-serif;
  font-weight: 400;
  font-style: normal;
  }


  /* #header{
    width: 95%;
    display: flex;  
    font-size: large;
  }
  
  #box{
    margin: auto;
  } */

  .content{
    padding: 30px;
  }


  
  /* .panel{
    width: 90%;
    margin: auto;
  } */

  .buttons{
        background-color: #f0bba8;
        font-size: large;
        color: white;
        border: none;
        width: 25%;
        border-radius: 5px;
        padding: 10px 15px;
        cursor: pointer;
        transition: background-color 0.3s ease;
        /* margin-right: 20px; */
        box-sizing: border-box;
      }

  .buttons:hover {
    background-color: #e090b5;
  }
  .buttons.active {
    background-color: #e090b5 !important;
    font-weight: bold;
    font-size: large;
    box-shadow: 0 0 5px #d36caa;
  }


  .gap{
    display: inline-block;
    width: 20px;
  }

  .nav {
   text-align: right;
   padding-right: 3%;
  
  }

  .nav input[type="button"] {
  margin-left: 5px;
  }

  img{
        margin: 0 auto;
        width: 250px;
        height: 60px;
        margin-left: 20px;
        margin-top: 20px;
        }

  .panel-heading{
    font-size: large;
    padding-right: 3%;
  }      

  .btn1{
   
    /* background-color: #ff694a; */
    background-color: #d86fbb;
    color: white;
    border: 1px solid white;

}

.btn2{
   
   /* background-color: #ff694a; */
   background-color: #e18747;
   color: white;
   border: 1px solid white;

}

 
</style>
<script>

    //웹소켓
    var socket = null;

    window.onload = function () {
    // 페이지 로딩될 때 standby 함수 자동 호출
      standby();
    };

  function setActiveButton(activeId) {
    // 모든 버튼 클래스 제거
    document.querySelectorAll(".buttons").forEach(btn => {
      btn.classList.remove("active");
    });

    // 활성화 버튼에 active 클래스 추가
    document.getElementById(activeId).classList.add("active");
  }


  function standby(){

      open_socket();

      setActiveButton("btn-standby"); // 버튼 활성화 표시

  		$.ajax({ //key value jason형식
			type :"GET",				   //요청타입 : GET/POST 생략시 GET
			async: true,				   //동기/비동기 : true(동기) false(비동기) 생략시 true
			url  : "standby.do",
      data :{"rider_idx" : "${user.rider_idx}"},
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


  function open_socket(){
      //singleton
      if(socket==null){  
        socket = new SockJS('${pageContext.request.contextPath}/ws-orders');
        var stompClient = Stomp.over(socket);

        // WebSocket 연결 설정
        stompClient.connect({}, function (frame) {
            // 주문 상태 업데이트 메시지 구독
        stompClient.subscribe('/topic/orders', function (message) {
                // 서버에서 메시지가 올 때마다 DOM 업데이트
                const data = JSON.parse(message.body);
                console.log("standby",data);
                if(data.tab_state == 'standby'){
                    //location.reload(); // 페이지를 새로고침하여 새로운 데이터를 반영
                    standby();
                }
            });
        });
      }
  }

  function close_socket(){
     if(socket!=null){
        socket.close();
        socket=null;
     }
  }

  function progress(){

      close_socket();

      setActiveButton("btn-progress"); //버튼 활성화 표시 

  		$.ajax({ //key value jason형식
			tyep :"GET",				   //요청타입 : GET/POST 생략시 GET
			async: true,				   //동기/비동기 : true(동기) false(비동기) 생략시 true
			url  : "progress.do",
      data :{"rider_idx" : "${user.rider_idx}"},
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

     close_socket();

     setActiveButton("btn-complete");// 버튼 활성화 표시 
    
     $.ajax({ //key value jason형식
			tyep :"GET",				   //요청타입 : GET/POST 생략시 GET
			async: true,				   //동기/비동기 : true(동기) false(비동기) 생략시 true
			data: {"rider_idx":"${user.rider_idx}"},
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

  //웹소캣 구독 
  // var socket = new SockJS('${pageContext.request.contextPath}/ws-orders');
  //     var stompClient = Stomp.over(socket);
  
  //     // WebSocket 연결 설정
  //     stompClient.connect({}, function (frame) {
  //         // 주문 상태 업데이트 메시지 구독
  //     stompClient.subscribe('/topic/orders', function (message) {
  //             // 서버에서 메시지가 올 때마다 DOM 업데이트
  //             //location.reload(); // 페이지를 새로고침하여 새로운 데이터를 반영
  //         });
  //     });

</script>

<script>
  // 챗봇
  // (function(){var w=window;if(w.ChannelIO){return w.console.error("ChannelIO script included twice.");}var ch=function(){ch.c(arguments);};ch.q=[];ch.c=function(args){ch.q.push(args);};w.ChannelIO=ch;function l(){if(w.ChannelIOInitialized){return;}w.ChannelIOInitialized=true;var s=document.createElement("script");s.type="text/javascript";s.async=true;s.src="https://cdn.channel.io/plugin/ch-plugin-web.js";var x=document.getElementsByTagName("script")[0];if(x.parentNode){x.parentNode.insertBefore(s,x);}}if(document.readyState==="complete"){l();}else{w.addEventListener("DOMContentLoaded",l);w.addEventListener("load",l);}})();

  // ChannelIO('boot', {
  //   "pluginKey": "6f7a9234-fd72-433f-b10a-7aeef84a830c",
  //   "memberId": "${ user.rider_id }", // fill user's member id
  //   "profile": { // fill user's profile
  //     "name": "${user.rider_name}", // fill user's name
  //     "mobileNumber": "${user.rider_phone}", // fill user's mobile number
  //     "landlineNumber": "USER_LANDLINE_NUMBER", // fill user's landline number  
  //     "CUSTOM_VALUE_1": "VALUE_1", // custom property
  //     "CUSTOM_VALUE_2": "VALUE_2" // custom property
  //   }
  // });
</script>




  </head>
  <body>


    <div class="box">
      <div class="title" style="text-align: center; margin-top: 30px;">
        <span style="font-size: large;">오늘도 안전운행! 라이더님 전용 화면입니다*^^* </span>
      </div> <!--div title-->

      <div class="header">
        <img src="${pageContext.request.contextPath}/images/로고.png"> 
        
      </div> <!-- div header -->
    
      <div class="nav">
      ${sessionScope.user.rider_name}님 환영합니다.
        <input type="hidden" value="${user.rider_idx}" name="rider_idx" id="rider_idx">
        <!-- <input type="button" value="로그아웃" onclick="location.href='../main/main.do'"/> -->
        <input class="btn1" type="button" value="로그아웃" onclick="location.href='../member/logout.do'"/>
        <input class="btn2" type="button" value="마이페이지" onclick="location.href='../member/modify_form_rider.do?rider_idx=${user.rider_idx}'" />
      </div> 
      <!--div nav-->
  
        <!-- 컬러색 #F08650 -->

         <!-- 각 페이지일 경우 ex주문대기 페이지 주문대기버튼이 활성화 되어있음으로 만들기 -->
      <div class="content"> 
         <div class="panel panel-warning"   >
          <div class="panel-heading" style="background-color:#FFE6C9;">라이더 배달 현황</div>
          <div class="panel-body">
          <div class="body">
                
                <div class="button-group" style="text-align: center;">
                <!-- <input class="buttons" type="button" value="배차대기" onclick="standby();" />
                <input class="buttons" type="button" value="배달현황" onclick="progress()" />
                <input class="buttons" type="button" value="배달완료" onclick="complete()"/> -->
                <input class="buttons" id="btn-standby" type="button" value="배차대기" onclick="standby();" />
                <span class="gap"></span>
                <input class="buttons" id="btn-progress" type="button" value="배달현황" onclick="progress()" />
                <span class="gap"></span>
                <input class="buttons" id="btn-complete" type="button" value="배달완료" onclick="complete()"/>
              </div> <!--버튼 div-->
              </div>
              </div>
          </div> <!--div panel-->
       

          <!-- ajax내용불러올것넣기
            자바스크립트안에서 호출하기 ->ajax standby.do 여기서 호출 -->
          <div id="disp"></div>

      </div> <!--div content-->
    </div>
   
  </body>
</html>
