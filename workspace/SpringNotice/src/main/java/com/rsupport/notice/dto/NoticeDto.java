package com.rsupport.notice.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class NoticeDto {
	
	private int no;
	private String writer;
	private String title;
	private String content;
	private String filename;
	private Date regDate;
	private Date lastEdited;

}
