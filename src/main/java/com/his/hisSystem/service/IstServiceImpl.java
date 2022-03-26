package com.his.hisSystem.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.his.hisSystem.dao.IstDAO;

@Service
public class IstServiceImpl implements IstService {

	@Inject
	private IstDAO dao;
		
	@Override
	public List<IstDto> selectIstList(Map map) throws Exception {
		return dao.selectIstList(map);
	}
	
	@Override
	public List<IstDto> mainIstList(Map map) throws Exception {
		return dao.mainIstList(map);
	}
	
	@Override
	public int countIst(Map map) throws Exception {
		return dao.countIst(map);
	}
	
	@Override
	public int nextIstSeq() throws Exception {
		return dao.nextIstSeq();
	}
	
	@Override
	public IstDto detailIstList(Map map) throws Exception {
		return dao.detailIstList(map);
	}
	
	@Override
	public void insertIst(Map map) throws Exception {
		dao.insertIst(map);
	}
	
	@Override
	public int recipientCnt(Map map) throws Exception {
		return dao.recipientCnt(map);
	}
	
	@Override
	public void updateStatus(Map map) throws Exception {
		dao.updateStatus(map);
	}
	
	@Override
	public String selectStatus(Map map) throws Exception {
		return dao.selectStatus(map);
	}
}
