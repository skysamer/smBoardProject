package com.sm.controller;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.sm.domain.BoardVO;
import com.sm.domain.Criteria;
import com.sm.mapper.BoardMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTest {
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Test
	public void testGetList() {
		mapper.getBoardList().forEach(board -> log.info(board));
	}
	
	@Test
	public void testPaging() {
		Criteria cri=new Criteria();
		cri.setPageNum(3);
		cri.setAmount(10);
		
		List<BoardVO> list=mapper.getListWithPaging(cri);
		
		list.forEach(board -> log.info(board.getBno()));
	}

}
