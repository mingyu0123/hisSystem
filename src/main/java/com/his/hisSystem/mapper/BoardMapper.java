package com.his.hisSystem.mapper;

import java.util.List;
import java.util.Map;

import com.his.hisSystem.service.BoardDto;

public interface BoardMapper {

	public List<BoardDto> selectBoardList() throws Exception;
	public List<BoardDto> mainBoardList() throws Exception; 
	public int countBoard(Map map) throws Exception;
	public int nextBoardSeq() throws Exception;
	public BoardDto detailBoardList(Map map) throws Exception;
	public void insertBoard(Map map) throws Exception;
	public void updateBoard(Map map) throws Exception;
	public void deleteBoard(Map map) throws Exception;
	public void udateHits(Map map) throws Exception;
}
