package com.his.hisSystem.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.springframework.util.ObjectUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public class FileUtils {

	public List<FileVO> parseFileInfo(int seq, HttpServletRequest request, 
			MultipartHttpServletRequest mhsr) throws IOException {
		if(ObjectUtils.isEmpty(mhsr)) {
			return null;
		}
		
		List<FileVO> fileList = new ArrayList<FileVO>();
		
		//서버의 절대 경로 얻기
		//String root_path = request.getSession().getServletContext().getRealPath("/");
		String root_path = "C:";
		String attach_path = "/fileUpload/";
				
		//위 경로의 폴더가 없으면 폴더 생성
		File file = new File(root_path + attach_path);
		if(file.exists() == false) {
			file.mkdir();
		}
		
		//파일 이름들을 iterator로 담음
		Iterator<String> iterator = mhsr.getFileNames();
		
		UUID uuid = UUID.randomUUID();
		
		while(iterator.hasNext()) {
			//파일명으로 파일 리스트 꺼내오기
			List<MultipartFile> list = mhsr.getFiles(iterator.next());
			
			//파일 리스트 개수 만큼 리턴할 파일 리스트에 담아주고 생성
			for(MultipartFile mf : list) {
				FileVO boardFile = new FileVO();
				boardFile.setFileNo(seq);
				boardFile.setFileSize(mf.getSize());
				boardFile.setOrgFileName(mf.getOriginalFilename());
				boardFile.setSaveFileName(uuid + "." + FilenameUtils.getExtension(mf.getOriginalFilename()));
				boardFile.setFilePath(root_path + attach_path);
				fileList.add(boardFile);
				
				//file = new File(root_path + attach_path + mf.getOriginalFilename());
				file = new File(root_path + attach_path + uuid + "." + FilenameUtils.getExtension(mf.getOriginalFilename()) );
				
				mf.transferTo(file);
			}
		}
		return fileList;
	}
	
	public void download(HttpServletResponse response,String fileNm) throws Exception {
        try {
        	String path = "C:/fileUpload/" + fileNm; // 경로에 접근할 때 역슬래시('\') 사용
        	        	
        	File file = new File(path);
        	response.setHeader("Content-Disposition", "attachment;filename=" + file.getName()); // 다운로드 되거나 로컬에 저장되는 용도로 쓰이는지를 알려주는 헤더
        	
        	FileInputStream fileInputStream = new FileInputStream(path); // 파일 읽어오기 
        	OutputStream out = response.getOutputStream();
        	
        	int read = 0;
                byte[] buffer = new byte[1024];
                while ((read = fileInputStream.read(buffer)) != -1) { // 1024바이트씩 계속 읽으면서 outputStream에 저장, -1이 나오면 더이상 읽을 파일이 없음
                    out.write(buffer, 0, read);
                }
                
        } catch (Exception e) {
            throw new Exception("download error");
        }
    }
	
}
