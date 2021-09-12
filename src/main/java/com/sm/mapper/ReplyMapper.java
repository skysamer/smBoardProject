package com.sm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.sm.domain.Criteria;
import com.sm.domain.ReplyVO;

public interface ReplyMapper {
	
	public int insert(ReplyVO vo);
	
	public ReplyVO read(Long rno);  // Ư�� ��� �б�
	
	public int delete(Long rno);
	
	public int update(ReplyVO reply);
	
	public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri, @Param("bno")Long bno);

}
