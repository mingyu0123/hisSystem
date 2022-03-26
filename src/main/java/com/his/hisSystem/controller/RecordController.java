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

import com.his.hisSystem.service.BoardDto;
import com.his.hisSystem.service.BoardService;
import com.his.hisSystem.service.IstService;
import com.his.hisSystem.service.LoginService;
import com.his.hisSystem.service.RecordDto;
import com.his.hisSystem.service.RecordService;
import com.his.hisSystem.service.UserDto;
import com.his.hisSystem.service.UserService;
import com.his.hisSystem.util.PagingVO;


@Controller
public class RecordController {

	@Inject
	private RecordService recordService;
	
	@RequestMapping( value = "/record/recordList.do")
    public ModelAndView recordList(@RequestParam(value="nowPage",required = false)String nowPage,@RequestParam(value="cntPerPage",required = false)String cntPerPage,HttpServletRequest request, HttpServletResponse response) throws Exception{
        
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
    	model.setViewName("record/recordList");
    	
        return model;
    }
	
	@RequestMapping( value = "/record/recordListPage.do")
    public ModelAndView recordListPage(PagingVO vo,@RequestParam(value="nowPage",required = false)String nowPage,@RequestParam(value="cntPerPage",required = false)String cntPerPage,HttpServletRequest request, HttpServletResponse response) throws Exception{
        
    	ModelAndView model = new ModelAndView();
    	
    	String searchType = request.getParameter("searchType");
    	String searchValue = request.getParameter("searchValue");
    	
    	Map map = new HashMap();
    	
    	map.put("searchType", searchType);
    	map.put("searchValue", searchValue);
    	
    	int total = recordService.countRecord(map);
    	
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
    	
    	List<RecordDto> recordList = recordService.selectRecordList(map);
    	
    	model.addObject("searchType", searchType);
    	model.addObject("searchValue", searchValue);
    	
    	model.addObject("list", recordList);
    	model.addObject("totalCnt",total);
    	
    	model.setViewName("record/recordListPage");
    	
        return model;
    }
	
	@RequestMapping( value = "/record/recordView.do")
    public ModelAndView recordView(HttpServletRequest request, HttpServletResponse response) throws Exception{
        
    	ModelAndView model = new ModelAndView();
    	String rcdSeq = request.getParameter("rcdSeq");
    	
    	Map map = new HashMap();
    	
    	map.put("rcdSeq", rcdSeq);
    	
    	model.addObject("menuCode", request.getParameter("menuCode"));
    	model.addObject("detail", recordService.detailRecordList(map));
    	model.addObject("nowPage", request.getParameter("nowPage"));
    	model.addObject("cntPerPage", request.getParameter("cntPerPage"));
    	model.setViewName("record/recordView");
    	
        return model;
    }
	
	@RequestMapping( value = "/record/recordEditPage.do")
    public ModelAndView recordEditPage(HttpServletRequest request, HttpServletResponse response) throws Exception{
        
    	ModelAndView model = new ModelAndView();
    	
    	String boardType = request.getParameter("boardType");
    	
    	Map map = new HashMap();
    	
    	if(boardType.equals("upt")) {
    		
    		String rcdSeq = request.getParameter("rcdSeq");
    		map.put("rcdSeq", rcdSeq);
    		model.addObject("detail", recordService.detailRecordList(map));
    	}
    	
    	model.addObject("boardType", boardType);
    	
    	model.addObject("menuCode", request.getParameter("menuCode"));
    	model.addObject("nowPage", request.getParameter("nowPage"));
    	model.addObject("cntPerPage", request.getParameter("cntPerPage"));
    	model.setViewName("record/recordEditPage");
    	
        return model;
    }
	
	@ResponseBody
	@RequestMapping("/record/recordEdit.do")
	public String recordEdit(HttpServletRequest request,HttpSession session) throws Exception  {
	   
	   
	   String rcdRounds = request.getParameter("rcdRounds");
	   String rcdDivision = request.getParameter("rcdDivision");
	   String rcdNumber = request.getParameter("rcdNumber");
	   String rcdPtename = request.getParameter("rcdPtename");
	   String rcdGender = request.getParameter("rcdGender");
	   String rcdAge = request.getParameter("rcdAge");
	   String rcdMaindoctor = request.getParameter("rcdMaindoctor");
	   String rcdHopedoctor = request.getParameter("rcdHopedoctor");
	   String rcdReqdoctor = request.getParameter("rcdReqdoctor");
	   String middleDept = request.getParameter("middleDept");
	   String middleDept2 = request.getParameter("middleDept2");
	   String boardType = request.getParameter("boardType");
	   
	   
	   Map map = new HashMap();
	   
	   map.put("rcdRounds", rcdRounds);
	   map.put("rcdDivision", rcdDivision);
	   map.put("rcdNumber", rcdNumber);
	   map.put("rcdPtename", rcdPtename);
	   map.put("rcdGender", rcdGender);
	   map.put("rcdAge", rcdAge);
	   map.put("rcdMaindoctor", rcdMaindoctor);
	   map.put("rcdHopedoctor", rcdHopedoctor);
	   map.put("rcdReqdoctor", rcdReqdoctor);
	   map.put("rcdHopeclass", middleDept);
	   map.put("rcdReqclass", middleDept2);
	   
	   if(boardType.equals("ins")) {
		  
		   int rcdSeq = recordService.nextRecordSeq();
		   map.put("rcdSeq", rcdSeq);
		   
		   recordService.insertRecord(map);
		   		   
		   request.setAttribute("boardType", boardType);
		   
		   return "sucess";
		   
	   }else if(boardType.equals("upt")){
		  
		   String rcdSeq = request.getParameter("rcdSeq");
		   map.put("rcdSeq", rcdSeq);
		   		   
		   recordService.updateRecord(map);
		   
		   request.setAttribute("boardType", boardType);
		   
		   return "sucess";
		   
	   }else if(boardType.equals("del")){
		  
		   String rcdSeq = request.getParameter("rcdSeq");
		   map.put("rcdSeq", rcdSeq);
		   		   
		   recordService.deleteRecord(map);
		   
		   request.setAttribute("boardType", boardType);
		   
		   return "sucess";
		   
	   } else {
		   return "fail";
	   }
	   
	}
}
