package com.his.hisSystem.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.his.hisSystem.service.BoardDto;
import com.his.hisSystem.service.BoardService;
import com.his.hisSystem.service.FileService;
import com.his.hisSystem.util.PagingVO;
import com.his.hisSystem.util.FileUtils;
import com.his.hisSystem.util.FileVO;

@Controller
public class BoardController {

	@Inject
    private BoardService boardService;
	
	@Inject
    private FileService fileService;
	
	@RequestMapping( value = "/board/boardList.do")
    public ModelAndView getBoardList(@RequestParam(value="nowPage",required = false)String nowPage,@RequestParam(value="cntPerPage",required = false)String cntPerPage,HttpServletRequest request, HttpServletResponse response) throws Exception{
        
    	ModelAndView model = new ModelAndView();
    	
    	model.addObject("menuCode", request.getParameter("menuCode"));
    	
    	if (nowPage == null && cntPerPage == null) {
    		nowPage = "1";
    		cntPerPage = "10";
    	} else if (nowPage == null) {
    		nowPage = "1";
    	} else if (cntPerPage == null) { 
    		cntPerPage = "10";
    	}
    	model.addObject("nowPage", request.getParameter("nowPage"));
    	model.addObject("cntPerPage", request.getParameter("cntPerPage"));
    	model.setViewName("board/boardList");
    	
        return model;
    }
	
	@RequestMapping( value = "/board/boardListPage.do")
    public ModelAndView boardListPage(PagingVO vo,@RequestParam(value="nowPage",required = false)String nowPage,@RequestParam(value="cntPerPage",required = false)String cntPerPage,HttpServletRequest request, HttpServletResponse response) throws Exception{
        
    	ModelAndView model = new ModelAndView();
    	
    	String searchType = request.getParameter("searchType");
    	String searchValue = request.getParameter("searchValue");
    	
    	Map map = new HashMap();
    	
    	map.put("searchType", searchType);
    	map.put("searchValue", searchValue);
    	
    	int total = boardService.countBoard(map);
    	
    	if (nowPage == null && cntPerPage == null) {
    		nowPage = "1";
    		cntPerPage = "10";
    	} else if (nowPage == null) {
    		nowPage = "1";
    	} else if (cntPerPage == null) { 
    		cntPerPage = "10";
    	}
    	
    	vo = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
    	model.addObject("paging", vo);
    	    	
    	map.put("start", vo.getStart());
    	map.put("end", vo.getEnd());
    	
    	List<BoardDto> boardList = boardService.selectBoardList(map);
    	
    	model.addObject("searchType", searchType);
    	model.addObject("searchValue", searchValue);
    	
    	model.addObject("list", boardList);
    	model.addObject("totalCnt",total);
    	
    	model.setViewName("board/boardListPage");
    	
        return model;
    }
	
