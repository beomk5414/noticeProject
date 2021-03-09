package com.rsupport.notice.command.captcha;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

public interface CaptchaCommand {
	
	public Map<String, Object> execute(HttpServletRequest request, Model model);

}
