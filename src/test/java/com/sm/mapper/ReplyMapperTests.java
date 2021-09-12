package com.sm.mapper;

import java.util.List;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import com.sm.domain.Criteria;
import com.sm.domain.ReplyVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {
	
	private Long[] bnoArr= {1703966L, 1703967L, 1703968L, 1703969L, 1703970L};
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	/*
	 * @Test public void testCreate() { IntStream.rangeClosed(1, 10).forEach(i -> {
	 * ReplyVO vo= new ReplyVO();
	 * 
	 * vo.setBno(bnoArr[i%5]); vo.setReply("´ñ±Û Å×½ºÆ®"+i); vo.setReplier("replier"+i);
	 * 
	 * mapper.insert(vo); }); }
	 */
	
	@Test
	public void testRead() {
		Long targetRno=5L;
		
		ReplyVO vo=mapper.read(targetRno);
		
		log.info(vo);
	}
	
	/*
	 * @Test public void testDelete() { Long targetRno=1L;
	 * 
	 * mapper.delete(targetRno); }
	 */
	
	@Test
	public void testUpdate() {
		Long targetRno=10L;
		
		ReplyVO vo=mapper.read(targetRno);
		
		vo.setReply("Update Reply ");
		
		int count=mapper.update(vo);
		
		log.info("UPDATE COUNT: "+count);
	}
	
	@Test
	public void testList() {
		Criteria cri=new Criteria();
		
		List<ReplyVO> replies=mapper.getListWithPaging(cri, bnoArr[0]);
		
		replies.forEach(reply -> log.info(reply));
	}
	
	@Test
	public void testMapper() {
		log.info(mapper);
	}

}
