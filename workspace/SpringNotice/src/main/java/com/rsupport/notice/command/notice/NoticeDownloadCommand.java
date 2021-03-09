package com.rsupport.notice.command.notice;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.http.MediaType;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;

public class NoticeDownloadCommand implements NoticeCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		HttpServletResponse response = (HttpServletResponse) map.get("response");

		String filename = request.getParameter("filename");
		String realPath = request.getServletContext().getRealPath("resources/storage/notice");

		String extension = filename.substring(filename.lastIndexOf(".")); 
		String originalFilename = filename.substring(0, filename.lastIndexOf("_"));

		String downloadFilename = originalFilename + extension;
		File file = new File(realPath, filename);

		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;

		try {

			response.setHeader("Content-Type", MediaType.APPLICATION_OCTET_STREAM_VALUE);
			response.setHeader("Content-Disposition", "attachment; filename=" + new String(URLEncoder.encode(downloadFilename, "utf-8")));
			response.setHeader("Content-Length", file.length() + "");

			bis = new BufferedInputStream(new FileInputStream(file));
			bos = new BufferedOutputStream(response.getOutputStream());

			FileCopyUtils.copy(bis, bos);

			bos.flush();

		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (bos != null) {
					bos.close();
				}
				if (bis != null) {
					bis.close();
				}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

	}
}
