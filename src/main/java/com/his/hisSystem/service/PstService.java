package com.his.hisSystem.service;

import java.util.List;
import java.util.Map;

public interface PstService {

	List<PstDto> selectPstList(Map map) throws Exception;
	List<PstDto> mainPstList(Map map) throws Exception;
	int countPst(Map map) throws Exception;
	int nextPstSeq() throws Exception;
	PstDto detailPstList(Map map) throws Exception;
	void insertPst(Map map) throws Exception;
	void updatePst(Map map) throws Exception;
	void deletePst(Map map) throws Exception;
}
