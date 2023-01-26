package com.lec.spring.controller;

import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lec.spring.domain.Lecture;
import com.lec.spring.domain.User;
import com.lec.spring.service.LectureService;
import com.lec.spring.service.UserService;

@Controller
@RequestMapping("/")
public class HomeController {

	LectureService lectureService;
	UserService userService;
	@Autowired
	public void setLectureService(LectureService lectureService) {
		this.lectureService = lectureService;
	} 
	@Autowired
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	@RequestMapping("/home")
	public String center() {
//		lectureService.saveUser();
		
		return "home";
	}
	
	

	@RequestMapping("/upcoming")
	public String upComing() {
		
		return "/Class/upcoming";
	}
	
	@RequestMapping("/requestclass")
	public String requestClass() {
		
		return "/Class/requestclass";
	}
	@RequestMapping("/location")
	public String location() {
		
		return "/Location/location";
	}
	
	//현재 로그인한 (인증된)정보 Authentication 보기 
	@RequestMapping("/auth")
	@ResponseBody	// 보통은 view jsp를 리턴하지만 responsebody는 data를 return한다. 
	// authentication 객체를 리턴한다. session에 authentication이 저장되고 그 안에 userdetails이 이싿.  
	public Authentication auth() {
	       
		Authentication authentication = userService.getAuthentication();
 
		return authentication;
//		return SecurityContextHolder.getContext().getAuthentication();	
	}
//	@RequestMapping("/request")
//	public String lectures() {
//		User user1 = userService.findByUsername("user1");
//		System.out.println(user1.getLectures());	// open-in-view기본값이 true여서 된다. (applications.properties에서)
//		return "home";
//	}
}
