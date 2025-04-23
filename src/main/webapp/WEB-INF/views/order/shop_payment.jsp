<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<link rel="stylesheet" href="../css/main.css">
<link rel="stylesheet" href="../css/bar.css">


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
	background: white;
	padding: 20px;
	border-radius: 10px;
	margin-top: 50px;
	margin-right: 10px;
	float: left;
}

.acominfo {
	width: 38%;
	height: auto; background : white;
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
</style>





<!-- 포트원 SDK 라이브러리 추가 -->
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script src="https://cdn.portone.io/v2/browser-sdk.js"></script>
<script>
	IMP.init("imp23446565"); // 아임포트 가맹점 고객사 식별 코드 입력

	//임시로 보낼 변수값 1 설정을 위해 앞에 Number 형변환 해놨으니 실제 연동할 땐 제거해야 함
	function requestPay() {
		const mem_idx = Number($("#mem_idx").val());
		const shop_idx = Number($("#shop_idx").val());
		const menu_idx = Number($("#menu_idx").val());
		const mcuraddr_idx = Number($("#mcuraddr_idx").val()); //회원 현재주소지 기준으로 바꿀 때 쓸 변수 설정
		const menu_name = $("#menu_name").val();
		const cart_idx = Number($("#cart_idx").val());
		const cart_price = $("#cart_price").val();
		const mem_name = $("#mem_name").val();
		const mem_phone = $("#mem_phone").val();
		const mem_curaddr = $("#mem_curaddr").val();


		IMP.request_pay({
			channelKey : "channel-key-7c367284-0269-40b7-aba7-b1437d2fbaaf", // 콘솔에서 발급한 채널키 입력
			pay_method : "card", // 결제 수단 (신용카드)
			merchant_uid : "payment-" + new Date().getTime(), // 주문 고유번호 (현재 타임스탬프 사용)
			name : "Eatting 주문 결제 테스트",
			amount : cart_price, // 결제 금액 (원) 임시 고정값 20000으로 설정됨 test 마치면 바꿔야 함
			buyer_name : mem_name,
			buyer_tel : mem_phone,
			buyer_curaddr : mem_curaddr,
		}, function(response) {
			if (response.success) {
				console.log("결제 성공:", response);
				alert("결제가 완료되었습니다! 결제 ID: " + response.imp_uid);

				// 서버에 결제 검증 요청 (AJAX 사용)

				verifyPayment(	response.imp_uid, 
								response.merchant_uid,	
								mem_idx,
								menu_idx,
								shop_idx,
								cart_idx,
								mcuraddr_idx,
								mem_name,
								mem_phone,
								mem_curaddr);
				console.log("mem_idx:", mem_idx);

				location.href="../main/main.do?mem_idx=" + mem_idx;//메인 페이지로 이동

			} else {
				console.error("결제 실패:", response.error_msg);
				alert("결제 실패: " + response.error_msg);
			}
		});
	}

	// AJAX를 사용한 결제 검증 요청
	function verifyPayment(imp_uid, merchant_uid, mem_idx, menu_idx, shop_idx, cart_idx, mcuraddr_idx, mem_name, mem_phone, mem_curaddr) {
		//form에 설정한 변수 선언


		//alert(`[\${mem_idx}]`);
		//Rest APi 형식으로 보내기
		//test 용으로 idx 값 1로 설정
		//실제 연동할 땐 mem_idx 제외 다 연동값 들어가게 설정해야 함 "mcuraddr_idx" : mcuraddr_idx, 추가
		console.log("서버 전송 mem_idx:", mem_idx);
		$.ajax({
			url : "verify.do",
			type : "POST",
			contentType: "application/json",
			data : JSON.stringify({
				"imp_uid" : imp_uid,
				"merchant_uid" : merchant_uid,
				"mem_idx" : mem_idx,
				"menu_idx" : 1,
				"shop_idx" : 1,
				"cart_idx" : 1,
				"mcuraddr_idx" : 1,
				"mem_name": mem_name,
				"mem_phone": mem_phone,
				"mem_curaddr" : mem_curaddr,

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

</head>
<body>
	<div class="container">

		<div class="rsvform shadow">
			<h2 class="text-center mb-4">결제 페이지</h2>
			<form id="bookingForm">
				<input type="hidden" name="mem_idx" id="mem_idx" value="${sessionScope.user.mem_idx }"> 
				<!-- 테스트 후 변경해야 함 -->
				<!-- <input type="hidden" name="shop_idx" id="shop_idx" value="${sessionScope.user.mem_idx }"> 
				<input type="hidden" name="cart_idx" id="cart_idx" value="${sessionScope.user.mem_idx }"> 
				<input type="hidden" name="menu_idx" id="menu_idx" value="${sessionScope.user.mem_idx }"> 
				<input type="hidden" name="mcuraddr_idx" id="mcuraddr_idx" value="${sessionScope.user.mem_idx }">  -->
				<div class="mb-3">
					<label for="addr" class="form-label">주소</label> <input type="text"
							class="form-control" id="mem_curaddr" name="mem_curaddr"
							value="${ sessionScope.user.mem_addr }" required>
				</div>
				<div class="mb-3">
					<label for="name" class="form-label">이름</label> <input type="text"
						class="form-control" id="mem_name" name="mem_name"
						value="${ sessionScope.user.mem_name }" required>
				</div>
				<div class="mb-3">
					<label for="phone" class="form-label">전화번호</label> <input
						type="tel" class="form-control" id="mem_phone" name="mem_phone"
						value="${ sessionScope.user.mem_phone }" required>
				</div>



				<div class="mb-3">
				<label for="cart_price" class="form-label">가격</label> <input
						type="hidden" class="form-control" id="cart_price" name="cart_price"
						value="20000"
						readonly>
						<fmt:formatNumber value='20000' type='number' pattern='#,###' />

				</div>

	
		</div>
		<div class="acominfo shadow">
			<h4>주문 내역</h4>
			<div class="acom-img">
				주문 정보 입력
			</div>
			<div class="hr">
				<hr style="border: 1px solid black;">
			</div>
			<div class="btn">
				<input type="button" class="search-btn"
					onclick="requestPay()" value="결제하기">
			</div>

			<div style="clear: both;"></div>
		</div>
		</form>



	</div>



	<div class="footer"></div>

</body>
</html>
