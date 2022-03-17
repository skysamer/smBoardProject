package com.sm.service;

import com.sm.domain.MemberVO;

public interface SignUpService {
	
	public int userIdCheck(String userid);
	
	public int insert(MemberVO vo);

}
