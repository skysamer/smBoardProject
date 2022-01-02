package com.sm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sm.mapper.BoardHateMapper;

@Service
public class BoardHateServiceImpl implements BoardHateService{
	
	@Autowired
	private BoardHateMapper mapper;

	@Override
	public void updateHate(Long bno) {
		mapper.updateHate(bno);
	}

	@Override
	public void updateHateCancel(Long bno) {
		mapper.updateHateCancel(bno);
	}

	@Override
	public void insertHate(Long bno, String userid) {
		mapper.insertHate(bno, userid);
	}

	@Override
	public void deleteHate(Long bno, String userid) {
		mapper.deleteHate(bno, userid);
	}

	@Override
	public int hateCheck(Long bno, String userid) {
		return mapper.hateCheck(bno, userid);
	}

	@Override
	public void updateHateCheckCancel(Long bno, String userid) {
		mapper.updateHateCheckCancel(bno, userid);
	}

	@Override
	public void hatepointPlus(String userid) {
		mapper.hatePointPlus(userid);
	}

	@Override
	public void hatePointMinus(String userid) {
		mapper.hatePointMinus(userid);
	}

}
