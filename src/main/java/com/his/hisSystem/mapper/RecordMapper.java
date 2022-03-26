package com.his.hisSystem.mapper;

import java.util.List;
import java.util.Map;

import com.his.hisSystem.service.RecordDto;

public interface RecordMapper {

	public List<RecordDto> selectRecordList() throws Exception;
	public List<RecordDto> mainRecordList() throws Exception; 
	public int countRecord(Map map) throws Exception;
	public int nextRecordSeq() throws Exception;
	public RecordDto detailRecordList(Map map) throws Exception;
	public void insertRecord(Map map) throws Exception;
	public void updateRecord(Map map) throws Exception;
	public void deleteRecord(Map map) throws Exception;
}
