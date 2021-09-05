package com.sm.mapper;

import java.util.List;

import com.sm.domain.BoardVO;

public interface BoardMapper {
	
	public List<BoardVO> getBoardList();
	
	public void insert(BoardVO board);
	
	public void insertSelectKey(BoardVO board);
	
	public BoardVO getBoard(Long bno);     
	
	public int delete(Long bno);
	
	public int update(BoardVO board);

}
