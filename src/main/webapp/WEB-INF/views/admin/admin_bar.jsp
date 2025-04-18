<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
*, :before, :after {
  box-sizing: border-box;
}

/* HEADER STYLES */
.header {
  position: fixed;
  left: 0;
  top: 0;
  bottom: 0;
  width: 17.5em;
  background: #35302D;
}

.logo {
  text-transform: lowercase;
  font: 300 2em 'Source Sans Pro', Helvetica, Arial, sans-serif;
  text-align: center;
  padding: 0;
  margin: 0;
}
.logo a {
  display: block;
  padding: 1em 0;
  color: #DFDBD9;
  text-decoration: none;
  transition: 0.15s linear color;
}
.logo a:hover {
  color: #fff;
}
.logo a:hover span {
  color: #DF4500;
}
.logo span {
  font-weight: 700;
  transition: 0.15s linear color;
}

/* MAIN NAV */
.main-nav ul {
  border-top: solid 1px #3C3735;
}
.main-nav li {
  border-bottom: solid 1px #3C3735;
}
.main-nav a {
  padding: 1.1em 0;
  color: #DFDBD9;
  font: 400 1.125em 'Source Sans Pro', Helvetica, Arial, sans-serif;
  text-align: center;
  text-transform: lowercase;
}
.main-nav a:hover {
  color: #fff;
}

/* SOCIAL LINKS */
.social-links {
  border-bottom: solid 1px #3C3735;
}
.social-links li {
  width: 25%;
  border-left: solid 1px #3C3735;
}
.social-links li:first-child {
  border: none;
}
.social-links a {
  display: block;
  height: 5.5em;
  text-align: center;
  color: #3C3735;
  font: 0.75em/5.5em 'Source Sans Pro', Helvetica, Arial, sans-serif;
}
.social-links a:hover {
  color: #DFDBD9;
}

/* REUSABLE STYLES */
.unstyled {
  list-style: none;
  padding: 0;
  margin: 0;
}
.unstyled a {
  text-decoration: none;
}
.list-inline {
  overflow: hidden;
}
.list-inline li {
  float: left;
}

/* HOVER SLIDE EFFECT */
.list-hover-slide li {
  position: relative;
  overflow: hidden;
}
.list-hover-slide a {
  display: block;
  position: relative;
  z-index: 1;
  transition: 0.35s ease color;
}
.list-hover-slide a:before {
  content: '';
  display: block;
  z-index: -1;
  position: absolute;
  left: -100%;
  top: 0;
  width: 100%;
  height: 100%;
  border-right: solid 5px #DF4500;
  background: #3C3735;
  transition: 0.35s ease left; 
}
.list-hover-slide a.is-current:before,
.list-hover-slide a:hover:before {
  left: 0;
}


</style>
</head>
<body>
    <header class="header" role="banner">
        <h1 class="logo">
          <a href="#">Eatting <span>관리자용</span></a>
        </h1>
        <div class="nav-wrap">
          <nav class="main-nav" role="navigation">
            <ul class="unstyled list-hover-slide">
              <li><a href="list.do?mem_idx=${ user.mem_idx }&mem_grade=${ user.mem_grade }">회원 목록</a></li>
              <li><a href="owner_approve.do?mem_idx=${ user.mem_idx }&mem_grade=${ user.mem_grade }">사업자 승인</a></li>
              <li><a href="rider_approve.do?mem_idx=${ user.mem_idx }&mem_grade=${ user.mem_grade }">라이더 승인</a></li>
              <li><a href="#">Blog</a></li>
            </ul>
          </nav>
        </div>
      </header>

</body>
</html>