package com.his.hisSystem;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.his.hisSystem.service.BoardService;
import com.his.hisSystem.service.IstService;
import com.his.hisSystem.service.PstService;
import com.his.hisSystem.service.RecordService;
import com.his.hisSystem.service.UserDto;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Inject
    private BoardService boardService;
	
	@Inject
	private PstService pstService;
	
	@Inject
	private IstService istService;
	
	@Inject
	private RecordService recordService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		return "home";
	}
	
	@RequestMapping(value = "/main.do")
	public ModelAndView main(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception {
		
		ModelAndView model = new ModelAndView();
		Map map = new HashMap();
			
		model.addObject("userInfo", session.getAttribute("userInfo"));
		UserDto userDto = (UserDto)session.getAttribute("userInfo");
		SimpleDateFormat sdf= new SimpleDateFormat("HH:mm:ss");
		
		model.addObject("accessTime", sdf.format(session.getCreationTime()));
		model.addObject("mainBoardList", boardService.mainBoardList(map));
		model.addObject("mainBoardCnt", boardService.mainBoardList(map).size());
		
		map.put("istWriter", userDto.getUserSeq());
		map.put("pstWriter", userDto.getUserSeq());
		
		model.addObject("mainPstList", pstService.mainPstList(map));
		model.addObject("mainPstCnt", pstService.mainPstList(map).size());
		model.addObject("mainIstList", istService.mainIstList(map));
		model.addObject("mainIstCnt", istService.mainIstList(map).size());
		model.addObject("mainRecordList", recordService.mainRecordList(map));
		model.addObject("mainRecordCnt", recordService.mainRecordList(map).size());
		
		model.setViewName("main");
		
		return model;
	}
	
}
