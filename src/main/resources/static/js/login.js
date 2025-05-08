$(document).ready(function(){
    $(".input__block").hide();
    let owner = $(".links").find("li").find("#owner") ; 
    let member = $(".links").find("li").find("#member") ; 
    let rider = $(".links").find("li").find("#rider") ; 
    //let first_input = $("form").find(".first-input");
    //let hidden_input = $("form").find(".input__block").find(".first-input__block");
    let form_inputs = $("form .input__block"); // 전체 input div들
    let sns = $(".sns");
    let mem = $(".mem");
    let owner_btn = $("form").find("#owner_btn");
    let owner_info = $("form").find(".owner_info");
    let rider_btn = $("form").find("#rider_btn");
    let rider_info = $("form").find(".rider_info");
    let signin_btn  = $("form").find(".signin__btn");
    sns.hide();
  
   //----------- member ---------------------
   member.on("click",function(e){
      e.preventDefault();
      $(this).parent().parent().siblings("h1").text("로그인");
      $(this).parent().css("opacity","1");
      $(this).parent().siblings().css("opacity",".6");
      form_inputs.hide();
      mem.show();
      sns.hide();
      // hidden_input.css({
      //   "opacity" : "1",
      //   "display" : "none"
      // });
      signin_btn.text("Login");
    });

    //----------- owner ---------------------
    owner.on("click",function(e){
      e.preventDefault();
      $(this).parent().parent().siblings("h1").text("로그인");
      $(this).parent().css("opacity","1");
      $(this).parent().siblings().css("opacity",".6");
      form_inputs.show();
      sns.show();
      mem.hide();
      rider_btn.hide();
      rider_info.hide();
      // hidden_input.css({
      //   "opacity" : "1",
      //   "display" : "none"
      // });
      signin_btn.text("Login");
    });

  //----------- rider ---------------------
      rider.on("click",function(e){
      e.preventDefault();
      $(this).parent().parent().siblings("h1").text("로그인");
      $(this).parent().css("opacity","1");
      $(this).parent().siblings().css("opacity",".6");
      form_inputs.show();
      sns.show();
      mem.hide();
      owner_btn.hide();
      owner_info.hide();
      // hidden_input.css({
      //   "opacity" : "1",
      //   "display" : "none"
      // });
      signin_btn.text("Login");
    });
    

   

});




function owner_send(f) {

    let owner_id = f.owner_id.value.trim();
    let owner_pwd = f.owner_pwd.value.trim();

    if (owner_id == "") {
      //alert("아이디를 입력하세요!!");
      //Swal.fire("아이디를 입력하세요!!");

      Swal.fire({
        title: "입력오류",
        html: "<h5>아이디를 입력하세요!!</h5>",
        icon: "warning",
        returnFocus: false
      }).then(() => {

        f.owner_id.value = "";
        f.owner_id.focus();
      });

      return;
    }

    if (owner_pwd == "") {
      //alert("비밀번호를 입력하세요!!");
      /* Swal.fire("비밀번호를 입력하세요!!");
      f.owner_pwd.value="";
      f.owner_pwd.focus(); */

      Swal.fire({
        title: "입력오류",
        html: "<h5>비밀번호를 입력하세요!!</h5>",
        icon: "warning",
        returnFocus: false
      }).then(() => {
        f.owner_pwd.value = "";
        f.owner_pwd.focus();
      });

      return;
    }

    //f.method = "POST";
    f.action = "owner_login.do"; //MemberLoginAction
    f.submit();            //지정 action호출(데이터전송)   
  }

  function rider_send(f) {

let rider_id = f.rider_id.value.trim();
let rider_pwd = f.rider_pwd.value.trim();

if (rider_id == "") {
  //alert("아이디를 입력하세요!!");
  //Swal.fire("아이디를 입력하세요!!");

  Swal.fire({
    title: "입력오류",
    html: "<h5>아이디를 입력하세요!!</h5>",
    icon: "warning",
    returnFocus: false
  }).then(() => {

    f.rider_id.value = "";
    f.rider_id.focus();
  });

  return;
}

if (rider_pwd == "") {
  //alert("비밀번호를 입력하세요!!");
  /* Swal.fire("비밀번호를 입력하세요!!");
  f.rider_pwd.value="";
  f.rider_pwd.focus(); */

  Swal.fire({
    title: "입력오류",
    html: "<h5>비밀번호를 입력하세요!!</h5>",
    icon: "warning",
    returnFocus: false
  }).then(() => {
    f.rider_pwd.value = "";
    f.rider_pwd.focus();
  });

  return;
}

//f.method = "POST";
f.action = "rider_login.do"; //MemberLoginAction
f.submit();            //지정 action호출(데이터전송)   
}

  //현재 HTML문서의 배치가 완료되면 자동호출 함수
  window.onload = function () {

    setTimeout(show_message, 100);//0.1초후에 show_message호출
    //show_message();

  };


  // /member/login_form.do?reason=fail_id
  // /member/login_form.do?reason=fail_pwd&rider_id=hong
  // /member/login_form.do?reason=session_timeout
  function show_message() {

    if ("${ param.reason eq 'fail_id' }" == "true") {
      //alert("아이디가 틀렸습니다!");
      Swal.fire({
        title: "로그인실패",
        html: "<h5>아이디가 틀렸습니다!!</h5>",
        icon: "warning",
        returnFocus: false
      }).then(() => {

        $("#mem_id").focus();

      });
    }

    if ("${ param.reason eq 'fail_pwd' }" == "true") {
      //alert("비밀번호가 틀렸습니다!");
      Swal.fire({
        title: "로그인실패",
        html: "<h5>비밀번호가 틀렸습니다!!</h5>",
        icon: "warning",
        returnFocus: false
      }).then(() => {

        $("#mem_pwd").focus();

      });
    }

    if ("${ param.reason eq 'session_timeout' }" == "true") {
      //alert("아이디가 틀렸습니다!");
      Swal.fire({
        title: "로그아웃",
        html: "<h5>로그아웃 되었습니다!!</h5>",
        icon: "warning",
        returnFocus: false
      }).then(() => {

        $("#mem_id").focus();

      });
    }

  }
