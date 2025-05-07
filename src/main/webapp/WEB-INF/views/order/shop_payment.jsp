<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>주문 결제 페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- 포트 원 결제대행 api lib  -->
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<!-- <link rel="stylesheet" href="../css/main.css">
<link rel="stylesheet" href="../css/bar.css"> -->

<!-- 다음 주소검색 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


<style>
body {
	background-color: #f4f6f8;
}

img {
	width: 390px;
	height: 250px;
	margin-left: 8px;
}

h {
	text-align: center;
}

.hr {
	display: block;
	clear: both;
	margin: auto;
	margin-top: 10px;
}

.container {
	width: 1200px;
	margin: auto;
}

.rsvform {
	width: 58%;
	/* height: 500px; */
	height: auto;
	background: white;
	padding: 20px;
	border-radius: 10px;
	margin-top: 50px;
	margin-right: 10px;
	margin-bottom: 50px;
	float: left;
}

.acominfo {
	width: 38%;
	height: auto;
	min-height: 578px;
	background : white;
	border-radius: 10px;
	margin-top: 50px;
	margin-left: 10px;
	padding: 20px;
	float: right;
	background: white;
}

.footer {
	clear: both;
}

.map-box {
	margin-top: 20px;
}

.map {
	margin-top: 30px;
	margin-right: 20px;
	margin: auto; width : 98%;
	height: 250px;
	width: 98%;
}

.acom-img {
	width: 98%;
	height: 250px;
}
.btn{

	float: right;

}

textarea{
	resize: none;
}

.cart_price{
	font-weight: bold;
	font-size: 18px;
}
</style>

<!-- 포트원 SDK 라이브러리 추가 -->
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script src="https://cdn.portone.io/v2/browser-sdk.js"></script>
<script>
	IMP.init("imp23446565"); // 아임포트 가맹점 고객사 식별 코드 입력

	//임시로 보낼 변수값 1 설정을 위해 앞에 Number 형변환 
	function requestPay() {
		const mem_idx = Number($("#mem_idx").val());
		const shop_idx = Number($("#shop_idx").val());
		const menu_idx = Number($("#menu_idx").val());
		const mcuraddr_idx = Number($("#mcuraddr_idx").val()); //회원 현재주소지 기준으로 바꿀 때 쓸 변수 설정
		const menu_name = $("#menu_name").val();
		const cart_price = Number($("#cart_price").val());
		const mem_name = $("#mem_name").val();
		const mem_phone = $("#mem_phone").val();
		const mem_addr1 = $("#mem_addr1").val();
		const mem_addr2 = $("#mem_addr2").val();
		const order_request = $("#order_request").val();
		const rider_request = $("#rider_request").val();


		IMP.request_pay({
			channelKey : "channel-key-7c367284-0269-40b7-aba7-b1437d2fbaaf", // 콘솔에서 발급한 채널키 입력
			pay_method : "card", // 결제 수단 (신용카드)
			merchant_uid : "payment-" + new Date().getTime(), // 주문 고유번호 (현재 타임스탬프 사용)
			name : "Eatting 주문 결제 테스트",
			amount : cart_price, // 결제 금액 (원) 임시 고정값 20000으로 설정됨 test 마치면 바꿔야 함
			buyer_name : mem_name,
			buyer_tel : mem_phone,
			buyer_curaddr : mem_addr1,
		}, function(response) {
			if (response.success) {
				console.log("서버 전송 mcuraddr_idx:", mcuraddr_idx);
				console.log("결제 성공:", response);
				alert("결제가 완료되었습니다! 결제 ID: " + response.imp_uid);

				// 서버에 결제 검증 요청 (AJAX 사용)

				verifyPayment(	response.imp_uid, 
								response.merchant_uid,	
								mem_idx,
								mcuraddr_idx,
								menu_idx,
								shop_idx,
								mem_name,
								mem_phone,
								cart_price,
								mem_addr1,
								mem_addr2,
								order_request,
								rider_request
							);
				console.log("mem_idx:", mem_idx);

				location.href="../main/main.do?mem_idx=" + mem_idx;//메인 페이지로 이동

			} else {
				console.error("결제 실패:", response.error_msg);
				alert("결제 실패: " + response.error_msg);
			}
		});
	}

	// AJAX를 사용한 결제 검증 요청
	function verifyPayment(imp_uid, merchant_uid, mem_idx, mcuraddr_idx, menu_idx, shop_idx, mem_name, mem_phone,cart_price, mem_addr1 , mem_addr2, order_request, rider_request) {
		//form에 설정한 변수 선언
		

		//alert(`[\${mem_idx}]`);
		console.log("서버 전송 mem_idx:", mem_idx);
		$.ajax({
			url : "verify.do",
			type : "POST",
			contentType: "application/json",
			data : JSON.stringify({
				"imp_uid" : imp_uid,
				"merchant_uid" : merchant_uid,
				"mem_idx" : mem_idx,
				"mcuraddr_idx" : mcuraddr_idx,
				"menu_idx" : menu_idx,
				"shop_idx" : shop_idx,
				"mem-name" : mem_name,
				"mem_phone": mem_phone,
				"amount"   : cart_price,
				"mem_addr1" : mem_addr1,
				"mem_addr2" : mem_addr2,
				"order_request" : order_request,
				"rider_request" : rider_request

			}),
			dataType : "json",
			success : function(result) {
				if (result.success) {
					console.log("결제 검증 성공:", result);
					alert("결제 검증 완료!");

				} else {
					console.error("결제 검증 실패:", result.message);
					alert("결제 검증 실패: " + result.message);
				}
			},
			error : function(xhr, status, error) {
				console.error("결제 검증 중 오류 발생:", error);
				alert("결제 검증 오류 발생: " + error);
			}
		});
	}

