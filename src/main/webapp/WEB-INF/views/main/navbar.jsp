<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    .navbar{
        background:#ff694a ;
        width: 100%;
        height: 80px;

    }

</style>
</head>
<body>
    <div class="navbar">
                    <!-- 로그인이 안되었을 경우(session에 user가 없냐?) -->
                    <c:if test="${ empty sessionScope.user }">
                        <input class="btn btn-primary" type="button" value="로그인" onclick="location.href='login_form.do'">
                      </c:if>
          
                      <!-- 로그인이 되어있을 경우(session에 user가 있냐?) -->
                      <c:if test="${ not empty sessionScope.user }">
                        <b>${ user.mem_name }</b>님 환영합니다
                        <input class="btn btn-primary" type="button" value="로그아웃" onclick="location.href='logout.do'">
                      </c:if>

    </div>
</body>
</html>