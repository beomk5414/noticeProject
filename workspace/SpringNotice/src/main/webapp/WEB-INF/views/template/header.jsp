<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%
	request.setCharacterEncoding("UTF-8");
	String title = request.getParameter("title");
	if (title == null || title.isEmpty()) {
		title = "Wellcome";
	}
	pageContext.setAttribute("title", title);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="text/html; charset=UTF-8; IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=0" viewport-fit="cover">
<title>${title}</title>

<%-- FontAwesome --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css"/>

<%-- JQuery --%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

<%-- Bootstrap --%>
<link rel="stylesheet" href="/resources/plugIn/bootstrap-3.3.2-dist/css/bootstrap.min.css" >
<link rel="stylesheet" href="/resources/plugIn/bootstrap-3.3.2-dist/css/bootstrap-theme.css" >
<link rel="stylesheet" href="/resources/plugIn/bootstrap-3.3.2-dist/css/narrow-jumbotron.css" >
<!-- <link rel="stylesheet" href="/resources/plugIn/bootstrap-3.3.2-dist/css/signin.css" > -->
<script src="/resources/plugIn/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>

<%-- CSS --%>
<link rel="stylesheet" type="text/css" href="/resources/style/common.css" />

</head>

<body>
	<div class="header">
		<div class="container">
		<nav>
			<ul class="nav nav-pills pull-right">
				<c:if test="${loginDto eq null}">
					<li role="presentation"><a href="loginPage.do">로그인</a></li>
					<li role="presentation"><a href="signUpPage.do">회원가입</a></li>
					<li role="presentation"><a href="noticeListPage.do">공지사항</a></li>
				</c:if>
				<c:if test="${loginDto ne null}">
					<li role="presentation"><span style="line-height: 40px;">${loginDto.name}님 환영합니다!&nbsp;&nbsp;</span></li>
					<li role="presentation"><a href="logout.do">로그아웃</a></li>
					<li role="presentation"><a href="noticeListPage.do">공지사항</a></li>
				</c:if>
			</ul>
		</nav>
		<a href="/"><h3 class="text-muted">Spring Notice</h3></a>
		</div>
	</div>
	<div class="container body-min-height">
