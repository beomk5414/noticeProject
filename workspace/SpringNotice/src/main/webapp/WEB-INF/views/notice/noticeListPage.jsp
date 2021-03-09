<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- header.jsp --%>
<jsp:include page="../template/header.jsp">
	<jsp:param value="Notice Page" name="title" />
</jsp:include>

<div class="page-header">
  <h1>공지사항 <small>Notice</small></h1>
</div>
전체 게시글 : ${totalRecord }개<br/><br/>
<table class="table table-striped mb50 text-center">
	<thead>
		<tr>
			<td>No.</td>
			<td>제목</td>
			<td>작성자</td>
			<td>작성일</td>
			<td>최종수정일</td>
			<td>첨부</td>
		</tr>
	</thead>
	<tbody>
		<c:if test="${empty list}">
			<tr>
				<th colspan="6">
					등록된 공지사항이 없습니다.
				</th>
			</tr>
		</c:if>
		<c:if test="${not empty list}">
			<c:forEach var="noticeDto" items="${list}" varStatus="k">
				<tr>
					<td>${totalRecord - ((page - 1) * recordPerPage + k.index)}</td>
					<td><a href="noticeViewPage.do?no=${noticeDto.no}&page=${page}">${noticeDto.title}</a></td>
					<td>${noticeDto.writer}</td>
					<td>${noticeDto.regDate}</td>
					<td>${noticeDto.lastEdited}</td>
					<td>
						<c:if test="${noticeDto.filename ne '' || not empty noticeDto.filename }">
							<i class="fas fa-paperclip"></i>
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</tbody>
	<tfoot>
		<tr>
			<th colspan="6" class="text-center">
				${paging}<br/>
			    <c:if test="${loginDto.role eq 'ADMIN'}">
					<a href="noticeInsertPage.do">새 글 작성하기</a>
			    </c:if>
			</th>
		</tr>
	</tfoot>
</table>


<%-- footer.jsp --%>
<%@ include file="../template/footer.jsp"%>