</script>

<!-- modal -->
<script>
	// 모달 인스턴스 전역 선언
	let myModal;
  
	$(document).ready(function () {
	  // 모달 인스턴스 초기화
	  myModal = new bootstrap.Modal(document.getElementById('myModal'));
  
	  // 주소록 열기
	  $('#openAddrModalBtn').on('click', function () {
		const mem_idx = $('#mem_idx').val();
  
		$.ajax({
		  url: '../member/address.do',
		  type: 'GET',
		  data: { mem_idx: mem_idx },
		  success: function (data) {
			$('#addressModalBody').html(data);
			myModal.show();
		  },
		  error: function (xhr, status, error) {
			alert('주소록 로딩 실패: ' + error);
		  }
		});
	  });
  
	  // 주소 등록 폼 열기
	  $('#insertAddr').on('click', function () {
		const mem_idx = $('#mem_idx').val();
  
		$.ajax({
		  url: '/member/address_insert_form.do',
		  type: 'GET',
		  data: { mem_idx: mem_idx },
		  success: function (data) {
			$('#addressModalBody').html(data);
			myModal.show();
		  },
		  error: function (xhr, status, error) {
			alert('주소 등록 폼 로딩 실패: ' + error);
		  }
		});
	  });
  
	  // 모달 닫기
	  $('#closeModal').on('click', function () {
		myModal.hide();
	  });
	});
  
	// 주소 선택
	function selectAddr(addr1, addr2,mcuraddr_idx) {
	  if (confirm("해당 주소로 변경하시겠습니까?")) {
		$('#mem_addr1').val(addr1);
		$('#mem_addr2').val(addr2);
		$('#mcuraddr_idx').val(mcuraddr_idx);
		myModal.hide();
	  }
	}
  
	// 주소 수정 폼 열기
	function addr_modify(mem_idx, mcuraddr_idx) {
	  $('#mem_idx').val(mem_idx);
	  $('#mcuraddr_idx').val(mcuraddr_idx);
  
	  $.ajax({
		url: '/member/address_modify_form.do',
		type: 'GET',
		data: { mem_idx: mem_idx, mcuraddr_idx: mcuraddr_idx },
		success: function (response) {
		  $('#addressModalBody').html(response);
		  myModal.show();
		},
		error: function (xhr, status, error) {
		  alert('주소 수정 폼 로딩 실패: ' + error);
		}
	  });
	}
  
	// 주소 등록 Ajax
	function insertAddress() {
	  const mem_idx = $('#mem_idx').val();
	  const addr_name = $('#addr_name').val();
	  const mem_zipcode = $('#mem_zipcode').val();
	  const mem_addr = $('#mem_addr').val();
  
	  $.ajax({
		url: '/member/address_insert.do',
		type: 'POST',
		data: {
		  mem_idx: mem_idx,
		  addr_name: addr_name,
		  mem_addr1: mem_zipcode,
		  mem_addr2: mem_addr
		},
		success: function (response) {
		  alert('주소 등록 완료');
		  reloadAddressList(mem_idx);
		},
		error: function (xhr, status, error) {
		  alert('등록 실패: ' + error);
		}
	  });
	}
  
	// 주소 수정 Ajax
	function updateAddress() {
	  const mem_idx = $('#mem_idx').val();
	  const mcuraddr_idx = $('#mcuraddr_idx').val();
	  const addr_name = $('#addr_name').val();
	  const mem_zipcode = $('#mem_zipcode').val();
	  const mem_addr = $('#mem_addr').val();
  
	  $.ajax({
		url: '/member/address_modify.do',
		type: 'POST',
		data: {
		  mem_idx: mem_idx,
		  mcuraddr_idx: mcuraddr_idx,
		  addr_name: addr_name,
		  mem_addr1: mem_zipcode,
		  mem_addr2: mem_addr
		},
		success: function (response) {
		  alert('주소 수정 완료');
		  reloadAddressList(mem_idx);
		},
		error: function (xhr, status, error) {
		  alert('수정 실패: ' + error);
		}
	  });
	}
  
	// 주소 목록 다시 불러오기
	function reloadAddressList(mem_idx) {
	  $.ajax({
		url: '/member/address.do',
		type: 'GET',
		data: { mem_idx: mem_idx },
		success: function (response) {
		  $('#addressModalBody').html(response);
		},
		error: function (xhr, status, error) {
		  alert('주소록 목록 로딩 실패: ' + error);
		}
	  });
	}
  </script>
  

