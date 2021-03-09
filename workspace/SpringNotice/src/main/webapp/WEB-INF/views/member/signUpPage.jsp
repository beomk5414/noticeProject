<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- header.jsp --%>
<jsp:include page="../template/header.jsp" >
    <jsp:param value="SignUp Page" name="title"/>
</jsp:include>

<script type="text/javascript">

	var idCheck = false;
	var pwCheck = false;
	var pwCheck2 = false;
	var emailCheck = false;

	// 아이디 정규식
	var regId = /^[a-z][0-9a-z]{4,19}$/;
	// 비밀번호 정규식
	var regPw =  /^(?=.*[a-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/;
	// 이메일 정규식
	var regEmail = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;

	function fn_idCheck(f){
		var input = f.id.value;
		if(!regId.test(input)){
			$('#idCheck').text('입력된 아이디를 확인해주세요.(소문자로 시작하고 5-20자 소문자+숫자)').css('color','red');
			idCheck = false;
		}else {
			$.ajax({
				url:'idCheck.do',
				type: 'post',
				data: $('input[name="id"]'),
				dataType: 'json',
				success : function(responseObj){
					if(responseObj.idCheckResult == 0){
						$('#idCheck').text('사용 가능한 아이디입니다.').css('color','green');
						idCheck = true;
					}else {
						$('#idCheck').text('이미 사용 중인 아이디입니다.').css('color','red');
						idCheck = false;
					}
				},
				error : function(){
					console.log('ajax 통신 실패');
				}
			});
		}
	}

	function fn_pwCheck(f){
		var input = f.pw.value;
		if(!regPw.test(input)){
			$('#pwCheck').text('입력된 비밀번호를 확인해주세요.(영문+숫자+특수문자 8자 이상)').css('color','red');
			pwCheck = false;
		}else {
			$('#pwCheck').text('사용 가능한 비밀번호를 입니다.').css('color','green');
			pwCheck = true;
		}
	}

	function fn_pwCheck2(f){
		var input = f.pw.value;
		var input2 = f.pw2.value;
		if(input != input2){
			$('#pwCheck2').text('입력된 비밀번호가 서로 다릅니다.').css('color','red');
			pwCheck2 = false;
		}else {
			$('#pwCheck2').text('확인되었습니다.').css('color','green');
			pwCheck2 = true;
		}
	}

	function fn_emailCheck(f){
		var input = f.email.value;
		if(!regEmail.test(input)){
			$('#emailCheck').text('입력된 정보가 이메일 형식이 아닙니다.').css('color','red');
			emailCheck = false;
		}else {
			$('#emailCheck').text('확인되었습니다').css('color','green');
			emailCheck = true;
		}
	}

	function fn_signUp(f){
		if(f.name.value == ''){
			alert('이름을 입력해주세요.');
			return;
		}
		if(idCheck && pwCheck && pwCheck2){
			if((f.email.value != '' && emailCheck)||(f.email.value == '')){
				f.action = "signUp.do";
				f.submit(); 
			}else{
				alert('이메일 정보를 확인해주세요.');
				return;
			} 
		}else {
			alert('필수 입력 정보를 확인해주세요.');
			return;
		}
	}
	
</script>

<div class="page-header">
  <h1>회원가입 <small>SignUp</small></h1>
</div>
<form method="post" style="padding-bottom: 50px; width: 70%">
	<div class="form-group">
		<label for="name">이름<span class="require">*</span></label>
		<input type="text" class="form-control" id="name" name="name" placeholder="이름을 입력하세요.">
		<br/>
	</div>
	<div class="form-group">
		<label for="id">아이디<span class="require">*</span></label>
		<input type="text" class="form-control" id="id" name="id" placeholder="아이디를 입력하세요.(소문자로 시작하고 5-20자 소문자+숫자)" onkeyup="fn_idCheck(this.form)">
		<span id="inputStatus1" class=""></span>
		<span id="idCheck" class="checkText"></span>
	</div>
	<div class="form-group">
		<label for="pw">비밀번호<span class="require">*</span></label>
		<input type="password" class="form-control" id="pw" name="pw" placeholder="비밀번호를 입력하세요.(영문+숫자+특수문자 8자 이상)" onkeyup="fn_pwCheck(this.form)">
		<span id="inputStatus2" class=""></span>
		<span id="pwCheck" class="checkText"></span>
	</div>
	<div class="form-group">
		<label for="pw">비밀번호 확인<span class="require">*</span></label>
		<input type="password" class="form-control" id="pw2" name="pw2" placeholder="비밀번호를 한번 더 입력하세요." onkeyup="fn_pwCheck2(this.form)">
		<span id="inputStatus3" class=""></span>
		<span id="pwCheck2" class="checkText"></span>
	</div>
	<div class="form-group">
		<label for="email">이메일</label>
		<input type="email" class="form-control" id="email" name="email" placeholder="이메일을 입력하세요" onkeyup="fn_emailCheck(this.form)">
		<span id="inputStatus4" class=""></span>
		<span id="emailCheck" class="checkText"></span>
	</div>
	<div class="form-group">
		<label for="checkbox1">성별</label>
		<div>
			<label class="form-check-label" for="checkbox1"> 
				<input type="radio" class="form-check-input" name="gender" id="checkbox1" value="Male"> 남성
			</label>
			<label class="form-check-label" for="checkbox2"> 
				<input type="radio" class="form-check-input" name="gender" id="checkbox2" value="Female"> 여성
			</label>
		</div>
	</div>
	<div class="form-group">
		<button type="button" class="btn btn-primary" onclick="fn_signUp(this.form)">제출</button>
		<button type="reset" class="btn btn-default">다시 작성</button>
	</div>
	
</form>
	
<%-- footer.jsp --%>
<%@ include file="../template/footer.jsp" %>