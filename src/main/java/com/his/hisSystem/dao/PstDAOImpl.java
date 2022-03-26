package com.his.hisSystem.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.his.hisSystem.service.PstDto;

@Repository
public class PstDAOImpl implements PstDAO {

	@Inject
	private SqlSession sqlSession;
	
	//mapper.xml 네임스페이스 명시
	private static final String namespace = "com.his.hisSystem.mapper.PstMapper";
	
	@Override
	public List<PstDto> selectPstList(Map map) throws Exception {
		return sqlSession.selectList(namespace+".selectPstList",map);
	}
	
	@Override
	public List<PstDto> mainPstList(Map map) throws Exception {
		return sqlSession.selectList(namespace+".mainPstList",map);
	}
	
	@Override
	public int countPst(Map map) throws Exception {
		return sqlSession.selectOne(namespace+".countPst",map);
	}
	
	@Override
	public int nextPstSeq() throws Exception {
		return sqlSession.selectOne(namespace+".nextPstSeq");
	}
	
	@Override
	public PstDto detailPstList(Map map) throws Exception {
		return sqlSession.selectOne(namespace+".detailPstList",map);
	}
	
	@Override
	public void insertPst(Map map) throws Exception {
		sqlSession.insert(namespace+".insertPst",map);
	}
	
	@Override
	public void updatePst(Map map) throws Exception {
		sqlSession.update(namespace+".updatePst",map);
	}
	
	@Override
	public void deletePst(Map map) throws Exception {
		sqlSession.update(namespace+".deletePst",map);
	}
	
}
