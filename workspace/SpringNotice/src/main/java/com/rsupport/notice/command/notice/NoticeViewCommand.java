package com.rsupport.notice.command.notice;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.rsupport.notice.mapper.NoticeMapper;

public class NoticeViewCommand implements NoticeCommand {

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
		String strNo = request.getParameter("no");
		int no = 0;
		if (strNo != null && !strNo.isEmpty()) {
			no = Integer.parseInt(strNo);
		}
		
		model.addAttribute("noticeDto", noticeMapper.view(no));
		model.addAttribute("page", page);

	}

}
