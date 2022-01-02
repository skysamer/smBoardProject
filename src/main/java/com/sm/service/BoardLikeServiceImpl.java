package com.sm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.sm.mapper.BoardLikeMapper;

@Service
public class BoardLikeServiceImpl implements BoardLikeService{
	
	@Autowired
	private BoardLikeMapper mapper;

	@Override
	public void updateLike(Long bno) {
		mapper.updateLike(bno);
	}

	@Override
	public void updateLikeCancel(Long bno) {
		mapper.updateLikeCancel(bno);
	}

	@Override
	public void insertLike(Long bno, String userid) {
		mapper.insertLike(bno, userid);
	}

	@Override
	public void deleteLike(Long bno, String userid) {
		mapper.deleteLike(bno, userid);
	}

	@Override
	public int likeCheck(Long bno, String userid) {
		return mapper.likeCheck(bno, userid);
	}

	@Override
	public void updateLikeCheckCancel(Long bno, String userid) {
		mapper.updateLikeCheckCancel(bno, userid);
	}

	@Override
	public void memberPointPlus(String userid) {
		mapper.memberPointPlus(userid);
	}

	@Override
	public void memberPointDown(String userid) {
		mapper.memberPointDown(userid);
	}

}
