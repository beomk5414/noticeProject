<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- header.jsp --%>
<jsp:include page="../template/header.jsp">
	<jsp:param value="Add Notice Page" name="title" />
</jsp:include>

<script type="text/javascript" src="/resources/plugIn/SmartEditor2/js/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript">

	$(function(){
		fn_loginCheck();
		fn_getImageCaptcha();
	});

	function fn_loginCheck(){
		var loginDto = '${loginDto}';
		if(loginDto == null || loginDto == ''){
			alert('로그인이 필요한 페이지입니다.');
			location.href = 'loginPage.do';
			return;
		}
		if('${loginDto.role}' == 'USER'){
			alert('접근 권한이 없습니다.');
			location.href = 'index.do';
			return;
		}
		
	}
	
	function fn_goList(f){
		location.href = "noticeListPage.do"
	}

	function fn_getImageCaptcha(){
		$.ajax({
			url: 'getImageCaptcha.do',
			type: 'post',
			dataType: 'json',
			success : function(responseObj){
				if(responseObj.filename != ''){
					$('#captchaImg').attr('src','resources/storage/captcha/' + responseObj.filename);
				}
			},
			error: function(){
				console.log('ajax 통신 실패');
			}
		});
	}
</script>

<div class="page-header">
  <h1>새 글 작성하기<small> New Notice</small></h1>
</div>
<div class="notice-content">
	<div class="notice-insert">
		<form method="post" enctype="multipart/form-data">
			<div class="form-group">
				<label for="title">제목<span class="require">*</span></label>
				<input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력하세요.(최대 50자)">
			</div>
			<div class="form-group">
				<label for="writer">작성자<span class="require">*</span></label>
				<input type="text" class="form-control" id="writer" name="writer" readonly value="${loginDto.id}" style="width: 30%">
			</div>
			<div class="form-group">
				<label for="smartEditor">내용</label>
				<textarea name="content" id="smartEditor" style="width: 80%"></textarea>
			</div>
			<div class="form-group">
				<label for="title">첨부 파일/이미지 (복수 등록 가능)</label>
				<input type="file" class="form-control" name="filename" id="filename" style="width: 50%" multiple/>
			</div><br/>
			<div class="form-group">
				<img id="captchaImg" src="" style="width:300px; margin-bottom: 10px" alt="캡차이미지" /><br/>
				<input type="text" class="form-control" name="input_key" placeholder="자동입력 방지문자" style="width: 30%; display: inline-block;" />
				<input class="btn btn-default" type="button" value="새로고침" onclick="fn_getImageCaptcha()"/><br/><br/>
			</div>
			<br/>
			<div class="form-group text-center mb50">
				<input class="btn btn-primary" type="button" value="등록 하기" onclick="fn_noticeInsert(this.form)"/>
				<input class="btn btn-default" type="button" value="목록으로" onclick="location.href = 'noticeListPage.do'"/>
			</div>
		</form>
	</div>
</div>


<%-- footer.jsp --%>
<%@ include file="../template/footer.jsp"%>
<script>
	var oEditors = []; 
	nhn.husky.EZCreator.createInIFrame({ 
		oAppRef : oEditors, elPlaceHolder : "smartEditor", 
		sSkinURI : "/resources/plugIn/SmartEditor2/SmartEditor2Skin.html", 
		fCreator : "createSEditor2", 
		htParams : { 
			bUseToolbar : true, // 툴바 사용 여부 (true:사용/ false:사용하지 않음) 
			bUseVerticalResizer : false, // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음) 
			bUseModeChanger : false } // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음) 
	});
	
	
	function fn_noticeInsert(f){

		oEditors.getById["smartEditor"].exec("UPDATE_CONTENTS_FIELD", []); 

		if(f.title.value == ''){
			alert('제목을 입력해주세요.');
			f.title.focus();
			return;
		}

		if(f.writer.value == ''){
			alert('작성자를 입력해주세요.');
			f.writer.focus();
			return;
		}

		if(f.input_key.value == ''){
			alert('자동입력 방지문자를 입력해주세요.');
			f.input_key.focus();
			return;
		}else{
			$.ajax({
				url: 'captchaKeyCheck.do',
				type: 'post',
				data: $('input[name="input_key"]'),
				dataType: 'json',
				success : function(responseObj){
					console.log(responseObj.result);
					if(responseObj.result != false){
						f.action = 'noticeInsert.do'; 
						f.submit(); 
					}else{
						alert('자동입력 방지문자를 다시 입력해주세요.');
						return;
					}
				},
				error: function(){
					console.log('ajax 통신 실패');
				}
			});
		}
	}
</script>