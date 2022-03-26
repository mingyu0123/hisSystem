package com.his.hisSystem.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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
import com.his.hisSystem.service.CodeService;
import com.his.hisSystem.service.FileService;
import com.his.hisSystem.service.LoginService;
import com.his.hisSystem.service.UserDto;
import com.his.hisSystem.service.UserService;
import com.his.hisSystem.util.PagingVO;
import com.his.hisSystem.util.FileUtils;
import com.his.hisSystem.util.FileVO;

@Controller
public class UserController {

	@Inject
    private UserService userService;
		
	@Inject
    private CodeService codeService;
	
	@Inject
	private LoginService loginService;
	
	@RequestMapping( value = "/user/userList.do")
    public ModelAndView userList(@RequestParam(value="nowPage",required = false)String nowPage,@RequestParam(value="cntPerPage",required = false)String cntPerPage,HttpServletRequest request, HttpServletResponse response) throws Exception{
        
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
    	model.setViewName("user/userList");
    	
        return model;
    }
	
	@RequestMapping( value = "/user/userListPage.do")
    public ModelAndView userListPage(PagingVO vo,@RequestParam(value="nowPage",required = false)String nowPage,@RequestParam(value="cntPerPage",required = false)String cntPerPage,HttpServletRequest request, HttpServletResponse response) throws Exception{
        
    	ModelAndView model = new ModelAndView();
    	
    	String searchType = request.getParameter("searchType");
    	String searchValue = request.getParameter("searchValue");
    	String classVal = request.getParameter("classVal");
    	
    	Map map = new HashMap();
    	Map map2 = new HashMap();
    	Map map3 = new HashMap();
    	Map map4 = new HashMap();
    	Map map5 = new HashMap();
    	
    	map.put("searchType", searchType);
    	map.put("searchValue", searchValue);
    	
    	int total = userService.countUser(map);
    	
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
    	
    	List<UserDto> userList = userService.selectUserList(map);
    	
    	model.addObject("searchType", searchType);
    	model.addObject("searchValue", searchValue);
    	
    	model.addObject("list", userList);
    	model.addObject("totalCnt",total);
    	
    	map2.put("codeCategory", "large");
    	map2.put("codeType", "position");
    	
    	model.addObject("postionCodeList", codeService.codeList(map2));
    	
    	map3.put("codeCategory", "large");
    	map3.put("codeType", "auth");
    	
    	model.addObject("authCodeList", codeService.codeList(map3));
    	
    	map4.put("codeCategory", "large");
    	map4.put("codeType", "dept");
    	
    	model.addObject("deptCodeList", codeService.codeList(map4));
    	
    	if(searchType != null && searchType.equals("userDept")) {
    		map5.put("codeCategory", "middle");
    		map5.put("codeType", "dept");
    		map5.put("codeUpper", classVal);
    		
    		model.addObject("classVal", classVal);
    		model.addObject("midDeptCodeList", codeService.codeList(map5)); 
    	}
    	
    	model.setViewName("user/userListPage");
    	
        return model;
    }
	
