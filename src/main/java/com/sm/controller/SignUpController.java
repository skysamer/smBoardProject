package com.sm.controller;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sm.domain.MemberVO;
import com.sm.service.SignUpService;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class SignUpController {
	
	@Autowired
	private SignUpService service;
	
	@RequestMapping("/signUp")
	public String signUp() {
		return "signUp";
	}
	
	// id 중복 체크
	@PostMapping(value = "/idCheck")
	@ResponseBody
	public int idCheck(@RequestParam("userid") String userid) {
		if(userid.isEmpty()) {
			int idCheck=1;
			return idCheck;
		}
		else {
			int idCheck=service.userIdCheck(userid);
			return idCheck;
		}
	}
	
	// 비밀번호 정규식 체크
	@PostMapping(value = "/pwCheck")
	@ResponseBody
	public int pwCheck(@RequestParam("userpw") String userpw) {
		int pwCheck;
		
		Pattern pattern=Pattern.compile("^.*(?=^.{8,15}$)(?=.*\\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$");
		Matcher matcher=pattern.matcher(userpw);
			
		if(matcher.find()) {
			pwCheck=0;
			return pwCheck;
		}
		else {
			pwCheck=1;
			return pwCheck;
		}
			
	}
	
	// 비밀번호 확인
	@PostMapping(value = "/pwConfirm")
	@ResponseBody
	public int pwConfirm(@RequestParam("userpwConfirm") String userpwConfirm, @RequestParam("userpw") String userpw) {
		int pwConfirm;
		
		if(userpwConfirm.equals(userpw) && !userpw.isEmpty()) {
			pwConfirm=0;
			return pwConfirm;
		}
		else {
			pwConfirm=1;
			return pwConfirm;
		}
	}
	
	// 이메일 정규식 체크
	@PostMapping(value = "/emailCheck")
	@ResponseBody
	public int emailCheck(@RequestParam("email") String email) {
		int emailCheck;
		
		Pattern pattern=Pattern.compile("^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$");
		Matcher matcher=pattern.matcher(email);
		
		if(matcher.find()) {
			emailCheck=0;
			return emailCheck;
		}
		else {
			emailCheck=1;
			return emailCheck;
		}
	}
	
	// 핸드폰 번호 정규식 체크
	@PostMapping(value = "/phoneCheck")
	@ResponseBody
	public int phoneCheck(@RequestParam("phone") String phone) {
		int phoneCheck;
		
		Pattern pattern=Pattern.compile("^\\d{3}-\\d{3,4}-\\d{4}$");
		Matcher matcher=pattern.matcher(phone);
		
		if(matcher.find()) {
			phoneCheck=0;
			return phoneCheck;
		}
		else {
			phoneCheck=1;
			return phoneCheck;
		}
	}
	
	@PostMapping(value = "/signUpForm", consumes = "application/json")
	@ResponseBody
	public int insertMember(@RequestBody MemberVO vo) {
		log.info(vo);
		int insertCheck=service.insert(vo);
		
		return insertCheck;
	}

}
