<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%-- header.jsp --%>
<jsp:include page="../template/header.jsp">
	<jsp:param value="View Notice Page" name="title" />
</jsp:include>

<script type="text/javascript" src="/resources/plugIn/SmartEditor2/js/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript">
function fn_noticeDelte(f){
	if(confirm('삭제할까요?')){
		 f.action = 'noticeDelete.do';
		 f.submit();
	}
}
function fn_noticeUpdatePage(f){
	 f.action = 'noticeUpdatePage.do';
	 f.submit();
}
</script>

<div class="page-header">
  <h1>${noticeDto.title} <small></small></h1>
</div>
<div class="notice-content">
	<div class="notice-view">
		<form class="form-horizontal" method="post">
			<div class="form-group">
				<label for="writer" class="col-sm-2 control-label">작성자</label>
				<div class="col-sm-3">
					<pre>${noticeDto.writer}</pre>
					<input type="hidden" name="title" value="${noticeDto.title}">
					<input type="hidden" name="writer" value="${noticeDto.writer}">
				</div>
			</div>
			<div class="form-group">
				<label for="inputEmail3" class="col-sm-2 control-label">작성일</label>
				<div class="col-sm-3">
					<pre>${noticeDto.regDate}</pre>
					<input type="hidden" name="regDate" value="${noticeDto.regDate}">
				</div>
			</div>
			<div class="form-group">
				<label for="inputEmail3" class="col-sm-2 control-label">최종 수정일</label>
				<div class="col-sm-3">
					<pre>${noticeDto.lastEdited}</pre>
					<input type="hidden" name="lastEdited" value="${noticeDto.lastEdited}">
				</div>
			</div>
			<div class="form-group">
				<label for="inputEmail3" class="col-sm-2 control-label">내용</label>
				<div class="col-sm-10">
					<input type="hidden" name="content" value='${noticeDto.content}'>
					<pre>${noticeDto.content}</pre>
				</div>
			</div>
			<div class="form-group">
				<label for="inputEmail3" class="col-sm-2 control-label">첨부 파일</label>
				<div class="col-sm-9">
					<c:if test="${noticeDto.filename ne '' && not empty noticeDto.filename }">
						<input type="hidden" name="filename" value="${noticeDto.filename}">
						<c:set var="filenameList" value="${fn:split(noticeDto.filename,'&')}"/>
						<c:forEach var="filename" items="${filenameList}">
							<pre><a href="download.do?filename=${filename}"><i class="fas fa-file-download"></i> ${filename}</a></pre>
						</c:forEach>
					</c:if>
					<c:if test="${noticeDto.filename eq '' || empty noticeDto.filename }">
						<pre>첨부 파일 없음</pre>
					</c:if>
				</div>
			</div>
			<br/>
			<div class="form-group text-center mb50">
				<input type="hidden" name="no" value="${noticeDto.no}">
				<input type="hidden" name="page" value="${page}">
			<c:if test="${loginDto.role eq 'ADMIN'}">
				<input class="btn btn-info" type="button" value="수정 하기" onclick="fn_noticeUpdatePage(this.form)"/>
				<input class="btn btn-warning" type="button" value="삭제 하기" onclick="fn_noticeDelte(this.form)"/>
			</c:if>
				<input class="btn btn-default" type="button" value="목록으로" onclick="location.href = 'noticeListPage.do?page=${page}'"/>
			</div>
		</form>
	</div>
</div>


<%-- footer.jsp --%>
<%@ include file="../template/footer.jsp"%>