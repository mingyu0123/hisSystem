package com.his.hisSystem.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.his.hisSystem.dao.PstDAO;

@Service
public class PstServiceImpl implements PstService {

	@Inject
	private PstDAO dao;
	
	@Override
	public List<PstDto> selectPstList(Map map) throws Exception {
		return dao.selectPstList(map);
	}
	
	@Override
	public List<PstDto> mainPstList(Map map) throws Exception {
		return dao.mainPstList(map);
	}
	
	@Override
	public int countPst(Map map) throws Exception {
		return dao.countPst(map);
	}
	
	@Override
	public int nextPstSeq() throws Exception {
		return dao.nextPstSeq();
	}
	
	@Override
	public PstDto detailPstList(Map map) throws Exception {
		return dao.detailPstList(map);
	}
	
	@Override
	public void insertPst(Map map) throws Exception {
		dao.insertPst(map);
	}
	
	@Override
	public void updatePst(Map map) throws Exception {
		dao.updatePst(map);
	}
	
	@Override
	public void deletePst(Map map) throws Exception {
		dao.deletePst(map);
	}
	
}
