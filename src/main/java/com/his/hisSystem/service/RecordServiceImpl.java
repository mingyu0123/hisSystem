package com.his.hisSystem.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.his.hisSystem.dao.RecordDAO;

@Service
public class RecordServiceImpl implements RecordService {

	@Inject
	private RecordDAO dao;
	
	@Override
	public List<RecordDto> selectRecordList(Map map) throws Exception {
		return dao.selectRecordList(map);
	}
	
	@Override
	public List<RecordDto> mainRecordList(Map map) throws Exception {
		return dao.mainRecordList(map);
	}
	
	@Override
	public int countRecord(Map map) throws Exception {
		return dao.countRecord(map);
	}
	
	@Override
	public int nextRecordSeq() throws Exception {
		return dao.nextRecordSeq();
	}
	
	@Override
	public RecordDto detailRecordList(Map map) throws Exception {
		return dao.detailRecordList(map);
	}
	
	@Override
	public void insertRecord(Map map) throws Exception {
		dao.insertRecord(map);
	}
	
	@Override
	public void updateRecord(Map map) throws Exception {
		dao.updateRecord(map);
	}
	
	@Override
	public void deleteRecord(Map map) throws Exception {
		dao.deleteRecord(map);
	}
	
}
