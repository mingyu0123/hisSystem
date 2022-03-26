package com.his.hisSystem.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.his.hisSystem.service.IstDto;

@Repository
public class IstDAOImpl implements IstDAO {

	@Inject
	private SqlSession sqlSession;
	
	//mapper.xml 네임스페이스 명시
	private static final String namespace = "com.his.hisSystem.mapper.IstMapper";
	
	@Override
	public List<IstDto> selectIstList(Map map) throws Exception {
		return sqlSession.selectList(namespace+".selectIstList",map);
	}
	
	@Override
	public List<IstDto> mainIstList(Map map) throws Exception {
		return sqlSession.selectList(namespace+".mainIstList",map);
	}
	
	@Override
	public int countIst(Map map) throws Exception {
		return sqlSession.selectOne(namespace+".countIst",map);
	}
	
	@Override
	public int nextIstSeq() throws Exception {
		return sqlSession.selectOne(namespace+".nextIstSeq");
	}
	
	@Override
	public IstDto detailIstList(Map map) throws Exception {
		return sqlSession.selectOne(namespace+".detailIstList",map);
	}
	
	@Override
	public void insertIst(Map map) throws Exception {
		sqlSession.insert(namespace+".insertIst",map);
	}
	
	@Override
	public int recipientCnt(Map map) throws Exception {
		return sqlSession.selectOne(namespace+".recipientCnt",map);
	}
	
	@Override
	public void updateStatus(Map map) throws Exception {
		sqlSession.insert(namespace+".updateStatus",map);
	}
	
	@Override
	public String selectStatus(Map map) throws Exception {
		return sqlSession.selectOne(namespace+".selectStatus",map);
	}
}
