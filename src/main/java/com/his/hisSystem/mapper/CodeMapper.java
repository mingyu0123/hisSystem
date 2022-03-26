package com.his.hisSystem.mapper;

import java.util.List;
import java.util.Map;

import com.his.hisSystem.service.BoardDto;
import com.his.hisSystem.service.CodeDto;
import com.his.hisSystem.util.FileVO;

public interface CodeMapper {

	public List<CodeDto> codeList(Map map) throws Exception; 
}
