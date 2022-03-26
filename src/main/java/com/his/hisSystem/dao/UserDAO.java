package com.his.hisSystem.dao;

import java.util.List;
import java.util.Map;

import com.his.hisSystem.service.UserDto;

public interface UserDAO {

	List<UserDto> selectUserList(Map map) throws Exception;
	int countUser(Map map) throws Exception;
	int nextUserSeq() throws Exception;
	UserDto detailUserList(Map map) throws Exception;
	void insertUser(Map map) throws Exception;
	void updateUser(Map map) throws Exception;
	void deleteUser(Map map) throws Exception;
	int userPwdChk(Map map) throws Exception;
	void userPwdChg(Map map) throws Exception;
	int userIdChk(Map map) throws Exception;
}
