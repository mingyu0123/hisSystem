package com.his.hisSystem.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.his.hisSystem.service.BoardDto;

@Repository
public class BoardDAOImpl implements BoardDAO {

	@Inject
	private SqlSession sqlSession;
	
	//mapper.xml 네임스페이스 명시
	private static final String namespace = "com.his.hisSystem.mapper.BoardMapper";
	
	@Override
	public List<BoardDto> selectBoardList(Map map) throws Exception {
		return sqlSession.selectList(namespace+".selectBoardList",map);
	}
	
	@Override
	public List<BoardDto> mainBoardList(Map map) throws Exception {
		return sqlSession.selectList(namespace+".mainBoardList",map);
	}
	
	@Override
	public int countBoard(Map map) throws Exception {
		return sqlSession.selectOne(namespace+".countBoard",map);
	}
	
	@Override
	public int nextBoardSeq() throws Exception {
		return sqlSession.selectOne(namespace+".nextBoardSeq");
	}
	
	@Override
	public BoardDto detailBoardList(Map map) throws Exception {
		return sqlSession.selectOne(namespace+".detailBoardList",map);
	}
	
	@Override
	public void insertBoard(Map map) throws Exception {
		sqlSession.insert(namespace+".insertBoard",map);
	}
	
	@Override
	public void updateBoard(Map map) throws Exception {
		sqlSession.update(namespace+".updateBoard",map);
	}
	
	@Override
	public void deleteBoard(Map map) throws Exception {
		sqlSession.update(namespace+".deleteBoard",map);
	}
	
	@Override
	public void udateHits(Map map) throws Exception {
		sqlSession.update(namespace+".udateHits",map);
	}
	
}
