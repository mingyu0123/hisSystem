package com.his.hisSystem.mapper;

import java.util.List;
import java.util.Map;

import com.his.hisSystem.service.IstDto;
import com.his.hisSystem.service.PstDto;
import com.his.hisSystem.service.UserDto;

public interface IstMapper {

	public List<IstDto> selectIstList() throws Exception;
	public List<IstDto> mainIstList(Map map) throws Exception;
	public int countIst(Map map) throws Exception;
	public int nextIstSeq() throws Exception;
	public IstDto detailIstList(Map map) throws Exception;
	public void insertIst(Map map) throws Exception;
	public int recipientCnt(Map map) throws Exception;
	public void updateStatus(Map map) throws Exception;
	public String selectStatus(Map map) throws Exception;
}
