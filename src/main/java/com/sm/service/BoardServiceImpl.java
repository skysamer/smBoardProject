package com.sm.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.sm.domain.BoardVO;
import com.sm.domain.Criteria;
import com.sm.mapper.BoardMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService{
	
	@Autowired
	private BoardMapper mapper;

	@Override
	public void register(BoardVO board) {
		log.info("register: "+board);
		mapper.insertSelectKey(board);
	}

	@Override
	public BoardVO getBoard(Long bno) {
		log.info("getBoard......");
		return mapper.getBoard(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		log.info("modify: "+board);
		return mapper.update(board)==1;
	}

	@Override
	public boolean remove(Long bno) {
		log.info("remove: "+bno);
		return mapper.delete(bno)==1;
	}

	@Override
	public List<BoardVO> getBoardList(Criteria cri) {
		log.info("getBoardList With Criteria: "+cri);
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}

}
