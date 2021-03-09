<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%-- header.jsp --%>
<jsp:include page="template/header.jsp">
	<jsp:param value="Home" name="title" />
</jsp:include>

<script type="text/javascript">
	if('${param.signUpResult}' > 0){
		alert('회원이 되신것을 환영합니다. 로그인 페이지로 이동합니다.');
		location.href = 'loginPage.do';
	}
</script>

<div class="jumbotron">
	<h1 class="display-4">Project Introduce</h1>
	<p class="lead">해당 프로젝트는 Spring Boot MVC 기반의 공지사항 게시판 기능의 Web개발 프로젝트입니다.
		<br/>주요 기능으로는 회원가입, 로그인, 공지사항 조회, 추가, 수정, 삭제 등의 기능이 구현되어 있습니다.
		<br/>아래 로그인 버튼을 통해 로그인 하시면 해당 기능들을 확인하실수 있습니다.
	</p>
	<p>
		<a class="btn btn-lg btn-success" href="loginPage.do" role="button">로그인 하기</a>
	</p>
</div>

<div class="row marketing">
	<div class="col-lg-6">
		<h4>Spring Boot</h4>
		<p>
			Spring Boot MVC기반의 개발환경 셋팅(Gradle)<br/>
			WAS - Spring Boot에 내장된 Tomcat 서버 사용
		</p>

		<h4>Persistence Framework</h4>
		<p>
			SQL Mapper 방식의 Mybatis를 활용한 H2 Database JDBC 처리 및
			HicariCP 방식의 Connection Pool 사용
		</p>

		<h4>Database</h4>
		<p>내장된 인메모리 DB방식의 H2 Database 사용</p>
	</div>

	<div class="col-lg-6">
		<h4>Viewer</h4>
		<p>
			Bootstrap 라이브러리를 사용한 반응형 사이트 구현<br/>
			JavaScript, JQuery, JSTL 등을 통한 Viewer 구현
		</p>

		<h4>REST API</h4>
		<p> 공지사항 등록시 Naver 이미지 캡차API를 활용한 자동입력 방지 문자입력 기능 구현.</p>

		<h4>GitHub</h4>
		<p>Source Code: <a href="https://github.com/beomk5414/SpringNoticeProject">https://github.com/beomk5414/SpringNoticeProject</a></p>
	</div>
</div>



<%-- footer.jsp --%>
<%@ include file="template/footer.jsp"%>