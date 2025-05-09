<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<table class="table table-bordered">
  <thead>
    <tr>
      <th>주소명</th>
      <th style="text-align: center;">주소</th>
      <th style="text-align: center;">선택</th>
      <th style="text-align: center;">수정</th>

    </tr>
  </thead>
  <tbody>
    <c:forEach var="addr" items="${ list }">
      <tr>
        <td>${addr.addr_name}</td>
        <td>${addr.mem_addr1} ${addr.mem_addr2}</td>
        <td>
          <button type="button" class="btn btn-sm btn-success" onclick="selectAddr('${addr.mem_addr1}', '${addr.mem_addr2}','${addr.mcuraddr_idx}')">선택</button>          
        </td>
        <td>
          <button type="button" class="btn btn-sm btn-success" onclick="addr_modify('${addr.mem_idx}', '${addr.mcuraddr_idx}')">수정</button>
        </td>
      </tr>
    </c:forEach>
  </tbody>
</table>
<input type="hidden"  id="mem_idx">
<input type="hidden"  id="mcuraddr_idx">