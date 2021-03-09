package com.rsupport.notice.command.notice;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.rsupport.notice.mapper.NoticeMapper;

public class NoticeUpdateCommand implements NoticeCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
	
		NoticeMapper noticeMapper = sqlSession.getMapper(NoticeMapper.class);
		
		Map<String, Object> map = model.asMap();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) map.get("multipartRequest");

		String strNo = multipartRequest.getParameter("no");
		int no = 0;
		if (strNo != null && !strNo.isEmpty()) {
			no = Integer.parseInt(strNo);
		}	
		String title = multipartRequest.getParameter("title");
		String content = multipartRequest.getParameter("content");

		List<MultipartFile> files = multipartRequest.getFiles("filename");
		String[] removefiles = multipartRequest.getParameterValues("removeFilename");
		String[] originfiles = multipartRequest.getParameterValues("originFilename");
		
		String allFiles = "";
		
		String realPath = multipartRequest.getServletContext().getRealPath("resources/storage/notice");

		if(removefiles != null && removefiles.length > 0) {
			for (String filename : removefiles) {
				File file = new File(realPath, filename);
				if (file.exists()) {
					file.delete();
				}
			}
		}

		if(originfiles != null && originfiles.length > 0) {
			for (String filename : originfiles) {
				allFiles += filename + "&";
			}
		}
		
		if (files != null && !files.isEmpty()) {
			
			// 첨부를 하나씩 꺼내기
			for (MultipartFile file : files) {
				
				// 꺼낸 첨부가 있는지 검사
				if (file != null && !file.isEmpty()) {

					String originalFilename = file.getOriginalFilename();

					String extension = originalFilename.substring(originalFilename.lastIndexOf(".") + 1);
					String filename = originalFilename.substring(0, originalFilename.lastIndexOf("."));

					String uploadFilename = filename + "_" + System.currentTimeMillis() + "." + extension;

					File dir = new File(realPath);
					if (!dir.exists()) {
						dir.mkdirs();
					}

					File uploadFile = new File(realPath, uploadFilename);

					try {
						file.transferTo(uploadFile);

					} catch (Exception e) {
						e.printStackTrace();
					}
					
					allFiles += uploadFilename + "&";

				}  // if(file != null) {
				
			} // for (MultipartFile file : files) {
			noticeMapper.update(title, content, allFiles, no);
			
		} else { // 첨부가 없는 데이터를 테이블에 저장합니다.
			noticeMapper.update(title, content, allFiles, no);
		}
		
	}

}
