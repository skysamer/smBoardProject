package com.sm.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	private int pageNum;  // 페이지 번호
	private int amount;   // 페이지 당 데이터 수
	
	private String type;
	private String keyword;
	
	public Criteria() {  
		this(1, 20);
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum=pageNum;
		this.amount=amount;
	}
	
	public String[] getTypeArr() {
		return type == null ? new String[] {} : type.split("");
	}
	
}
