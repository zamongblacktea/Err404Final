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
    /* !important 최우선 적용 */
    margin-bottom: 0 !important; 
    border-radius: 0 !important;
    clear: both;
}


#logo_img{
    margin: 0 auto;
    width: 310px;
    height: 75px;


}

.login-btn{
    margin-top: 25px;
    margin-right: 20px;
    float: right;

    /* background-color: #ff694a; */
    background-color: #ffae9d;
    color: white;
    font-weight: bold;


}


</style>
</head>
<body>
    <div class="navbar">
        <img id="logo_img" src="${pageContext.request.contextPath}/images/로고.png" onclick="location.href='/main/main.do'" >            
        
        <!-- 로그인이 안되었을 경우(session에 user가 없냐?) -->
        <c:if test="${ empty sessionScope.user }">
            <input class="btn login-btn" type="button" value="로그인" onclick="location.href='../member/login_form.do'">
            </c:if>

            <!-- 로그인이 되어있을 경우(session에 user가 있냐?) -->
            <c:if test="${ not empty sessionScope.user }">
            <input class="btn login-btn" type="button" value="로그아웃" onclick="location.href='../member/logout.do'">
            <input class="btn login-btn" type="button" value="내 정보" onclick="location.href='../member/member_main.do?mem_idx=${sessionScope.user.mem_idx}'">
            <input class="btn login-btn" type="button" value="내 주문" onclick="location.href='../member/modify_form.do?mem_idx=${sessionScope.user.mem_idx}'">
            </c:if>

    </div>
</body>
</html>