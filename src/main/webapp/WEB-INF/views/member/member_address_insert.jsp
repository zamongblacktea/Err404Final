<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>



		<style type="text/css">
			#box {
				width: 400px;
				margin: auto;
			}

			th {
				width: 100px;
				vertical-align: middle !important;
			}

			#id_msg {
				margin-left: 10px;
			}
		</style>




<div id="box">
  <h4>주소록 등록</h4>
<table class="table table-bordered">
  

                <input type="hidden" value="${vo.mem_idx}" id="mem_idx">
     							<!-- 이름 -->
                   <tr>
                    <th>주소명</th>
                    <td><input class="form-control" id="addr_name" style="width: 90%;"></td>
                  </tr>
    
                  <!-- 우편번호 -->
                  <tr>
                    <th>우편번호</th>
                    <td>
                      <input class="form-control" required="required" id="mem_zipcode" name="mem_zipcode" style="width: 90%;">
                      <input class="btn btn-info" type="button" value="주소검색" onclick="find_curaddr();">
                    </td>
                  </tr>
    
                  <!-- 주소 -->
                  <tr>
                    <th>주소</th>
                    <td><input class="form-control" required="required" name="mem_addr" id="mem_addr" style="width: 90%;"></td>
                  </tr>
                      
                    <!-- 버튼 -->
                    <tr>
                      <td colspan="2" align="center">
                        <input class="btn btn-primary" type="button" value="등록하기" onclick="insertAddress()">
                      </td>
                    </tr>



</table>
</div>

