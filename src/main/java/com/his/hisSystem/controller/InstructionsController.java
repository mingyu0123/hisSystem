package com.his.hisSystem.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
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
import org.springframework.web.servlet.ModelAndView;

import com.his.hisSystem.service.BoardService;
import com.his.hisSystem.service.IstDto;
import com.his.hisSystem.service.IstService;
import com.his.hisSystem.service.LoginService;
import com.his.hisSystem.service.UserDto;
import com.his.hisSystem.service.UserService;
import com.his.hisSystem.util.PagingVO;


@Controller
public class InstructionsController {

	@Inject
    private IstService istService;
		
	@RequestMapping( value = "/ist/istList.do")
    public ModelAndView istList(@RequestParam(value="nowPage",required = false)String nowPage,@RequestParam(value="cntPerPage",required = false)String cntPerPage, HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception{
        
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
    	model.addObject("userInfo", session.getAttribute("userInfo"));
    	model.setViewName("/ist/istList");
    	
        return model;
    }
	
	@RequestMapping( value = "/ist/istListPage.do")
    public ModelAndView istListPage(PagingVO vo,@RequestParam(value="nowPage",required = false)String nowPage,@RequestParam(value="cntPerPage",required = false)String cntPerPage,HttpServletRequest request, HttpServletResponse response) throws Exception{
        
    	ModelAndView model = new ModelAndView();
    	
    	String searchType = request.getParameter("searchType");
    	String searchValue = request.getParameter("searchValue");
    	String istWriter = request.getParameter("istWriter");
    	
    	Map map = new HashMap();
    	
    	map.put("searchType", searchType);
    	map.put("searchValue", searchValue);
    	map.put("istWriter", istWriter);
    	
    	int total = istService.countIst(map);
    	
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
    	
    	List<IstDto> istList = istService.selectIstList(map);
    	
    	model.addObject("searchType", searchType);
    	model.addObject("searchValue", searchValue);
    	
    	model.addObject("list", istList);
    	model.addObject("totalCnt",total);
    	    	
    	model.setViewName("ist/istListPage");
    	
        return model;
    }
	
	@ResponseBody
	@RequestMapping("/ist/istSend.do")
	public String istSend(HttpServletRequest request,HttpSession session) throws Exception  {
	   
	   
	   String istTitle = request.getParameter("istTitle");
	   String userSeq = request.getParameter("userSeq");
	   String istContent = request.getParameter("istContent");
	   String istWriter = request.getParameter("istWriter");
	   
	   Map map = new HashMap();
	   	   
	   int istSeq = istService.nextIstSeq();
	   map.put("istSeq", istSeq);
	   map.put("istTitle", istTitle);
	   map.put("istRecipient", userSeq);
	   map.put("istContent", istContent);
	   map.put("istWriter", istWriter);
	   
	   istService.insertIst(map);
	   		   	   
	   return "sucess";
	   
	}
	
	@RequestMapping( value = "/ist/istListPop.do")
    public ModelAndView istListPop(@RequestParam(value="nowPage",required = false)String nowPage,@RequestParam(value="cntPerPage",required = false)String cntPerPage, HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception{
        
    	ModelAndView model = new ModelAndView();
    	
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
    	model.addObject("userSeq", request.getParameter("userSeq"));
    	model.addObject("userInfo", session.getAttribute("userInfo"));
    	model.setViewName("/ist/istListPop");
    	
        return model;
    }
	
	@RequestMapping( value = "/ist/istListPopPage.do")
    public ModelAndView istListPopPage(PagingVO vo,@RequestParam(value="nowPage",required = false)String nowPage,@RequestParam(value="cntPerPage",required = false)String cntPerPage,HttpServletRequest request, HttpServletResponse response) throws Exception{
        
    	ModelAndView model = new ModelAndView();
    	
    	String searchType = request.getParameter("searchType");
    	String searchValue = request.getParameter("searchValue");
    	String istWriter = request.getParameter("userSeq");
    	
    	Map map = new HashMap();
    	
    	map.put("searchType", searchType);
    	map.put("searchValue", searchValue);
    	map.put("istRecipient", istWriter);
    	
    	int total = istService.countIst(map);
    	
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
    	
    	List<IstDto> istList = istService.selectIstList(map);
    	
    	model.addObject("searchType", searchType);
    	model.addObject("searchValue", searchValue);
    	
    	model.addObject("list", istList);
    	model.addObject("totalCnt",total);
    	    	
    	model.setViewName("ist/istListPopPage");
    	
        return model;
    }
	
	@ResponseBody
	@RequestMapping("/ist/selectStatus.do")
	public Map selectStatus(HttpServletRequest request,HttpSession session) throws Exception  {
	   
	   String istSeq = request.getParameter("istSeq");
	   
	   Map map = new HashMap();
	   Map map2 = new HashMap();
	   
	   map.put("istSeq", istSeq);
	   	   
	   map2.put("result", istService.selectStatus(map));
	   
	   return map2;
	}
	
	@ResponseBody
	@RequestMapping("/ist/updateStatus.do")
	public Map updateStatus(HttpServletRequest request,HttpSession session) throws Exception  {
	   
	   String istSeq = request.getParameter("istSeq");
	   
	   Map map = new HashMap();
	   Map map2 = new HashMap();
	   
	   map.put("istSeq", istSeq);
	   
	   istService.updateStatus(map);
	   
	   map2.put("result", "ok");
	   
	   return map2;
	}
}
