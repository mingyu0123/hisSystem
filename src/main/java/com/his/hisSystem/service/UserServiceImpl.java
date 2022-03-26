package com.his.hisSystem.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.his.hisSystem.dao.UserDAO;

@Service
public class UserServiceImpl implements UserService {

	@Inject
	private UserDAO dao;
	
	@Override
	public List<UserDto> selectUserList(Map map) throws Exception {
		return dao.selectUserList(map);
	}
	
	@Override
	public int countUser(Map map) throws Exception {
		return dao.countUser(map);
	}
	
	@Override
	public int nextUserSeq() throws Exception {
		return dao.nextUserSeq();
	}
	
	@Override
	public UserDto detailUserList(Map map) throws Exception {
		return dao.detailUserList(map);
	}
	
	@Override
	public void insertUser(Map map) throws Exception {
		dao.insertUser(map);
	}
	
	@Override
	public void updateUser(Map map) throws Exception {
		dao.updateUser(map);
	}
	
	@Override
	public void deleteUser(Map map) throws Exception {
		dao.deleteUser(map);
	}
	
	@Override
	public int userPwdChk(Map map) throws Exception {
		return dao.userPwdChk(map);
	}
	
	@Override
	public void userPwdChg(Map map) throws Exception {
		dao.userPwdChg(map);
	}
	
	@Override
	public int userIdChk(Map map) throws Exception {
		return dao.userIdChk(map);
	}
	
}
