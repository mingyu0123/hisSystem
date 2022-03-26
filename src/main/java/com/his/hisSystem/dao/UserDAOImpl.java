package com.his.hisSystem.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.his.hisSystem.service.UserDto;

@Repository
public class UserDAOImpl implements UserDAO {

	@Inject
	private SqlSession sqlSession;
	
	//mapper.xml 네임스페이스 명시
	private static final String namespace = "com.his.hisSystem.mapper.UserMapper";
	
	@Override
	public List<UserDto> selectUserList(Map map) throws Exception {
		return sqlSession.selectList(namespace+".selectUserList",map);
	}
	
	@Override
	public int countUser(Map map) throws Exception {
		return sqlSession.selectOne(namespace+".countUser",map);
	}
	
	@Override
	public int nextUserSeq() throws Exception {
		return sqlSession.selectOne(namespace+".nextUserSeq");
	}
	
	@Override
	public UserDto detailUserList(Map map) throws Exception {
		return sqlSession.selectOne(namespace+".detailUserList",map);
	}
	
	@Override
	public void insertUser(Map map) throws Exception {
		sqlSession.insert(namespace+".insertUser",map);
	}
	
	@Override
	public void updateUser(Map map) throws Exception {
		sqlSession.update(namespace+".updateUser",map);
	}
	
	@Override
	public void deleteUser(Map map) throws Exception {
		sqlSession.update(namespace+".deleteUser",map);
	}
	
	@Override
	public int userPwdChk(Map map) throws Exception {
		return sqlSession.selectOne(namespace+".userPwdChk",map);
	}
	
	@Override
	public void userPwdChg(Map map) throws Exception {
		sqlSession.update(namespace+".userPwdChg",map);
	}
	
	@Override
	public int userIdChk(Map map) throws Exception {
		return sqlSession.selectOne(namespace+".userIdChk",map);
	}
	
}
