package com.his.hisSystem.service;

import java.util.List;
import java.util.Map;

import com.his.hisSystem.util.FileVO;

public interface FileService {

	List<FileVO> fileList(Map map) throws Exception;
	void insertFile(Map map) throws Exception;
	void deleteFile(Map map) throws Exception;
}
