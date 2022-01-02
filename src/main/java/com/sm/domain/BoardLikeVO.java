package com.sm.domain;

import java.util.Date;
import lombok.Data;

@Data
public class BoardLikeVO {
	
	private int likeid;
	private Long bno;
	private String userid;
	private int likecheck;
	private Date likedate;

}