	@RequestMapping( value = "/user/userView.do")
    public ModelAndView userView(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception{
        
    	ModelAndView model = new ModelAndView();
    	
    	Map map = new HashMap();
    	
    	int userSeq = Integer.parseInt(request.getParameter("userSeq"));
    	
    	map.put("userSeq", userSeq);
    	    	
    	model.addObject("detail", userService.detailUserList(map));
    	model.addObject("menuCode", request.getParameter("menuCode"));
    	model.addObject("nowPage", request.getParameter("nowPage"));
    	model.addObject("cntPerPage", request.getParameter("cntPerPage"));
    	model.addObject("infoCode", request.getParameter("infoCode"));
    	model.addObject("userInfo", session.getAttribute("userInfo"));
    	model.setViewName("user/userView");
    	
        return model;
    }
	
	@RequestMapping( value = "/user/userEditPage.do")
    public ModelAndView userEditPage(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception{
        
    	ModelAndView model = new ModelAndView();
    	
    	Map map = new HashMap();
    	Map map2 = new HashMap();
    	Map map3 = new HashMap();
    	Map map4 = new HashMap();
    	
    	String boardType = request.getParameter("boardType");
    	
    	if(boardType.equals("upt")) {
    		
    		int userSeq = Integer.parseInt(request.getParameter("userSeq"));
    		map.put("userSeq", userSeq);
        	model.addObject("detail", userService.detailUserList(map));
    	}
    	
    	model.addObject("boardType", boardType);
    	
    	map2.put("codeCategory", "large");
    	map2.put("codeType", "position");
    	
    	model.addObject("postionCodeList", codeService.codeList(map2));
    	
    	map3.put("codeCategory", "large");
    	map3.put("codeType", "auth");
    	
    	model.addObject("authCodeList", codeService.codeList(map3));
    	
    	map4.put("codeCategory", "large");
    	map4.put("codeType", "dept");
    	
    	model.addObject("deptCodeList", codeService.codeList(map4));
    	
    	model.addObject("menuCode", request.getParameter("menuCode"));
    	model.addObject("nowPage", request.getParameter("nowPage"));
    	model.addObject("cntPerPage", request.getParameter("cntPerPage"));
    	model.setViewName("user/userEditPage");
    	
        return model;
    }
	
	@ResponseBody
	@RequestMapping("/user/userEdit.do")
	public String userEdit(HttpServletRequest request,HttpSession session) throws Exception  {
	   
	   
	   String userId = request.getParameter("userId");
	   String userPassword = request.getParameter("userPassword");
	   String userName = request.getParameter("userName");
	   String userClass = request.getParameter("mainDept");
	   String userDept = request.getParameter("middleDept");
	   String userPosition = request.getParameter("userPosition");
	   String userAuth = request.getParameter("userAuth");
	   String boardType = request.getParameter("boardType");
	   String userWriter = request.getParameter("userWriter");
	   
	   BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
	   
	   Map map = new HashMap();
	   Map map2 = new HashMap();
	   
	   map.put("userId", userId);
	   
	   map.put("userName", userName);
	   map.put("userClass", userClass);
	   map.put("userDept", userDept);
	   map.put("userPosition", userPosition);
	   map.put("userAuth", userAuth);
	   map.put("userWriter", userWriter);
	   
	   if(boardType.equals("ins")) {
		  
		   int userSeq = userService.nextUserSeq();
		   map.put("userSeq", userSeq);
		   map.put("userPassword", encoder.encode(userPassword));
		   
		   userService.insertUser(map);
		   		   
		   request.setAttribute("boardType", boardType);
		   
		   return "sucess";
		   
	   }else if(boardType.equals("upt")){
		  
		   int userSeq = Integer.parseInt(request.getParameter("userSeq"));
		   map.put("userSeq", userSeq);
		   		   
		   userService.updateUser(map);
		   
		   request.setAttribute("boardType", boardType);
		   
		   return "sucess";
		   
	   } else {
		   return "fail";
	   }
	   
	}
	
	@ResponseBody
	@RequestMapping("/user/deleteUser.do")
	public String deleteUser(HttpServletRequest request,HttpSession session) throws Exception  {
	   
		   Map map = new HashMap();
		
		   int userSeq = Integer.parseInt(request.getParameter("userSeq"));
		   map.put("userSeq", userSeq);
		   		   
		   userService.deleteUser(map);
		   
		   return "sucess";
	   
	}
	
	@RequestMapping( value = "/user/userPwdChgPage.do")
    public ModelAndView userPwdChgPage(HttpServletRequest request, HttpServletResponse response) throws Exception{
        
    	ModelAndView model = new ModelAndView();
    	int userSeq = Integer.parseInt(request.getParameter("userSeq"));
    	
    	Map map = new HashMap();
    	map.put("userSeq", userSeq);
    	
    	model.addObject("detail", userService.detailUserList(map));
    	model.addObject("menuCode", request.getParameter("menuCode"));
    	model.addObject("nowPage", request.getParameter("nowPage"));
    	model.addObject("cntPerPage", request.getParameter("cntPerPage"));
    	model.addObject("pageType", request.getParameter("pageType"));
    	
    	model.setViewName("user/userPwdChgPage");
    	
        return model;
    }
	
	@ResponseBody
	@RequestMapping("/user/userPwdChk.do")
	public String userPwdChk(HttpServletRequest request,HttpSession session) throws Exception  {
	   
		   Map map = new HashMap();
		
		   BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		   
		   int userSeq = Integer.parseInt(request.getParameter("userSeq"));
		   String agoPwd = request.getParameter("agoPwd");
		   
		   map.put("userSeq", userSeq);
		   
		   UserDto userDto = userService.detailUserList(map);
		   
		   if(encoder.matches(agoPwd, userDto.getUserPassword())) {
			   
			   return "sucess";
		   }else {
			  
			   return "fail";
		   }
		   
			/*
			 * int pwdChk = userService.userPwdChk(map);
			 * 
			 * if(pwdChk > 0) { return "sucess"; }else { return "fail"; }
			 */
		   
	}
	
	@ResponseBody
	@RequestMapping("/user/userPwdChgAction.do")
	public String userPwdChgAction(HttpServletRequest request,HttpSession session) throws Exception  {
	   
		   Map map = new HashMap();
		
		   String userId = request.getParameter("userId");
		   String agoPwd = request.getParameter("agoPwd");
		   String newPwd = request.getParameter("newPwd");
		   
		   BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		   
		   map.put("userId", userId);
		   map.put("agoPwd", agoPwd);
		   map.put("newPwd", encoder.encode(newPwd));
		   		   
		   userService.userPwdChg(map);
		   
		   return "sucess";
	}
	
	@RequestMapping( value = "/user/loginPwdChgPage.do")
    public ModelAndView loginPwdChgPage(HttpServletRequest request, HttpServletResponse response) throws Exception{
        
    	ModelAndView model = new ModelAndView();
    	
    	model.addObject("pageType", request.getParameter("pageType"));
    	
    	model.setViewName("loginPwdChgPage");
    	
        return model;
    }
	
	@ResponseBody
	@RequestMapping("/user/loginPwdChk.do")
	public String loginPwdChk(HttpServletRequest request,HttpSession session) throws Exception  {
	   
		   Map map = new HashMap();
		
		   BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		   
		   String userId = request.getParameter("userId");
		   String agoPwd = request.getParameter("agoPwd");
		   String pageType = request.getParameter("pageType");	
		   		   
		   map.put("userId", userId);
		   
		   UserDto userDto = loginService.loginUserInfo(map);
		   
		   if(encoder.matches(agoPwd, userDto.getUserPassword())) {
			   
			   return "sucess";
		   }else {
			   
			   return "fail";
		   }
		   
	}
	
	@ResponseBody
	@RequestMapping("/user/loginPwdChgAction.do")
	public String loginPwdChgAction(HttpServletRequest request,HttpSession session) throws Exception  {
	   
		   Map map = new HashMap();
		
		   String userId = request.getParameter("userId");
		   String agoPwd = request.getParameter("agoPwd");
		   String newPwd = request.getParameter("newPwd");
		   
		   BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		   
		   map.put("userId", userId);
		   map.put("agoPwd", agoPwd);
		   map.put("newPwd", encoder.encode(newPwd));
		   
		   UserDto userDto = loginService.loginUserInfo(map);
		   
		   if(encoder.matches(agoPwd, userDto.getUserPassword())) {
			   
			   userService.userPwdChg(map);
			   
			   return "sucess";
		   }else {
			   
			   return "fail";
		   }
	}
	
	@ResponseBody
	@RequestMapping("/user/userIdChk.do")
	public String userIdChk(HttpServletRequest request,HttpSession session) throws Exception  {
	   
		   Map map = new HashMap();
		
		   String userId = request.getParameter("userId");
		   		   
		   map.put("userId", userId);
		   
		   int idChk = userService.userIdChk(map);
		   
		   if(idChk > 0) {
			   return "sucess";
		   }else {
			   return "fail";
		   }
	}
	
	@RequestMapping( value = "/user/userSearchPage.do")
    public ModelAndView userSearchPage(@RequestParam(value="nowPage",required = false)String nowPage,@RequestParam(value="cntPerPage",required = false)String cntPerPage,HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception{
        
    	ModelAndView model = new ModelAndView();
    	
    	Map map = new HashMap();
    	    	    	
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
    	model.addObject("type", request.getParameter("type"));
    	model.setViewName("user/userSearchPage");
    	
        return model;
    }
	
	@RequestMapping( value = "/user/userSearchListPage.do")
    public ModelAndView userSearchListPage(PagingVO vo,@RequestParam(value="nowPage",required = false)String nowPage,@RequestParam(value="cntPerPage",required = false)String cntPerPage,HttpServletRequest request, HttpServletResponse response) throws Exception{
        
    	ModelAndView model = new ModelAndView();
    	
    	String searchType = request.getParameter("searchType");
    	String searchValue = request.getParameter("searchValue");
    	String classVal = request.getParameter("classVal");
    	String type = request.getParameter("type");
    	
    	Map map = new HashMap();
    	Map map2 = new HashMap();
    	Map map3 = new HashMap();
    	Map map4 = new HashMap();
    	Map map5 = new HashMap();
    	
    	map.put("searchType", searchType);
    	map.put("searchValue", searchValue);
    	map.put("type", type);
    	int total = userService.countUser(map);
    	
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
    	
    	List<UserDto> userList = userService.selectUserList(map);
    	
    	model.addObject("searchType", searchType);
    	model.addObject("searchValue", searchValue);
    	
    	model.addObject("list", userList);
    	model.addObject("totalCnt",total);
    	
    	map2.put("codeCategory", "large");
    	map2.put("codeType", "position");
    	
    	model.addObject("postionCodeList", codeService.codeList(map2));
    	
    	map3.put("codeCategory", "large");
    	map3.put("codeType", "auth");
    	
    	model.addObject("authCodeList", codeService.codeList(map3));
    	
    	map4.put("codeCategory", "large");
    	map4.put("codeType", "dept");
    	
    	model.addObject("deptCodeList", codeService.codeList(map4));
    	
    	if(searchType != null && searchType.equals("userDept")) {
    		map5.put("codeCategory", "middle");
    		map5.put("codeType", "dept");
    		map5.put("codeUpper", classVal);
    		
    		model.addObject("classVal", classVal);
    		model.addObject("midDeptCodeList", codeService.codeList(map5)); 
    	}
    	
    	model.setViewName("user/userSearchListPage");
    	
        return model;
    }
	
}
