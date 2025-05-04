<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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

<style>

#box{

    margin: 0 auto;


}    

table {
  border-collapse: separate;
  border-spacing: 0;
  width: 100%;
}

th,td {
  padding: 6px 15px;
}
th {
  background: #0e6d74 !important; 
  color: #fff;
  text-align: center !important;
}

tr:first-child th:first-child {
  border-top-left-radius: 6px;
}

tr:first-child th:last-child {
  border-top-right-radius: 6px;
}

td {
  text-align: center;
  border-right: 1px solid #c6c9cc;
  border-bottom: 1px solid #c6c9cc;
}
td:first-child {
  border-left: 1px solid #c6c9cc;
}
tr:nth-child(even) td {
  background: #eaeaed;
}
tr:last-child td:first-child {
  border-bottom-left-radius: 6px;
}
tr:last-child td:last-child {
  border-bottom-right-radius: 6px;
}
.button-box{
    margin-top: 10px;
    margin-bottom: 10px;

}


</style>



</head>

<body>
    <div id="box">
        <input type="hidden" id="shop_idx" value="${param.shop_idx}">

        <h1>정산 내역</h1>

        <hr style="margin-top: 30px; margin-bottom: 30px;">

      <div class="button-box" style="float: left;">
        <input type="button" class="btn btn-success active" id="oneDay" value="일간" onclick="selectSales('oneDay','${shop_idx}');">
        <input type="button" class="btn btn-success"  id="weekly" value="주간(최근 7일)" onclick="selectSales('weekly','${shop_idx}');">
        <input type="button" class="btn btn-success"  id="monthly" value="월간" onclick="selectSales('monthly','${shop_idx}');">
      </div>

      <div>
        <%@ include file="search_bar.jsp" %>
      </div>
            <div style="clear: both;"></div>
    </div>
    <div id="disp">
      <div id="salesTable">

      </div>
    </div>
</body>

<script>
    //정산 기간별 조회 ajax
    function selectSales(day_type , shop_idx) {
      const start_date = $("#start_date").val();
      const end_date = $("#end_date").val();
      $.ajax({
          url: '/order/order_sales.do',
          type: 'GET',
          data: { day_type: day_type,
                  shop_idx: shop_idx,
                  start_date: start_date,
                  end_date: end_date,

           }, 
          success: function(res) {

              $('#salesTable').html(res);
          }
      });
  }
  // //검색 날짜별 정산 조회
  // function searchDate() {
  //   const day_type = date;
  //   const shop_idx = $("#shop_idx").val();
  //   const start_date = $("#start_date").val();
  //   const end_date = $("#end_date").val();
  //     $.ajax({
  //         url: '/order/order_sales.do',
  //         type: 'GET',
  //         data: { day_type : day_type,
  //                 start_date: start_date,
  //                 end_date: end_date,
  //                 shop_idx: shop_idx,
  //          }, 
  //         success: function(res) {

  //             $('#salesTable').html(res);
  //         }
  //     });
  // }

  $(document).ready(function(){
  
  
  });
  
  
  
  </script>

</html>
