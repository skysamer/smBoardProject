package com.sm.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PageDTO {
	private int startPage;    // ���� ������ ��ȣ
	private int endPage;     // �� ������ ��ȣ 
	private boolean prev;    // ���� ������
	private boolean next;   // ���� ������
	
	private int total;   
	private Criteria cri;
	
	public PageDTO(Criteria cri, int total) {
		this.cri=cri;
		this.total=total;
		
		this.endPage=(int) (Math.ceil(cri.getPageNum() / 10.0)) * 10;
		
		this.startPage=this.endPage - 9;
		
		int realEnd=(int) (Math.ceil ((total * 1.0) / cri.getAmount()) );  // �� ������ ���� �������� �� ������ ��
		
		if(realEnd < this.endPage) {
			this.endPage=realEnd;
		}
		
		this.prev=this.startPage > 1;
		
		this.next=this.endPage < realEnd;
	}

}
