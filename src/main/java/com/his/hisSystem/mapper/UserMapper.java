package com.his.hisSystem.mapper;

import java.util.List;
import java.util.Map;

import com.his.hisSystem.service.UserDto;

public interface UserMapper {

	public List<UserDto> selectUserList(Map map) throws Exception;
	public int countUser(Map map) throws Exception;
	public int nextUserSeq() throws Exception;
	public UserDto detailUserList(Map map) throws Exception;
	public void insertUser(Map map) throws Exception;
	public void updateUser(Map map) throws Exception;
	public void deleteUser(Map map) throws Exception;
	public int userPwdChk(Map map) throws Exception;
	public void userPwdChg(Map map) throws Exception;
	public int userIdChk(Map map) throws Exception;
}
