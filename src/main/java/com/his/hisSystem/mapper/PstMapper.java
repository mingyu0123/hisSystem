package com.his.hisSystem.mapper;

import java.util.List;
import java.util.Map;

import com.his.hisSystem.service.PstDto;

public interface PstMapper {

	public List<PstDto> selectPstList() throws Exception;
	public List<PstDto> mainPstList(Map map) throws Exception;
	public int countPst(Map map) throws Exception;
	public int nextPstSeq() throws Exception;
	public PstDto detailPstList(Map map) throws Exception;
	public void insertPst(Map map) throws Exception;
	public void updatePst(Map map) throws Exception;
	public void deletePst(Map map) throws Exception;
}
