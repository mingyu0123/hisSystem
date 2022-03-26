package com.his.hisSystem.service;

import java.util.List;
import java.util.Map;

public interface LoginService {

	int loginCheck(Map map) throws Exception; 
	UserDto loginUserInfo(Map map) throws Exception;
}