	@RequestMapping( value = "/board/boardView.do")
    public ModelAndView boardView(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception{
        
    	ModelAndView model = new ModelAndView();
    	
    	Map map = new HashMap();
    	
    	int boardSeq = Integer.parseInt(request.getParameter("boardSeq"));
    	
    	map.put("boardSeq", boardSeq);
    	
    	boardService.udateHits(map);
    	
    	model.addObject("detail", boardService.detailBoardList(map));
    	model.addObject("menuCode", request.getParameter("menuCode"));
    	model.addObject("nowPage", request.getParameter("nowPage"));
    	model.addObject("cntPerPage", request.getParameter("cntPerPage"));
    	model.addObject("userInfo", session.getAttribute("userInfo"));
    	model.setViewName("board/boardView");
    	
        return model;
    }
	
	@RequestMapping( value = "/board/boardEditPage.do")
    public ModelAndView boardEditPage(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception{
        
    	ModelAndView model = new ModelAndView();
    	
    	Map map = new HashMap();
    	
    	String boardType = request.getParameter("boardType");
    	
    	if(boardType.equals("upt")) {
    		
    		int boardSeq = Integer.parseInt(request.getParameter("boardSeq"));
    		map.put("boardSeq", boardSeq);
        	model.addObject("detail", boardService.detailBoardList(map));
    	}
    	
    	
    	model.addObject("boardType", boardType);
    	model.addObject("menuCode", request.getParameter("menuCode"));
    	model.addObject("nowPage", request.getParameter("nowPage"));
    	model.addObject("cntPerPage", request.getParameter("cntPerPage"));
    	model.setViewName("board/boardEditPage");
    	
        return model;
    }
	
	@ResponseBody
	@RequestMapping("/board/boardEdit.do")
	public String boardEdit(HttpServletRequest request,HttpSession session,MultipartHttpServletRequest uploadFile) throws Exception  {
	   
	   
	   String boardTitle = request.getParameter("boardTitle");
	   String boardContent = request.getParameter("boardContent");
	   String boardWriter = request.getParameter("boardWriter");
	   String boardType = request.getParameter("boardType");
	   
	   Map map = new HashMap();
	   Map map2 = new HashMap();
	   
	   map.put("boardTitle", boardTitle);
	   map.put("boardContent", boardContent);
	   map.put("boardWriter", boardWriter);
	   
	   if(boardType.equals("ins")) {
		  
		   int boardSeq = boardService.nextBoardSeq();
		   map.put("boardSeq", boardSeq);
		   
		   boardService.insertBoard(map);
		   		   
		   MultipartFile file = uploadFile.getFile("uploadFile");
		   
		   if(!file.isEmpty()) {
			   FileUtils fileUtils = new FileUtils();
			   
			   List<FileVO> fileList = fileUtils.parseFileInfo(1, request, uploadFile);
			 
			   for(int i=0;i < fileList.size(); i++) {
			  
					map2.put("boardSeq", boardSeq);
					map2.put("orgFileName", fileList.get(i).getOrgFileName());
					map2.put("filePath", fileList.get(i).getFilePath());
					map2.put("saveFileName", fileList.get(i).getSaveFileName());
					map2.put("fileSize", fileList.get(i).getFileSize());
					
				}
			   
			   fileService.insertFile(map2);
			   
		   }
		   
		   request.setAttribute("boardType", boardType);
		   
		   return "sucess";
		   
	   }else if(boardType.equals("upt")){
		  
		   int boardSeq = Integer.parseInt(request.getParameter("boardSeq"));
		   map.put("boardSeq", boardSeq);
		   
		   map2.put("boardSeq", boardSeq);
	    	
	       List<FileVO> list =  fileService.fileList(map2);
		   
		   boardService.updateBoard(map);
		   
		   MultipartFile file2 = uploadFile.getFile("uploadFile");
		   
		   if(!file2.isEmpty()) {
		   
			   if(list.size() != 0) {
			    	
			    	String uploadPath = list.get(0).getFilePath();
			    	String savedfile = list.get(0).getSaveFileName();
			    	    
				    //수정할 때 파일을 서버에서 지웠다가 다시 쓴다. 왜냐면 이름은 같아도 다른 파일일 수도 있기 때문에 코드내에서 판별하기 좀 그럼.
				    if(savedfile!= null) {
				        String fullpath = uploadPath + savedfile;
				        File file = new File(fullpath);
				        
				        //파일 삭제는 간단하네.
				        if(file.isFile()) {
				            file.delete();
				        }
				    }
				    
				    map2.put("fileNo", list.get(0).getFileNo());
				    
			    	fileService.deleteFile(map2);
				    
		    	}
			    FileUtils fileUtils = new FileUtils();
				
				List<FileVO> fileList = fileUtils.parseFileInfo(1, request, uploadFile);
			    	    
			    for(int i=0;i < fileList.size(); i++) {
					  
					map2.put("boardSeq", boardSeq);
					map2.put("orgFileName", fileList.get(i).getOrgFileName());
					map2.put("filePath", fileList.get(i).getFilePath());
					map2.put("saveFileName", fileList.get(i).getSaveFileName());
					map2.put("fileSize", fileList.get(i).getFileSize());
					
				}
			    
		    	fileService.insertFile(map2);
		   }
		   
		   request.setAttribute("boardType", boardType);
		   
		   return "sucess";
		   
	   } else {
		   return "fail";
	   }
	   
	}
	
	@ResponseBody
	@RequestMapping("/board/deleteBoard.do")
	public String deleteBoard(HttpServletRequest request,HttpSession session) throws Exception  {
	   
		   Map map = new HashMap();
		
		   int boardSeq = Integer.parseInt(request.getParameter("boardSeq"));
		   map.put("boardSeq", boardSeq);
		   		   
		   List<FileVO> list =  fileService.fileList(map);
	    	
		   if(list.size() > 0) {
		    	String uploadPath = list.get(0).getFilePath();
		    	String savedfile = list.get(0).getSaveFileName();
		    	    
			    //수정할 때 파일을 서버에서 지웠다가 다시 쓴다. 왜냐면 이름은 같아도 다른 파일일 수도 있기 때문에 코드내에서 판별하기 좀 그럼.
			    if(savedfile!= null) {
			        String fullpath = uploadPath + savedfile;
			        File file = new File(fullpath);
			        
			        //파일 삭제는 간단하네.
			        if(file.isFile()) {
			            file.delete();
			        }
			    }
		    	
			    map.put("fileNo", list.get(0).getFileNo());
			    
		       fileService.deleteFile(map);
		   }
			   
		   boardService.deleteBoard(map);
		   
		   return "sucess";
	   
	}
	
	@RequestMapping( value = "/fileDown")
    public void fileDown(HttpServletRequest request, HttpServletResponse response) throws Exception{
        
    	String filePath = request.getParameter("filePath");
    	
    	FileUtils fileUtils = new FileUtils();
    	
    	fileUtils.download(response, filePath);
    	
    	
    }
}