<script type="text/javascript">


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
				//$("#mem_zipcode").val(data.zonecode);
				$("#mem_zipcode").val(data.address);

			}
		}).open({
			left: (window.screen.width / 2) - (width / 2),
			top: (window.screen.height / 2) - (height / 2)
		});


	}







</script>


</head>
<body>
	<div class="container">

	<div class="rsvform shadow">
		<h2 class="text-center mb-4">결제 하기</h2>
		<form id="bookingForm">
			<input type="hidden" name="mem_idx" id="mem_idx" value="${sessionScope.user.mem_idx }"> 
			<!-- 테스트 후 변경해야 함 -->
			<input type="hidden" name="shop_idx" id="shop_idx" value="${ shop_idx }"> 
			<input type="hidden" name="menu_idx" id="menu_idx" value="${ param.menu_idx }">
			<input type="hidden" name="mcuraddr_idx" id="mcuraddr_idx" value="${addr.mcuraddr_idx}">
			<div class="mb-3">
				<label for="addr" class="form-label">주소</label> <input type="text"
						class="form-control" id="mem_addr1" name="mem_addr1"
						value="${ addr.mem_addr1 } " required>
			</div>
			<div class="mb-3">
				<div>
				<label for="addr" class="form-label" >상세주소</label> <br> <input type="text"
						class="form-control" id="mem_addr2" name="mem_addr2"
						value="${ addr.mem_addr2 } " style="width: 80%; display: inline-block;" required>
				<!-- 모달 트리거 버튼 -->
				<button type="button" class="btn btn-primary" id="openAddrModalBtn" style="display: inline-block; margin-bottom: 2px;">
					주소록 열기
				</button>
				</div>

				
				<!-- 모달 구조 -->
				<div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
					
						<!-- 모달 헤더 -->
						<div class="modal-header">
							<h5 class="modal-title" id="myModalLabel">주소록</h5>
						</div>
					
						<!-- 모달 바디 -->
						<div class="modal-body" id="addressModalBody">
								<!-- ajax 처리 -->
						</div>
					
						<!-- 모달 푸터 -->
						<div class="modal-footer">
							<button type="button" class="btn btn-primary" id="insertAddr" >주소등록</button>
							<button type="button" class="btn btn-secondary" id="closeModal" >닫기</button>
						</div>
					
						</div>
					</div>
					</div>
			<div class="mb-3"><input type="hidden"
					class="form-control" id="mem_name" name="mem_name"
					value="${ sessionScope.user.mem_name }" required>
			</div>
			<div class="mb-3">
				<label for="phone" class="form-label">전화번호</label> <input
					type="tel" class="form-control" id="mem_phone" name="mem_phone"
					value="${ sessionScope.user.mem_phone }" required>
			</div>
			<div class="mb-3">
				<label class="form-label">가게 요청사항</label> 
				<textarea class="form-control" id="order_request" name="order_request"></textarea>
			</div>
			<div class="mb-3">
				<label class="form-label">배달 요청사항</label> 
				<textarea class="form-control" id="rider_request" name="rider_request"></textarea>
			</div>




			


		</div>
	</div>
</form>
<div class="acominfo shadow">
	<br>
	<h4 style="text-align: center;">주문 내역</h4>
	<div class="acom-img">
		<c:forEach var="cartVo" items="${cart_list}">
			<br><br>
			<div style="margin-left: 20px; border: 1px solid black; border-radius: 5px; padding-left: 15px;padding-top: 10px; padding-bottom: 10px;">
				<span style="font-weight: bold;">메뉴 이름 :</span><span> ${cartVo.menu_name}</span><br><br>
				<span style="font-weight: bold;">메뉴 가격 :</span><span> ${cartVo.menu_price}</span><br><br>
				<span style="font-weight: bold;">메뉴 수량 :</span><span> ${cartVo.cart_cnt}</span>
				
			</div>
		</c:forEach>
		<div class="hr">
			<hr style="border: 1px solid black;">
		</div>
		<div class="mb-3 cart_price" style="display: inline-block; margin-left: 20px;margin-top: 10px;">
			<label for="cart_price" class="form-label">총 가격</label> <input
				type="hidden" class="form-control" id="cart_price" name="cart_price"
				value="${amount}"readonly>
				<fmt:formatNumber value='${amount}' type='number' pattern='#,###' />
			</div>
		<div class="btn">
			<input type="button" class="btn btn-success"
			onclick="requestPay()" value="결제하기">
		</div>
		
	</div>

</div>
<div style="clear: both;"></div>


	<div class="footer"></div>



</body>
</html>
