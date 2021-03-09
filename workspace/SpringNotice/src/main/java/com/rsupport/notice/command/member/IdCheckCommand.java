package com.rsupport.notice.command.member;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.rsupport.notice.mapper.MemberMapper;

public class IdCheckCommand implements SignUpCheckCommand {

	@Override
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		
		String id = request.getParameter("id");
		
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("idCheckResult", memberMapper.selectIdCheck(id));
		
		return resultMap;
	}

}
