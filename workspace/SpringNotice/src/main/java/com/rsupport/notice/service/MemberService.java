package com.rsupport.notice.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rsupport.notice.dto.MemberDto;
import com.rsupport.notice.mapper.MemberMapper;

@Service
public class MemberService {
	
	@Autowired
	private MemberMapper memberMapper;
	
	public List<MemberDto> selectMemberList(){
		return memberMapper.selectMemberList();
	}

}
