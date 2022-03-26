package com.his.hisSystem.dao;

import java.util.List;
import java.util.Map;

import com.his.hisSystem.service.CodeDto;

public interface CodeDAO {

	List<CodeDto> codeList(Map map) throws Exception;
}
