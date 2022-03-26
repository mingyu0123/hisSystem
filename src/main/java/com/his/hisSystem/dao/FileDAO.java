package com.his.hisSystem.dao;

import java.util.List;
import java.util.Map;

import com.his.hisSystem.service.BoardDto;
import com.his.hisSystem.service.UserDto;
import com.his.hisSystem.util.FileVO;

public interface FileDAO {

	List<FileVO> fileList(Map map) throws Exception;
	void insertFile(Map map) throws Exception;
	void deleteFile(Map map) throws Exception;
}
