package com.sm.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class BoardAttachVO {
	private String uuid;
	private String uploadPath;
	private String fileName;
	private boolean filetype;
	
	private Long bno;

}
