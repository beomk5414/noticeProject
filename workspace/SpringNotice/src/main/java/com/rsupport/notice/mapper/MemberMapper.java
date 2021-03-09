package com.rsupport.notice.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.rsupport.notice.dto.MemberDto;

@Mapper
public interface MemberMapper {
	
	int selectIdCheck(String id);
	List<MemberDto> selectMemberList();
	int insertMember(MemberDto memberDto);
	MemberDto loginMember(String id, String pw);

}
