package com.his.hisSystem.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.his.hisSystem.service.BoardDto;
import com.his.hisSystem.util.FileVO;

@Repository
public class FileDAOImpl implements FileDAO {

	@Inject
	private SqlSession sqlSession;
	
	//mapper.xml 네임스페이스 명시
	private static final String namespace = "com.his.hisSystem.mapper.FileMapper";
	
	@Override
	public List<FileVO> fileList(Map map) throws Exception {
		return sqlSession.selectList(namespace+".fileList",map);
	}
	
	@Override
	public void insertFile(Map map) throws Exception {
		sqlSession.insert(namespace+".insertFile",map);
	}
	
	@Override
	public void deleteFile(Map map) throws Exception {
		sqlSession.update(namespace+".deleteFile",map);
	}
	
}
