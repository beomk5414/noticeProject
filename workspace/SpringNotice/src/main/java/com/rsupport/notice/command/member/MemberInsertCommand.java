package com.rsupport.notice.command.member;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.rsupport.notice.common.Sha256;
import com.rsupport.notice.dto.MemberDto;
import com.rsupport.notice.mapper.MemberMapper;

public class MemberInsertCommand implements MemberCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		
		String id = request.getParameter("id");
		String pw = Sha256.sha256(request.getParameter("pw"));
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String gender = request.getParameter("gender");
		
		MemberDto memberDto = new MemberDto();
		memberDto.setName(name);
		memberDto.setId(id);
		memberDto.setPw(pw);
		memberDto.setEmail(email);
		memberDto.setGender(gender);

		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		int result = memberMapper.insertMember(memberDto);
		model.addAttribute("signUpResult", result);
	}
}
