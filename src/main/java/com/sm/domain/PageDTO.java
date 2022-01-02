package com.sm.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PageDTO {
	private int startPage;    // 시작 페이지 번호
	private int endPage;     // 끝 페이지 번호 
	private boolean prev;    // 이전 페이지
	private boolean next;   // 다음 페이지
	
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
