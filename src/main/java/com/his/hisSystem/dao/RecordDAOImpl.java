package com.his.hisSystem.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.his.hisSystem.service.RecordDto;

@Repository
public class RecordDAOImpl implements RecordDAO {

	@Inject
	private SqlSession sqlSession;
	
	//mapper.xml 네임스페이스 명시
	private static final String namespace = "com.his.hisSystem.mapper.RecordMapper";
	
	@Override
	public List<RecordDto> selectRecordList(Map map) throws Exception {
		return sqlSession.selectList(namespace+".selectRecordList",map);
	}
	
	@Override
	public List<RecordDto> mainRecordList(Map map) throws Exception {
		return sqlSession.selectList(namespace+".mainRecordList",map);
	}
	
	@Override
	public int countRecord(Map map) throws Exception {
		return sqlSession.selectOne(namespace+".countRecord",map);
	}
	
	@Override
	public int nextRecordSeq() throws Exception {
		return sqlSession.selectOne(namespace+".nextRecordSeq");
	}
	
	@Override
	public RecordDto detailRecordList(Map map) throws Exception {
		return sqlSession.selectOne(namespace+".detailRecordList",map);
	}
	
	@Override
	public void insertRecord(Map map) throws Exception {
		sqlSession.insert(namespace+".insertRecord",map);
	}
	
	@Override
	public void updateRecord(Map map) throws Exception {
		sqlSession.update(namespace+".updateRecord",map);
	}
	
	@Override
	public void deleteRecord(Map map) throws Exception {
		sqlSession.update(namespace+".deleteRecord",map);
	}
	
}
