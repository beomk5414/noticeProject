package com.rsupport.notice.command.notice;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.rsupport.notice.common.Paging;
import com.rsupport.notice.dto.NoticeDto;
import com.rsupport.notice.mapper.NoticeMapper;

public class NoticeListCommand implements NoticeCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		NoticeMapper noticeMapper = sqlSession.getMapper(NoticeMapper.class);

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		String strPage = request.getParameter("page");
		int page = 1;
		if (strPage != null && !strPage.isEmpty()) {
			page = Integer.parseInt(strPage);
		}

		int totalRecord = noticeMapper.totalRecord();

		int recordPerPage = 5; // 1 페이지 당 게시물 5개 
		int beginRecord = (page - 1) * recordPerPage + 1;
		int endRecord = beginRecord + recordPerPage - 1;
		if (endRecord > totalRecord) {
			endRecord = totalRecord;
		}

		List<NoticeDto> list = noticeMapper.list(beginRecord, endRecord);
		String paging = Paging.getPaging("noticeListPage.do", totalRecord, recordPerPage, page);

		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		model.addAttribute("totalRecord", totalRecord);
		model.addAttribute("page", page);
		model.addAttribute("recordPerPage", recordPerPage);

	}

}
