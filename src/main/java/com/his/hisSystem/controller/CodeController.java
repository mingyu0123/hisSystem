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

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.his.hisSystem.service.BoardService;
import com.his.hisSystem.service.CodeService;
import com.his.hisSystem.service.LoginService;


@Controller
public class CodeController {

	@Inject
    private CodeService codeService;
	
	@RequestMapping( value = "/code/codeList.do")
    public ModelAndView codeList(HttpServletRequest request, HttpServletResponse response) throws Exception{
        
    	ModelAndView model = new ModelAndView();
    	
    	model.setViewName("/code/codeList");
    	
        return model;
    }
	
	@ResponseBody
	@RequestMapping("/code/codeType.do")
	public Map codeType(HttpServletRequest request,HttpSession session) throws Exception  {
	   
	   String codeType = request.getParameter("codeType");
	   String codeUpper = request.getParameter("codeUpper");
	   String codeCategory = request.getParameter("codeCategory");
	   
	   Map map = new HashMap();
	   Map map2 = new HashMap();
	   
	   map.put("codeType", codeType);
	   map.put("codeUpper", codeUpper);
	   map.put("codeCategory", codeCategory);
	   
	   List codeList = codeService.codeList(map);
	   
	   map2.put("codeList", codeList);
	   
	   return map2;
	}
}
