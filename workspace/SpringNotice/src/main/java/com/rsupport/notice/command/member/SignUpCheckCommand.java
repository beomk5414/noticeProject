package com.rsupport.notice.command.member;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

public interface SignUpCheckCommand {
	
	public Map<String, Object> execute(SqlSession sqlSession, Model model);

}
