package com.sm.service;

public interface BoardHateService {
	
	public void updateHate(Long bno);
	
	public void updateHateCancel(Long bno);
	
	public void insertHate(Long bno, String userid);
	
	public void deleteHate(Long bno, String userid);
	
	public int hateCheck(Long bno, String userid);
	
	public void updateHateCheckCancel(Long bno, String userid);
	
	public void hatepointPlus(String userid);
	
	public void hatePointMinus(String userid);

}
