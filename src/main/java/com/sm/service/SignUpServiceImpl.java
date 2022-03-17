package com.sm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sm.domain.MemberVO;
import com.sm.mapper.MemberMapper;
import com.sm.security.CustomPasswordEncoder;

@Service
public class SignUpServiceImpl implements SignUpService{
	
	@Autowired
	private MemberMapper mapper;
	
	@Autowired
	private CustomPasswordEncoder encoder;

	@Override
	public int userIdCheck(String userid) {
		return mapper.userIdCheck(userid);
	}

	@Override
	public int insert(MemberVO vo) {
		String encodePassword=encoder.encode(vo.getUserpw());
		vo.setUserpw(encodePassword);
		
		mapper.insertMember(vo);
		return mapper.insertAuth(vo);
	}

}
