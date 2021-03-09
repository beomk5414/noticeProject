package com.rsupport.notice.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.rsupport.notice.command.captcha.CaptchaCommand;
import com.rsupport.notice.command.captcha.GetImageCaptchaCommand;
import com.rsupport.notice.command.captcha.InputKeyCheckCommand;
import com.rsupport.notice.command.notice.NoticeCommand;
import com.rsupport.notice.command.notice.NoticeDeleteCommand;
import com.rsupport.notice.command.notice.NoticeDownloadCommand;
import com.rsupport.notice.command.notice.NoticeInsertCommand;
import com.rsupport.notice.command.notice.NoticeListCommand;
import com.rsupport.notice.command.notice.NoticeUpdateCommand;
import com.rsupport.notice.command.notice.NoticeViewCommand;
import com.rsupport.notice.dto.NoticeDto;

@Controller
public class NoticeController {
	
	@Autowired
	private SqlSession sqlSession;
	private NoticeCommand command;
	private CaptchaCommand captchaCommand;
	

	@RequestMapping(value = "noticeListPage.do", method = RequestMethod.GET)
	public String noticeListPage(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		command = new NoticeListCommand();
		command.execute(sqlSession, model);
		return "notice/noticeListPage";
	}

	@RequestMapping(value = "noticeViewPage.do", method = RequestMethod.GET)
	public String noticeViewPage(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		command = new NoticeViewCommand();
		command.execute(sqlSession, model);
		return "notice/noticeViewPage";
	}

	@RequestMapping(value = "noticeInsertPage.do", method = RequestMethod.GET)
	public String noticeInsertPage() {
		return "notice/noticeInsertPage";
	}

	@RequestMapping(value = "getImageCaptcha.do", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> getImageCaptcha(HttpServletRequest request, Model model) {
		captchaCommand = new GetImageCaptchaCommand();
		return captchaCommand.execute(request, model);
	}

	@RequestMapping(value = "captchaKeyCheck.do", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> captchaKeyCheck(HttpServletRequest request, Model model) {
		captchaCommand = new InputKeyCheckCommand();
		return captchaCommand.execute(request, model);
	}
	
	
	@RequestMapping(value = "noticeInsert.do", method = RequestMethod.POST)
	public String noticeInsert(MultipartHttpServletRequest multipartRequest, Model model) {
		model.addAttribute("multipartRequest", multipartRequest);
		command = new NoticeInsertCommand();
		command.execute(sqlSession, model);
		return "redirect:noticeListPage.do";
	}

	@RequestMapping(value = "noticeUpdatePage.do", method = RequestMethod.POST)
	public String noticeUpdatePage(@ModelAttribute("noticeDto") NoticeDto noticeDto, @ModelAttribute("page") String page, Model model) {
		return "notice/noticeUpdatePage";
	}
	
	@RequestMapping(value = "noticeUpdate.do", method = RequestMethod.POST)
	public String noticeUpdate(MultipartHttpServletRequest multipartRequest, Model model) {
		model.addAttribute("multipartRequest", multipartRequest);
		command = new NoticeUpdateCommand();
		command.execute(sqlSession, model);
		String page = multipartRequest.getParameter("page");
		String no = multipartRequest.getParameter("no");
		return "redirect:noticeViewPage.do?no=" + no + "&page=" + page;
	}

	@RequestMapping(value = "noticeDelete.do", method = RequestMethod.POST)
	public String noticeDelete(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		command = new NoticeDeleteCommand();
		command.execute(sqlSession, model);
		return "redirect:noticeListPage.do";
	}
	
	@RequestMapping(value = "download.do", method=RequestMethod.GET)
	public void download( HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("request", request);
		model.addAttribute("response", response);
		command = new NoticeDownloadCommand();
		command.execute(sqlSession, model);
	}
	

}
