package com.his.hisSystem.dao;

import java.util.List;
import java.util.Map;

import com.his.hisSystem.service.PstDto;

public interface PstDAO {

	List<PstDto> selectPstList(Map map) throws Exception;
	List<PstDto> mainPstList(Map map) throws Exception;
	int countPst(Map map) throws Exception;
	int nextPstSeq() throws Exception;
	PstDto detailPstList(Map map) throws Exception;
	void insertPst(Map map) throws Exception;
	void updatePst(Map map) throws Exception;
	void deletePst(Map map) throws Exception;
}
