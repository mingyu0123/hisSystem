package com.his.hisSystem.service;

import java.util.List;
import java.util.Map;

public interface IstService {

	List<IstDto> selectIstList(Map map) throws Exception;
	List<IstDto> mainIstList(Map map) throws Exception;
	int countIst(Map map) throws Exception;
	int nextIstSeq() throws Exception;
	IstDto detailIstList(Map map) throws Exception;
	void insertIst(Map map) throws Exception;
	int recipientCnt(Map map) throws Exception;
	void updateStatus(Map map) throws Exception;
	String selectStatus(Map map) throws Exception;
}
