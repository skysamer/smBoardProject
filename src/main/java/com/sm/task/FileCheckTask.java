package com.sm.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import com.sm.domain.BoardAttachVO;
import com.sm.mapper.BoardAttachMapper;
import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class FileCheckTask {
	
	@Autowired
	private BoardAttachMapper attachMapper;
	
	private String getFolderYesterday() {
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		
		Calendar cal=Calendar.getInstance();
		
		cal.add(Calendar.DATE, -1);
		
		String str=sdf.format(cal.getTime());
		
		return str.replace("-", File.separator);
	}
	
	@Scheduled(cron = "0 0 2 * * *")
	public void checkFiles() throws Exception{
		log.warn("File Check Task run.....................");
		log.warn(new Date());
		
		List<BoardAttachVO> fileList=attachMapper.getOldFiles();
		
		List<Path> fileListPath=fileList.stream()
				.map(vo -> Paths.get("C:\\upload", vo.getUploadPath(), vo.getUuid()+"_"+vo.getFileName()))
				.collect(Collectors.toList());
		
		fileList.stream().filter(vo -> vo.isFiletype()==true)
		.map(vo -> Paths.get("C:\\upload", vo.getUploadPath(), "s_"+vo.getUuid()+"_"+vo.getFileName()))
		.forEach(p -> fileListPath.add(p));
		
		log.warn("========================================");
		
		fileListPath.forEach(p -> log.warn(p));
		
		File targetDir=Paths.get("C:\\upload", getFolderYesterday()).toFile();
		
		File[] removeFiles=targetDir.listFiles(file -> fileListPath.contains(file.toPath())==false);
		
		log.warn("---------------------------------------");
		for(File file : removeFiles) {
			log.warn(file.getAbsolutePath());
			
			file.delete();
		}
	}

}
