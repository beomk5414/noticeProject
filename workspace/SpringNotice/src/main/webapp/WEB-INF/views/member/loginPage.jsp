<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="text/html; charset=UTF-8; IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=0" viewport-fit="cover">
<title>Login Page</title>

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

<body style="background: #eee;">
	<div class="container body-min-height text-center pt100 mb50">
		<a href="/"><h3 class="text-muted">Spring Notice</h3></a>

	<form class="form-signin" method="post" action="login.do">
		<h2 class="form-signin-heading"></h2>
		<label for="id" class="sr-only">Email address</label>
		<input type="text" name="id" id="id" class="form-control" placeholder="ID" required="" autofocus="" style="margin-bottom: 5px;"> 
		<label for="pw" class="sr-only">Password</label> 
		<input type="password" name="pw" id="pw" class="form-control" placeholder="Password" required=""><br/>
		<button class="btn btn-lg btn-primary btn-block" type="submit">로그인</button>
	</form>
</div>

<%-- footer.jsp --%>
<%@ include file="../template/footer.jsp"%>