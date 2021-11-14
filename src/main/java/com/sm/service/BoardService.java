package com.sm.service;

import java.util.List;

import com.sm.domain.BoardAttachVO;
import com.sm.domain.BoardVO;
import com.sm.domain.Criteria;

public interface BoardService {
	
	public void register(BoardVO board);
	
	public BoardVO getBoard(Long bno);
	
	public boolean modify(BoardVO board);
	
	public boolean remove(Long bno);
	
	public List<BoardVO> getBoardList(Criteria cri);
	
	public int getTotal(Criteria cri);
	
	public List<BoardAttachVO> getAttachList(Long bno);
	
}
