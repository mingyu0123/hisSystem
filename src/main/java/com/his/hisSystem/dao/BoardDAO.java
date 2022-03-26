package com.his.hisSystem.dao;

import java.util.List;
import java.util.Map;

import com.his.hisSystem.service.BoardDto;
import com.his.hisSystem.service.UserDto;

public interface BoardDAO {

	List<BoardDto> selectBoardList(Map map) throws Exception;
	List<BoardDto> mainBoardList(Map map) throws Exception;
	int countBoard(Map map) throws Exception;
	int nextBoardSeq() throws Exception;
	BoardDto detailBoardList(Map map) throws Exception;
	void insertBoard(Map map) throws Exception;
	void updateBoard(Map map) throws Exception;
	void deleteBoard(Map map) throws Exception;
	void udateHits(Map map) throws Exception;
}
