package com.his.hisSystem.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.his.hisSystem.dao.BoardDAO;
import com.his.hisSystem.dao.LoginDAO;

@Service
public class LoginServiceImpl implements LoginService {

	@Inject
	private LoginDAO dao;
	
	@Override
	public int loginCheck(Map map) throws Exception {
		return dao.loginCheck(map);
	}
	
	@Override
	public UserDto loginUserInfo(Map map) throws Exception {
		return dao.loginUserInfo(map);
	}
	
}
