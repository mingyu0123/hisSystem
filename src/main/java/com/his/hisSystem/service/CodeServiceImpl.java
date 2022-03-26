package com.his.hisSystem.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.his.hisSystem.dao.BoardDAO;
import com.his.hisSystem.dao.CodeDAO;
import com.his.hisSystem.dao.FileDAO;
import com.his.hisSystem.util.FileVO;

@Service
public class CodeServiceImpl implements CodeService {

	@Inject
	private CodeDAO dao;
	
	@Override
	public List<CodeDto> codeList(Map map) throws Exception {
		return dao.codeList(map);
	}
	
	
}
