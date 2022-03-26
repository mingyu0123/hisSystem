package com.his.hisSystem.service;

import java.util.List;
import java.util.Map;

public interface RecordService {

	List<RecordDto> selectRecordList(Map map) throws Exception;
	List<RecordDto> mainRecordList(Map map) throws Exception;
	int countRecord(Map map) throws Exception;
	int nextRecordSeq() throws Exception;
	RecordDto detailRecordList(Map map) throws Exception;
	void insertRecord(Map map) throws Exception;
	void updateRecord(Map map) throws Exception;
	void deleteRecord(Map map) throws Exception;
}
