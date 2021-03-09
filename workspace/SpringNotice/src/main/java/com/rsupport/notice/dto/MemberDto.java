package com.rsupport.notice.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberDto {
	
	private int no;
	private String id;
	private String pw;
	private String name;
	private String gender;
	private String email;
	private String role;
	private Date regDate;

}
