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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.his.hisSystem.service.BoardService;
import com.his.hisSystem.service.IstService;
import com.his.hisSystem.service.LoginService;
import com.his.hisSystem.service.UserDto;
import com.his.hisSystem.service.UserService;


@Controller
public class LoginController {

	@Inject
    private LoginService loginService;
	
	@Inject
    private UserService userService;
	
	@Inject
    private IstService istService;
	
	@RequestMapping( value = "/login.do")
    public ModelAndView login(HttpServletRequest request, HttpServletResponse response) throws Exception{
        
    	ModelAndView model = new ModelAndView();
    	
    	model.setViewName("login");
    	
        return model;
    }
	
	@ResponseBody
	@RequestMapping("/login/loginAction.do")
	public String loginAction(HttpServletRequest request,HttpSession session) throws Exception  {
	   
	   String userId = request.getParameter("userId");
	   String userPwd = request.getParameter("userPwd");
	   
	   Map map = new HashMap();
	   
	   map.put("userId", userId);
	   map.put("userPwd", userPwd);
	   
	   BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
	   
	   UserDto userDto = loginService.loginUserInfo(map);
	   	   
	   if(encoder.matches(userPwd, userDto.getUserPassword())) {
		   
		   session.setAttribute("userInfo", loginService.loginUserInfo(map));
		   
		   SimpleDateFormat sdf= new SimpleDateFormat("HH:mm:ss");
		   
		   session.setAttribute("accessTime", sdf.format(session.getCreationTime()));
		   
		   map.put("istRecipient", userDto.getUserSeq());
		   session.setAttribute("recipientCnt",  istService.recipientCnt(map));
		  
		   
		   return "sucess";
		   
			/*
			 * int logChk = loginService.loginCheck(map);
			 * 
			 * if(logChk > 0) { System.out.println("333333333333");
			 * session.setAttribute("userInfo", loginService.loginUserInfo(map));
			 * 
			 * SimpleDateFormat sdf= new SimpleDateFormat("HH:mm:ss");
			 * 
			 * session.setAttribute("accessTime", sdf.format(session.getCreationTime()));
			 * 
			 * return "sucess"; }else { System.out.println("444444444444"); return "fail"; }
			 */
		   
	   }else {
		   return "fail";
		   
	   }
	   
	}
	
	@RequestMapping( value = "/login/logout.do")
    public ModelAndView logout(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception{
        
    	ModelAndView model = new ModelAndView();
    	
    	session.invalidate();
    	
    	model.setViewName("login");
    	
        return model;
    }
}
