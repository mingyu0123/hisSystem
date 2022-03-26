package com.his.hisSystem.dao;

import java.util.List;
import java.util.Map;

import com.his.hisSystem.service.UserDto;

public interface LoginDAO {

	int loginCheck(Map map) throws Exception; 
	UserDto loginUserInfo(Map map) throws Exception;
	
}
