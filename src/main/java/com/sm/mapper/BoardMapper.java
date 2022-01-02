package com.sm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.sm.domain.BoardVO;
import com.sm.domain.Criteria;

public interface BoardMapper {
	
	public List<BoardVO> getBoardList();
	
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	public void insert(BoardVO board);
	
	public void insertSelectKey(BoardVO board);
	
	public BoardVO getBoard(Long bno);     
	
	public int delete(Long bno);
	
	public int update(BoardVO board);
	
	public int getTotalCount(Criteria cri);
	
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
	
	public void boardViews(Long bno);
	

}
