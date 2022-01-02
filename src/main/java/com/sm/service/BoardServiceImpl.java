package com.sm.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sm.domain.BoardAttachVO;
import com.sm.domain.BoardVO;
import com.sm.domain.Criteria;
import com.sm.mapper.BoardAttachMapper;
import com.sm.mapper.BoardMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService{
	
	@Autowired
	private BoardMapper mapper;
	
	@Autowired
	private BoardAttachMapper attachMapper;

	@Transactional
	@Override
	public void register(BoardVO board) {
		log.info("register: "+board);
		
		mapper.insertSelectKey(board);
		
		if(board.getAttachList()==null || board.getAttachList().size()<=0) {
			return;
		}
		
		board.getAttachList().forEach(attach ->{
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
		});
	}
	
	@Transactional
	@Override
	public BoardVO getBoard(Long bno) {
		log.info("getBoard......");
		
		mapper.boardViews(bno);
		return mapper.getBoard(bno);
	}

	@Transactional
	@Override
	public boolean modify(BoardVO board) {
		log.info("modify: "+board);
		
		attachMapper.deleteAll(board.getBno());
		
		boolean modifyResult=mapper.update(board)==1;
		
		if(modifyResult && board.getAttachList() !=null && board.getAttachList().size()>0) {
			board.getAttachList().forEach(attach ->{
				attach.setBno(board.getBno());
				attachMapper.insert(attach);
			});
		}
		
		return modifyResult;
	}

	@Transactional
	@Override
	public boolean remove(Long bno) {
		log.info("remove: "+bno);
		
		attachMapper.deleteAll(bno);
		
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

	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {
		log.info("get Attach list by bno :"+bno);
		
		return attachMapper.findByBno(bno);
	}

}
