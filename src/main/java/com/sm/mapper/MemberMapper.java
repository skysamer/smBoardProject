package com.sm.mapper;

import com.sm.domain.MemberVO;

public interface MemberMapper {
	
	public MemberVO read(String userid);
	
	public int insertMember(MemberVO vo);
	
	public int insertAuth(MemberVO vo);
	
	public int userIdCheck(String userid);

}
