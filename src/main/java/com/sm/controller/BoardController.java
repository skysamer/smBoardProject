package com.sm.controller;

import java.nio.file.Paths;
import java.nio.file.Path;
import java.nio.file.Files;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.sm.domain.BoardAttachVO;
import com.sm.domain.BoardVO;
import com.sm.domain.Criteria;
import com.sm.domain.PageDTO;
import com.sm.service.BoardService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
	
	@Autowired
	private BoardService service;
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("list: "+cri);
		model.addAttribute("list", service.getBoardList(cri));
		
		int total=service.getTotal(cri);
		
		log.info("total: "+total);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	@GetMapping("/register")
	public void register() {
		
	}
	
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		log.info("=======================");
		
		log.info("register: "+board);
		
		if(board.getAttachList()!=null) {
			board.getAttachList().forEach(attach -> log.info(attach));
		}
		
		log.info("=======================");
		
		service.register(board);
		rttr.addFlashAttribute("result", board.getBno());
		return "redirect:/board/list";
	}
	
	
	@GetMapping({"/get", "/modify"})
	public void board(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("/get or /modify");
		model.addAttribute("board", service.getBoard(bno));
	}
	
	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno){
		log.info("getAttachList: "+bno);
		log.info("======================");
		return new ResponseEntity<List<BoardAttachVO>>(service.getAttachList(bno), HttpStatus.OK);
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO board, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
		log.info("modify: "+board);
		
		if(service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getAmount());
		rttr.addAttribute("keyword", cri.getAmount());
		
		return "redirect:/board/list";
	}
	
	//메모리에 있는 파일 삭제
	private void deleteFiles(List<BoardAttachVO> attachList) {
		if(attachList==null || attachList.size()==0) {
			return;
		}
		
		attachList.forEach(attach -> {
			try {
				Path file=Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\"+attach.getUuid()+"_"+attach.getFileName());
				
				Files.deleteIfExists(file);
				
				log.info(Files.probeContentType(file));
				
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbNail=Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\s_"+attach.getUuid()+"_"+attach.getFileName());
					
					Files.delete(thumbNail);
				}
			}catch (Exception e) {
				log.error("delete file error: "+e.getMessage());
			}
		});
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
		log.info("remove: "+bno);
		
		List<BoardAttachVO> attachList=service.getAttachList(bno);
		
		if(service.remove(bno)) {
			deleteFiles(attachList);
			
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/board/list"+cri.getListLink();
	}
	
}
