package com.rsupport.notice.command.member;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.rsupport.notice.common.Sha256;
import com.rsupport.notice.dto.MemberDto;
import com.rsupport.notice.mapper.MemberMapper;

public class MemberLoginCommand implements MemberCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		
		String id = request.getParameter("id");
		String pw = Sha256.sha256(request.getParameter("pw"));
		
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		MemberDto memberDto = memberMapper.loginMember(id,pw);
		if(memberDto != null) {
			HttpSession session = request.getSession();
			session.setAttribute("loginDto", memberDto);

		} else {
			HttpSession session = request.getSession();
			session.invalidate();
		}
	}
}
