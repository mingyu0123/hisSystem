package com.his.hisSystem.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.his.hisSystem.dao.BoardDAO;
import com.his.hisSystem.dao.FileDAO;
import com.his.hisSystem.util.FileVO;

@Service
public class FileServiceImpl implements FileService {

	@Inject
	private FileDAO dao;
	
	@Override
	public List<FileVO> fileList(Map map) throws Exception {
		return dao.fileList(map);
	}
	
	@Override
	public void insertFile(Map map) throws Exception {
		dao.insertFile(map);
	}
	
	@Override
	public void deleteFile(Map map) throws Exception {
		dao.deleteFile(map);
	}
	
	
}
