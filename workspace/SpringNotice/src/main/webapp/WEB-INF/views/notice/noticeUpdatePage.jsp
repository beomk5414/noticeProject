<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%-- header.jsp --%>
<jsp:include page="../template/header.jsp">
	<jsp:param value="Update Notice Page" name="title" />
</jsp:include>

<script type="text/javascript" src="/resources/plugIn/SmartEditor2/js/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript">
	function fn_goList(f){
		location.href = "noticeListPage.do";
	}
	function fn_fileRemove(filename, index){
		$('<input/>', {type: 'hidden', name: 'removeFile', value: filename }).appendTo('#removeFile')
		$('#file-' + index).remove(); 
		$('#filename-' + index).attr('name','removeFilename'); 
	}
</script>

<div class="page-header">
  <h1>글 수정하기<small> Update Notice</small></h1>
</div>
<div class="notice-content">
	<div class="notice-insert">
		<form method="post" enctype="multipart/form-data">
			<div class="form-group">
				<label for="title">제목<span class="require">*</span></label>
				<input type="text" class="form-control" id="title" name="title" value="${noticeDto.title}" placeholder="제목을 입력하세요.(최대 50자)">
			</div>
			<div class="form-group">
				<label for="writer">작성자<span class="require">*</span></label>
				<input type="text" class="form-control" id="writer" name="writer" value="${noticeDto.writer}" style="width: 30%" readonly>
			</div>
			<div class="form-group">
				<label for="smartEditor">내용</label>
				<textarea name="content" id="smartEditor" style="width: 80%">${noticeDto.content}</textarea>
			</div>
			<div class="form-group">
				<label for="title">첨부 파일/이미지 (복수 등록 가능)</label>
				<input type="file" class="form-control" name="filename" id="filename" style="width: 50%" multiple/><br/>
				<c:if test="${noticeDto.filename ne '' && not empty noticeDto.filename }">
					<c:set var="filenameList" value="${fn:split(noticeDto.filename,'&')}"/>
					<c:forEach var="filename" items="${filenameList}" varStatus="k">
						<input type="hidden" name="originFilename" value="${filename}" id="filename-${k.index}">
						<pre id="file-${k.index}"><input type="button" class="require text-right" style="border: 0; background: none" value="x" onclick="fn_fileRemove('${filename}','${k.index}')"/> ${filename} </pre>
					</c:forEach>
				</c:if>
				<c:if test="${noticeDto.filename eq '' || empty noticeDto.filename }">
					<pre>첨부 파일 없음</pre>
				</c:if>
			</div>
			<br/>
			<div class="form-group text-center mb50">
				<input type="hidden" name="no" value="${noticeDto.no}">
				<input type="hidden" name="page" value="${page}">
				<input class="btn btn-primary" type="button" value="수정 하기" onclick="fn_noticeUpdate(this.form)"/>
				<input class="btn btn-default" type="button" value="뒤로가기" onclick="location.href = 'noticeViewPage.do?no=${noticeDto.no}&page=${page}'"/>
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
	
	function fn_noticeUpdate(f){
		
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
		
		var result = confirm("게시글을 수정 하시겠습니까?"); 
		if(result){ 
			f.action = 'noticeUpdate.do'; 
			f.submit(); 
		}else { 
			return; 
		}
	}
</script>