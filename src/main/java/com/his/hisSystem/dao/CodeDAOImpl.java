package com.his.hisSystem.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.his.hisSystem.service.BoardDto;
import com.his.hisSystem.service.CodeDto;
import com.his.hisSystem.util.FileVO;

@Repository
public class CodeDAOImpl implements CodeDAO {

	@Inject
	private SqlSession sqlSession;
	
	//mapper.xml 네임스페이스 명시
	private static final String namespace = "com.his.hisSystem.mapper.codeMapper";
	
	@Override
	public List<CodeDto> codeList(Map map) throws Exception {
		return sqlSession.selectList(namespace+".codeList",map);
	}
	
}
