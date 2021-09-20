package com.sm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sm.domain.Criteria;
import com.sm.domain.ReplyPageDTO;
import com.sm.domain.ReplyVO;
import com.sm.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService{
	
	@Autowired
	private ReplyMapper mapper;

	@Override
	public int register(ReplyVO vo) {
		log.info("register..."+vo);
		
		return mapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long rno) {
		log.info("get..."+rno);
		
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) {
		log.info("modify..."+vo);
		
		return mapper.update(vo);
	}

	@Override
	public int remove(Long rno) {
		log.info("remove..."+rno);
		
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(Long bno, Criteria cri) {
		log.info("getList..."+bno);
		
		return mapper.getListWithPaging(cri, bno);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {
		
		return new ReplyPageDTO(
				mapper.getCountByBno(bno), 
				mapper.getListWithPaging(cri, bno));
	}

}
