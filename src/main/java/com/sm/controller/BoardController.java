package com.sm.controller;

import java.nio.file.Paths;
import java.security.Principal;
import java.nio.file.Path;
import java.nio.file.Files;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.sm.domain.BoardAttachVO;
import com.sm.domain.BoardVO;
import com.sm.domain.Criteria;
import com.sm.domain.PageDTO;
import com.sm.service.BoardHateService;
import com.sm.service.BoardLikeService;
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
	
	@Autowired
	private BoardLikeService likeService;
	
	@Autowired
	private BoardHateService hateService;
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("list: "+cri);
		model.addAttribute("list", service.getBoardList(cri));
		
		int total=service.getTotal(cri);
		
		log.info("total: "+total);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public void register() {
		
	}
	
	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()")
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
	
	@PreAuthorize("principal.username == #board.writer")
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
	
	//하드디스크에 있는 파일 삭제
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
	
	
	// 게시글 삭제
	@PreAuthorize("principal.username == #writer")
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri, String writer) {
		log.info("remove: "+bno);
		
		List<BoardAttachVO> attachList=service.getAttachList(bno);
		
		if(service.remove(bno)) {
			deleteFiles(attachList);
			
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/board/list"+cri.getListLink();
	}
	
	// 게시글 좋아요
	@ResponseBody
	@PostMapping(value = "/updateLike")
	public int updateLike(@RequestParam("bno") Long bno, Principal principal) {
		log.info(principal);
		
		if(principal!=null) {
			String userid=principal.getName();
			
			int likeCheck = likeService.likeCheck(bno, userid);
				
			if(likeCheck == 0) {
				likeService.insertLike(bno, userid); //like테이블 삽입
				likeService.updateLike(bno);	//게시판테이블 +1
				likeService.memberPointPlus(userid); //회원포인트 +
			}
			else if(likeCheck == 1) {
				likeService.updateLikeCheckCancel(bno, userid); //like테이블 구분자0
				likeService.updateLikeCancel(bno); //게시판테이블 - 1
				likeService.deleteLike(bno, userid); //like테이블 삭제
				likeService.memberPointDown(userid); //회원포인트 - 
			}
			log.info("likeCheck:"+likeCheck);
			return likeCheck;
		}
		else {
			int likeCheck=9999;
			return likeCheck;
		}
		
	}
	
	// 게시글 싫어요
	@ResponseBody
	@PostMapping(value = "/updateHate")
	public int updateHate(@RequestParam("bno") Long bno, Principal principal) {
		if(principal!=null) {
			String userid=principal.getName();
			
			int hateCheck=hateService.hateCheck(bno, userid);
			
			if(hateCheck==0) {
				hateService.insertHate(bno, userid);
				hateService.updateHate(bno);
				hateService.hatepointPlus(userid);
			}
			else if(hateCheck==1) {
				hateService.updateHateCheckCancel(bno, userid);
				hateService.updateHateCancel(bno);
				hateService.deleteHate(bno, userid);
				hateService.hatePointMinus(userid);
			}
			
			return hateCheck;
		}
		else {
			int hateCheck=9999;
			return hateCheck;
		}
	}
	
}
