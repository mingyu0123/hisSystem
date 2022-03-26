package com.his.hisSystem.mapper;

import java.util.List;
import java.util.Map;

import com.his.hisSystem.service.UserDto;

public interface LoginMapper {

	public int loginCheck(Map map) throws Exception; 
	public UserDto loginUserInfo(Map map) throws Exception; 
	
}
