package com.sm.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import org.apache.tika.Tika;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import com.sm.domain.BoardAttachVO;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@AllArgsConstructor
@Log4j
public class UploadController {
	
	private String getFolder() { /* 년/월/일  폴더 경로 생성 */
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		
		Date date=new Date();
		
		String str=sdf.format(date);
		
		str=str.trim();
		
		return str.replace("-", File.separator);
	}
	
	private boolean checkImageType(File file) {
		try {
			String mimeType = new Tika().detect(file);
			log.info(mimeType);
			if(mimeType.contains("image")) {
				return true;
			}
			else {
				return false;
			}
		}catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value="/uploadAjaxAction", produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> uploadAjaxPost(MultipartFile[] uploadFile) {/* 업로드 파일 폴더 저장 및 파일 정보 db저장 */
		
		List<BoardAttachVO> list=new ArrayList<BoardAttachVO>();
		
		String uploadFolder="C:\\upload";
		
		String uploadFolderPath=getFolder();  /* 년/월/일  폴더 경로 생성 */
		
		// make folder
		File uploadPath=new File(uploadFolder, uploadFolderPath);
		
		if(uploadPath.exists()==false) {
			uploadPath.mkdirs();
		}
		
		//make yyyy/mm/dd folder
		for(MultipartFile multipartFile : uploadFile) {
			
			BoardAttachVO vo=new BoardAttachVO();
			
			String uploadFileName=multipartFile.getOriginalFilename();
			
			uploadFileName=uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			vo.setFileName(uploadFileName);
			
			log.info("only File Name");
			
			UUID uuid=UUID.randomUUID();
			
			uploadFileName=uuid.toString() + "_" + uploadFileName; 
			
			try {
				File saveFile=new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);
				
				log.info(saveFile);
				
				vo.setUuid(uuid.toString());
				vo.setUploadPath(uploadFolderPath);   
				
				// check image type file
				if(checkImageType(saveFile)) {
					log.info("======test=======");
					vo.setFiletype(true);
					
					FileOutputStream thumbnail=new FileOutputStream(new File(uploadPath, "s_"+uploadFileName));
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
					
					
					thumbnail.close();
				}
				
				list.add(vo);
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		return new ResponseEntity<List<BoardAttachVO>>(list, HttpStatus.OK);
	}
	
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){/*파일 섬네일 보여주기 */
		log.info("fileName: "+fileName);
		
		File file=new File("C:\\upload\\"+fileName);
		
		log.info("file: "+file);
		
		ResponseEntity<byte[]> result=null;
		
		try {
			HttpHeaders header=new HttpHeaders();
			
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result=new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		}catch (IOException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(String fileName){
		log.info("fileName: "+fileName);
		Resource resource=new FileSystemResource("C:\\upload\\"+fileName);
		log.info(resource);
		
		if(resource.exists()==false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		String resourceName=resource.getFilename();
		log.info("resourceName: "+resourceName);
		
		String resourceOriginName=resourceName.substring(resourceName.indexOf("_")+1);
		log.info("resourceOriginName: "+resourceOriginName);
		
		HttpHeaders headers=new HttpHeaders();
		
		try {
			String downloadName=new String(resourceOriginName.getBytes("UTF-8"), "ISO-8859-1");
			
			log.info("downloadName: "+downloadName);
			
			headers.add("Content-Disposition", "attachment; filename="+downloadName);
		}catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type){
		log.info("deleteFile: "+fileName);
		
		File file;
		
		try {
			file=new File("C:\\upload\\"+URLDecoder.decode(fileName, "UTF-8"));
			
			file.delete();
			
			if(type.equals("image")) {
				String largeFileName=file.getAbsolutePath().replace("s_", "");
				
				log.info("largeFileName: "+largeFileName);
				
				file=new File(largeFileName);
				
				file.delete();
			}
		}catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<String>(HttpStatus.NOT_FOUND);
		}
		
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}

}
