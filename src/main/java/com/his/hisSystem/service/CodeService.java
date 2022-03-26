package com.his.hisSystem.service;

import java.util.List;
import java.util.Map;

import com.his.hisSystem.util.FileVO;

public interface CodeService {

	List<CodeDto> codeList(Map map) throws Exception;
}
