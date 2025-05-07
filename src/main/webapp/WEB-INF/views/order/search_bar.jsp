<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- bootstrap 3.x 사용설정 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>


<style>

	.search-container {
		display: flex;
		width: 600px;
		float: right;
		padding-left: 50px;
		margin-bottom: 20px;
		background: white;
		border-radius: 20px;


		
		
	}
	
	.date-box, .people-box {
		display: flex;
		align-items: center;
		background: #f6f4f2;
		padding: 12px 15px;
		border-radius: 25px;
		margin-right: 8px;
		transition: background 0.3s ease;
		cursor: pointer;
		font-size: 20px;
	}
	
	
	/* .search-box {
		width: 200px;
		display: flex;
		background: #f6f4f2;
		padding: 12px 15px;
		border-radius: 25px;
		margin-right: 8px;
		transition: background 0.3s ease;
		cursor: pointer;
		font-size: 20px;
	
	
	} */
	
	.search-box input, .date-box input, .people-box input {
		border: none;
		background: none;
		outline: none;
		margin-left: 8px;
		color: #555;
		width: 150px;
		font-size: 15px;
	}
	
	.search-btn {
		background: #ff6600;
		text-align: center;
		color: white;
		border: none;
		width: 80px;
		padding: 12px 20px;
		border-radius: 25px;
		font-size: 18px;
		cursor: pointer;
		transition: background 0.3s ease;
	}
	
	/* Hover 효과 */
	.search-box:hover, .date-box:hover, .people-box:hover {
		background: #eceae7;
	}
	
	.search-btn:hover {
		background: #e55b00;
	}
	

	
	</style>



</head>

<form>

	<!-- 검색어 입력 -->
	<div class="search-container">
	<!-- <div class="search-box">
        <input type="text" class="search_text form-control w-300" id="search_text" value="${ param.search_text }" placeholder="">
	</div> -->

	<!-- 날짜 선택 -->
	<div class="date-box">
		<span class="icon">📅</span> <input type="date" class="form-control w-150" id="start_date" name="start_date">


		<input type="date" class="form-control w-150" id="end_date" name="end_date">
	</div>





	<!-- 검색 버튼 -->
        <input type="button" class="search-btn" id="info-button" value="검색" onclick="selectSales('date','${shop_idx}');">

	</div>
</form>






