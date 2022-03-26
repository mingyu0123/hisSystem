package com.his.hisSystem.mapper;

import java.util.List;
import java.util.Map;

import com.his.hisSystem.service.BoardDto;
import com.his.hisSystem.util.FileVO;

public interface FileMapper {

	public List<FileVO> fileList(Map map) throws Exception; 
	public void insertFile(Map map) throws Exception;
	public void deleteFile(Map map) throws Exception;
}
