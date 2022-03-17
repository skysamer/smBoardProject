package com.sm.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import com.sm.domain.CustomUser;
import com.sm.domain.MemberVO;
import com.sm.mapper.MemberMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailService implements UserDetailsService{
	
	@Setter(onMethod_ = @Autowired)
	private MemberMapper memberMapper;
	
	@Override
	public UserDetails loadUserByUsername(String userid) throws UsernameNotFoundException {
		
		MemberVO vo=memberMapper.read(userid);
		
		log.warn("queried by member mapper: "+vo);
		
		return vo == null ? null : new CustomUser(vo);
	}
	
}
