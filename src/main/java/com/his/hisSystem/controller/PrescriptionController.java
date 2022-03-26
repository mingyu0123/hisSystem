package com.his.hisSystem.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.his.hisSystem.service.BoardService;
import com.his.hisSystem.service.PstDto;
import com.his.hisSystem.service.PstService;
import com.his.hisSystem.service.UserDto;
import com.his.hisSystem.util.PagingVO;

@Controller
public class PrescriptionController {

	@Inject
    private PstService pstService;
	
	@RequestMapping( value = "/pst/pstList.do")
    public ModelAndView pstList(@RequestParam(value="nowPage",required = false)String nowPage,@RequestParam(value="cntPerPage",required = false)String cntPerPage, HttpServletRequest request, HttpServletResponse response) throws Exception{
        
    	ModelAndView model = new ModelAndView();
    	
    	if (nowPage == null && cntPerPage == null) {
    		nowPage = "1";
    		cntPerPage = "10";
    	} else if (nowPage == null) {
    		nowPage = "1";
    	} else if (cntPerPage == null) { 
    		cntPerPage = "10";
    	}
    	
    	model.addObject("menuCode", request.getParameter("menuCode"));
    	model.addObject("nowPage", request.getParameter("nowPage"));
    	model.addObject("cntPerPage", request.getParameter("cntPerPage"));
    	
    	model.setViewName("pst/pstList");
    	
        return model;
    }
	
	@RequestMapping( value = "/pst/pstListPage.do")
    public ModelAndView pstListPage(PagingVO vo,@RequestParam(value="nowPage",required = false)String nowPage,@RequestParam(value="cntPerPage",required = false)String cntPerPage,HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception{
        
    	ModelAndView model = new ModelAndView();
    	
    	String searchType = request.getParameter("searchType");
    	String searchValue = request.getParameter("searchValue");
    	
    	Map map = new HashMap();
    	
    	map.put("searchType", searchType);
    	map.put("searchValue", searchValue);
    	
    	int total = pstService.countPst(map);
    	
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
    	
    	UserDto userDto = (UserDto)session.getAttribute("userInfo");
    	map.put("pstWriter", userDto.getUserSeq());
    	
    	List<PstDto> pstList = pstService.selectPstList(map);
    	
    	model.addObject("searchType", searchType);
    	model.addObject("searchValue", searchValue);
    	
    	model.addObject("list", pstList);
    	model.addObject("totalCnt",total);
    	
    	model.setViewName("pst/pstListPage");
    	
        return model;
    }
	
	@RequestMapping( value = "/pst/pstView.do")
    public ModelAndView pstView(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
        
    	ModelAndView model = new ModelAndView();
    	Map map = new HashMap();
    	
    	int pstSeq = Integer.parseInt(request.getParameter("pstSeq"));
    	
    	map.put("pstSeq", pstSeq);
    	
    	model.addObject("detail", pstService.detailPstList(map));
    	model.addObject("menuCode", request.getParameter("menuCode"));
    	model.addObject("nowPage", request.getParameter("nowPage"));
    	model.addObject("cntPerPage", request.getParameter("cntPerPage"));
    	model.addObject("userInfo", session.getAttribute("userInfo"));
    	
    	model.setViewName("pst/pstView");
    	
        return model;
    }
	
	@RequestMapping( value = "/pst/pstEditPage.do")
    public ModelAndView pstEditPage(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception{
        
    	ModelAndView model = new ModelAndView();
    	
    	Map map = new HashMap();
    	
    	String boardType = request.getParameter("boardType");
    	
    	if(boardType.equals("upt")) {
    		
    		int pstSeq = Integer.parseInt(request.getParameter("pstSeq"));
    		map.put("pstSeq", pstSeq);
        	model.addObject("detail", pstService.detailPstList(map));
    	}
    	
    	
    	model.addObject("boardType", boardType);
    	model.addObject("menuCode", request.getParameter("menuCode"));
    	model.addObject("nowPage", request.getParameter("nowPage"));
    	model.addObject("cntPerPage", request.getParameter("cntPerPage"));
    	model.setViewName("pst/pstEditPage");
    	
        return model;
    }
	
	@ResponseBody
	@RequestMapping("/pst/pstEdit.do")
	public String pstEdit(HttpServletRequest request,HttpSession session) throws Exception  {
	   
	   
	   String pstTitle = request.getParameter("pstTitle");
	   String pstDrugname = request.getParameter("pstDrugname");
	   String pstVolume = request.getParameter("pstVolume");
	   String pstNumber = request.getParameter("pstNumber");
	   String pstDays = request.getParameter("pstDays");
	   String pstYongbyeol = request.getParameter("pstYongbyeol");
	   String pstNote = request.getParameter("pstNote");
	   String pstName = request.getParameter("pstName");
	   String pstBirthdate = request.getParameter("pstBirthdate");
	   String boardType = request.getParameter("boardType");
	   String pstWriter = request.getParameter("pstWriter");
	   
	   
	   Map map = new HashMap();
	   
	   map.put("pstTitle", pstTitle);
	   map.put("pstDrugname", pstDrugname);
	   map.put("pstVolume", pstVolume);
	   map.put("pstNumber", pstNumber);
	   map.put("pstDays", pstDays);
	   map.put("pstYongbyeol", pstYongbyeol);
	   map.put("pstNote", pstNote);
	   map.put("pstName", pstName);
	   map.put("pstBirthdate", pstBirthdate);
	   map.put("pstWriter", pstWriter);
	   
	   if(boardType.equals("ins")) {
		  
		   int pstSeq = pstService.nextPstSeq();
		   map.put("pstSeq", pstSeq);
		   
		   pstService.insertPst(map);
		   		   
		   request.setAttribute("boardType", boardType);
		   
		   return "sucess";
		   
	   }else if(boardType.equals("upt")){
		  
		   int pstSeq = Integer.parseInt(request.getParameter("pstSeq"));
		   map.put("pstSeq", pstSeq);
		   		   
		   pstService.updatePst(map);
		   
		   request.setAttribute("boardType", boardType);
		   
		   return "sucess";
		   
	   }else if(boardType.equals("del")){
		  
		   int pstSeq = Integer.parseInt(request.getParameter("pstSeq"));
		   map.put("pstSeq", pstSeq);
		   		   
		   pstService.deletePst(map);
		   
		   request.setAttribute("boardType", boardType);
		   
		   return "sucess";
		   
	   } else {
		   return "fail";
	   }
	   
	}
	
	@RequestMapping( value = "/pst/pstPrintPage.do")
    public ModelAndView pstPrintPage(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
        
    	ModelAndView model = new ModelAndView();
    	Map map = new HashMap();
    	
    	int pstSeq = Integer.parseInt(request.getParameter("pstSeq"));
    	
    	map.put("pstSeq", pstSeq);
    	
    	model.addObject("detail", pstService.detailPstList(map));
    	model.addObject("userInfo", session.getAttribute("userInfo"));
    	
    	model.setViewName("pst/pstPrintPage");
    	
        return model;
    }
	
}
