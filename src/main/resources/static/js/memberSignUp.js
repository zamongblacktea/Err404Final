const regular_email = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;

  function send(f) {

    //입력값 체크
    let mem_name = f.mem_name.value.trim();
    let mem_nickname = f.mem_nickname.value.trim();
    let mem_phone = f.mem_phone.value.trim();
    //member DB
    let mem_zipcode = f.mem_addr.value.trim();
    let mem_addr = f.mem_addr2.value;
    //mem_addr  DB
    let mem_addr1 = f.mem_addr.value;
    let mem_addr2  = f.mem_addr2.value;




    if (mem_name == "") {

      alert("이름을 입력하세요!");
      f.mem_name.value = "";
      f.mem_name.focus();
      return;
    }


    if (mem_nickname == "") {

      alert("닉네임을 입력하세요!");
      f.mem_nickname.value = "";
      f.mem_nickname.focus();
      return;
    }

    if (mem_zipcode == "") {

      alert("우편번호 입력하세요!");
      f.mem_zipcode.value = "";
      f.mem_zipcode.focus();
      return;
    }

    if (mem_addr == "") {

      alert("주소를 입력하세요!");
      f.mem_addr.value = "";
      f.mem_addr.focus();
      return;
    }

    if (mem_addr2 == "") {

    alert("주소를 입력하세요!");
    f.mem_addr2.value = "";
    f.mem_addr2.focus();
    return;
    }

    if (mem_phone == "") {

    alert("전화번호를 입력하세요!");
    f.mem_phone.value = "";
    f.mem_phone.focus();
    return;
    }


    f.action = "insert.do"// MemberInsertAction
    f.submit();

  }//end:send()

  //주소검색
  function find_curaddr() {



    const width = 500; //팝업의 너비
    const height = 600; //팝업의 높이
    new daum.Postcode({
      width: width, //생성자에 크기 값을 명시적으로 지정해야 합니다.
      height: height,
      oncomplete: function (data) {
        //data : JOSN형식
        //  data = { "zonecode":"06789", "address":"서울시 관악구 남부순환로 111", .... }
        //console.log(data);
        $("#mem_zipcode").val(data.zonecode);
        $("#mem_addr").val(data.address);

      }
    }).open({
      left: (window.screen.width / 2) - (width / 2),
      top: (window.screen.height / 2) - (height / 2)
    });


  }

