package com.sm.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	
	private String userid;
	private String userpw;
	private String username;
	private boolean enabled;
	private int member_point;
	private int member_point_hate;
	private String phone;
	private String email;
	private String address;
	private String address2;
	private String sex;
	
	private Date regDate;
	private List<AuthVO> authList;

}
