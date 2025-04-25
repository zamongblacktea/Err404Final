<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<table class="table table-bordered">
  <thead>
    <tr>
      <th>주소명</th>
      <th>기본주소</th>
      <th>선택</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="addr" items="${ list }">
      <tr>
        <td>${addr.addr_name}</td>
        <td>${addr.mem_addr1} ${addr.mem_addr2}</td>
        <td>
          <button class="btn btn-sm btn-success" onclick="selectAddr('${addr.mem_addr1}', '${addr.mem_addr2}')">선택</button>
        </td>
      </tr>
    </c:forEach>
  </tbody>
</table>