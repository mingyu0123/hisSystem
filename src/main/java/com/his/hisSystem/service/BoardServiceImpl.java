package com.his.hisSystem.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.his.hisSystem.dao.BoardDAO;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardDAO dao;
	
	@Override
	public List<BoardDto> selectBoardList(Map map) throws Exception {
		return dao.selectBoardList(map);
	}
	
	@Override
	public List<BoardDto> mainBoardList(Map map) throws Exception {
		return dao.mainBoardList(map);
	}
	
	@Override
	public int countBoard(Map map) throws Exception {
		return dao.countBoard(map);
	}
	
	@Override
	public int nextBoardSeq() throws Exception {
		return dao.nextBoardSeq();
	}
	
	@Override
	public BoardDto detailBoardList(Map map) throws Exception {
		return dao.detailBoardList(map);
	}
	
	@Override
	public void insertBoard(Map map) throws Exception {
		dao.insertBoard(map);
	}
	
	@Override
	public void updateBoard(Map map) throws Exception {
		dao.updateBoard(map);
	}
	
	@Override
	public void deleteBoard(Map map) throws Exception {
		dao.deleteBoard(map);
	}
	
	@Override
	public void udateHits(Map map) throws Exception {
		dao.udateHits(map);
	}
	
}
