package com.sm.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PageDTO {
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	
	private int total;
	private Criteria cri;
	
	public PageDTO(Criteria cri, int total) {
		this.cri=cri;
		this.total=total;
		
		this.endPage=(int) (Math.ceil(cri.getPageNum() / 10.0)) * 10;
		
		this.startPage=this.endPage - 9;
		
		int realEnd=(int) (Math.ceil ((total * 1.0) / cri.getAmount()) );  // 총 데이터 수를 기준으로 한 페이지 수
		
		if(realEnd < this.endPage) {
			this.endPage=realEnd;
		}
		
		this.prev=this.startPage > 1;
		
		this.next=this.endPage < realEnd;
	}

}
