package com.sm.service;

public interface BoardLikeService {
	
	public void updateLike(Long bno);
	
	public void updateLikeCancel(Long bno);

	public void insertLike(Long bno,String userid);
	
	public void deleteLike(Long bno,String userid);
	
	public int likeCheck(Long bno,String userid);
	
	public void updateLikeCheckCancel(Long bno,String userid);
	
	public void memberPointPlus(String userid);
	
	public void memberPointDown(String userid);

}
