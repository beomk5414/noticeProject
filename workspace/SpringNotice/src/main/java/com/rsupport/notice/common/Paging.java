package com.rsupport.notice.common;

public class Paging {

	public static String getPaging(String path, int totalRecord, int recordPerPage, int page) {

		int totalPage; 			// 전체 페이지의 개수
		totalPage = totalRecord / recordPerPage; 
		if (totalRecord % recordPerPage != 0) {
			totalPage++;
		}
		totalPage = (totalPage > page ? totalPage : page);

		int pagePerBlock = 5;	// 한 블록당 페이지 5개
		int beginPage = 0;		// 한 블록에 표시되는 시작 페이지의 번호
		int endPage = 0;			// 한 블록에 표시되는 종료 페이지의 번호

		beginPage = ((page - 1) / pagePerBlock) * pagePerBlock + 1;
		endPage = beginPage + pagePerBlock - 1;
		endPage = (endPage > totalPage ? totalPage : endPage);

		StringBuffer sb = new StringBuffer();
		
		// 1) 이전 버튼
		if(beginPage <= pagePerBlock) {
			sb.append("<span class=\"disable\"><i class=\"fas fa-caret-left\"></i>&nbsp;</span>");
		} else {
			if(path.contains("?")) {
				sb.append("<a href=\"" + path + "&page=" + (beginPage - 1) + "\"><i class=\"fas fa-caret-left\"></i>&nbsp;</a>");
			}else {
				sb.append("<a href=\"" + path + "?page=" + (beginPage - 1) + "\"><i class=\"fas fa-caret-left\"></i>&nbsp;</a>");
			}
		}
		
		// 2) 페이지 번호
		for (int p = beginPage; p <= endPage; p++) {
			if (p == page) {
				sb.append("<span class=\"disable_p\">" + p + "&nbsp;</span>");
			}else {
				if(path.contains("?")) {
					sb.append("<a href=\"" + path + "&page=" + p + "\">" + p + "&nbsp;</a>");
				}
				else {
					sb.append("<a href=\"" + path + "?page=" + p + "\">" + p + "&nbsp;</a>");
				}
			}
		}
		
		// 3) 다음 버튼
		if(endPage >= totalPage) {
			sb.append("<i class=\"fas fa-caret-right\"></i>");
			// sb.append("<span class=\"disable\"><i class=\"fas fa-caret-right\"></i></span>");
		} else {
			if(path.contains("?")) {
				sb.append("<a href=\"" + path + "&page=" + (endPage + 1) + "\"><i class=\"fas fa-caret-right\"></i></a>");
			}else {
				sb.append("<a href=\"" + path + "?page=" + (endPage + 1) + "\"><i class=\"fas fa-caret-right\"></i></a>");
			}
		}
		
		return sb.toString();
	}
}