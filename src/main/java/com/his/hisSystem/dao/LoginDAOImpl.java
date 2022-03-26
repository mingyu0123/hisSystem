package com.his.hisSystem.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.his.hisSystem.service.BoardDto;
import com.his.hisSystem.service.UserDto;

@Repository
public class LoginDAOImpl implements LoginDAO {

	@Inject
	private SqlSession sqlSession;
	
	//mapper.xml 네임스페이스 명시
	private static final String namespace = "com.his.hisSystem.mapper.LoginMapper";
	
	@Override
	public int loginCheck(Map map) throws Exception {
		return sqlSession.selectOne(namespace+".loginCheck",map);
	}
	
	@Override
	public UserDto loginUserInfo(Map map) throws Exception {
		return sqlSession.selectOne(namespace+".loginUserInfo",map);
	}
	
}
