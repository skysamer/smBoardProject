package com.sm.mapper;

import org.apache.ibatis.annotations.Param;

public interface BoardHateMapper {
	
	public void updateHate(Long bno);
	
	public void updateHateCancel(Long bno);
	
	public void insertHate(@Param("bno") Long bno, @Param("userid") String userid);
	
	public void deleteHate(@Param("bno") Long bno, @Param("userid") String userid);
	
	public int hateCheck(@Param("bno") Long bno, @Param("userid") String userid);
	
	public void updateHateCheckCancel(@Param("bno") Long bno, @Param("userid") String userid);
	
	public void hatePointPlus(String userid);
	
	public void hatePointMinus(String userid);

}
