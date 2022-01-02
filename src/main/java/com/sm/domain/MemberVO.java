package com.sm.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	
	private String userid;
	private String userpw;
	private String userName;
	private boolean enabled;
	private int member_point;
	
	private Date regDate;
	private List<AuthVO> authList;

}
