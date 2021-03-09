package com.rsupport.notice.command.notice;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

public interface NoticeCommand {
	
	public void execute(SqlSession sqlSession, Model model);

}
