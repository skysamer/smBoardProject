package com.sm.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {
	private Long bno;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	private Long views;
	private Long recommendations;
	private Long not_recommendations;
	
	private int replyCnt;
	
	private List<BoardAttachVO> attachList;

}
