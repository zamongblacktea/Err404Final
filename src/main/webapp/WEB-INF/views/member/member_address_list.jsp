<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
<script>

function selectAddr(addr1, addr2) {

  //주소록 선택했을 때 확인 조건문
  if(selectAddr){
  
  confirm("해당 주소로 변경하시겠습니까?")==false
  // input 박스에 값 세팅
  $('#mem_addr1').val(addr1);
  $('#mem_addr2').val(addr2);
  
  // 모달 닫기
    const modal = bootstrap.Modal.getInstance(document.getElementById('myModal'));
  if (modal) {
    modal.hide();
  }
  }

}

function addr_modify(mem_idx,mcuraddr_idx) {
  $('#mem_idx').val(mem_idx);
  $('#mcuraddr_idx').val(mcuraddr_idx);
  console.log("addr_modify 호출 mem_idx:", mem_idx);
  console.log("addr_modify 호출 mcuraddr_idx:", mcuraddr_idx);
  $.ajax({
    url: '/member/address_form.do',
    type: 'GET',
    data: { "mem_idx": mem_idx,
            "mcuraddr_idx" : mcuraddr_idx

          },
    success: function(response) {
      $('#addressModalBody').html(response); 
      console.log("모달 오픈 직후 mem_idx:", $('#mem_idx').val());
      console.log("모달 오픈 직후 mcuraddr_idx:", $('#mcuraddr_idx').val());
    },
    error: function(xhr, status, error) {
      alert('페이지 로딩 실패: ' + error);
    }
  });
}

</script>

</head>

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
          <button type="button" class="btn btn-sm btn-success" onclick="addr_modify('${addr.mem_idx}', '${addr.mcuraddr_idx}')">수정</button>
          <button type="button" class="btn btn-sm btn-success" onclick="selectAddr('${addr.mem_addr1}', '${addr.mem_addr2}')">선택</button>
        </td>
      </tr>
    </c:forEach>
  </tbody>
</table>
<input type="hidden"  id="mem_idx">
<input type="hidden"  id="mcuraddr_idx">