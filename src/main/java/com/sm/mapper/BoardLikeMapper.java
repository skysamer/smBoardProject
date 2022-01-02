package com.sm.mapper;

import org.apache.ibatis.annotations.Param;

public interface BoardLikeMapper {
	
	public void updateLike(Long bno);
		
	public void updateLikeCancel(Long bno);

	public void insertLike(@Param("bno") Long bno, @Param("userid") String userid);
		
	public void deleteLike(@Param("bno") Long bno, @Param("userid") String userid);
		
	public int likeCheck(@Param("bno") Long bno, @Param("userid") String userid);
		
	public void updateLikeCheckCancel(@Param("bno") Long bno, @Param("userid") String userid);
		
	public void memberPointPlus(String userid);
		
	public void memberPointDown(String userid);

}
