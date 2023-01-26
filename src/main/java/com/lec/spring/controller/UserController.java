package com.lec.spring.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lec.spring.domain.Authority;
import com.lec.spring.domain.Lecture;
import com.lec.spring.domain.User;
import com.lec.spring.service.LectureService;
import com.lec.spring.service.UserService;
import com.lec.spring.util.U;

@Controller
@RequestMapping("/user")
 
public class UserController {

 	UserService userService;
 	LectureService lectureService;
	
 	@Autowired
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	@Autowired
	public void setLectureService(LectureService lectureService) {
		this.lectureService = lectureService;
	}
	@Autowired
	private PasswordEncoder passwordEncoder;	// 회원가입등에서 사용
		//list
		@GetMapping("/info")	// /user/info
		public String userInfo(Model model) {
			List<User> list = new ArrayList<>();
			model.addAttribute("authorities",userService.authorityList());
			model.addAttribute("lectures",lectureService.listLecture());
			model.addAttribute("list", userService.userList());
			return "/User/info";
		}
		
	
		//save
		@PostMapping("/register")	// /user/register (by the manager)
		public String addUser(User user,String prelectures,String userauthorities, Model model) {
			System.out.println(user);
			System.out.println(userauthorities);
			Boolean fact = userService.userValidation(user);
			System.out.println("userValidation 결과 : "+fact);
			if(fact) {
			System.out.println(prelectures.getClass().getName());	//String으로찍힘 
			System.out.println(prelectures);
			List<String> prelecs = userService.stringToList(prelectures);	// 분리가 안되었음. 
			List<String> userauth = userService.stringToList(userauthorities);	// 분리가 안되었음. 
//			System.out.println(prelecs.get(1));
			System.out.println("수강신청아이디는 " + prelecs + "입니다.");
			System.out.println("회원종류아이디는 " + userauth + "입니다.");
//			prelecs.forEach(el -> System.out.println("형변환된 아이디는 " + el));	// 분리가 안되었음. 
//			for(String el : prelecs) {
//				System.out.println("형변환된 아이디는 " + Long.parseLong(el));
//				
//				 
//				}
			 
			List<Lecture> lectures = lectureService.selectLectureByList(prelecs);
			List<Authority> authorities = userService.selectAuthorityByList(userauth);
			System.out.println("선택한 수강과목은 " + lectures+"입니다");
//			Lecture[] longArray = lectureService.transformListToArray(lectures);
//			longArray = lectures.toArray(longArray);
//			user.addLecture(longArray);
//			user.addLecture(lectures);
			 
			int result = userService.saveLecAndAuthAndPass(lectures,authorities,user);
			 
//			user.setLectures(lectures);
//			user.setAuthorities(authorities);
//			user.setPassword(passwordEncoder.encode(user.getPassword()));	// password는 암호화
//			int result = userService.userSave(user);
			if(result==1) {
				System.out.println("위 user는 회원가입이 정상적으로 되었습니다.");
			}else {
				System.out.println("위 user는 회원가입에 실패하였습니다.");
			}
			List list = new ArrayList<>();
			list = userService.userList();
			 
			model.addAttribute("lectures",lectureService.listLecture());
			model.addAttribute("list", list);
			model.addAttribute("authorities",userService.authorityList());
			System.out.println(list);
//			return "/User/info";
			return "/User/admin";
			}else {
				if(user.getUsername()==null || user.getUsername()=="") {
					List list = new ArrayList<>();
					list = userService.userList();
					String warning = "회원아이디를 입력하여주세요";
					model.addAttribute("lectures",lectureService.listLecture());
					model.addAttribute("list", list);
					model.addAttribute("authorities",userService.authorityList());
					model.addAttribute("message", warning);
//					return "/User/info";
					return "/User/admin";
				}else {
					List list = new ArrayList<>();
					list = userService.userList();
					String warning = "회원아이디는 중복되지 말아야 합니다. 회원아이디를 다시 입력하시오!";
					model.addAttribute("lectures",lectureService.listLecture());
					model.addAttribute("list", list);
					model.addAttribute("authorities",userService.authorityList());
					model.addAttribute("message", warning);
//					return "/User/info";
					return "/User/admin";
				}
			}
			 
		}
		@PostMapping("/registerbyuser")	// register by user 
		public String registerOk(User user, Model model) {
			
			//이미 중복된 아이디(username)이 있다면 
			if(userService.isExist(user.getUsername())) {
				// TODO : 뭔가 에러를 내야 할텐데.. 
			}
			// 에러가 있었다면 redirect 한다.
			// TODO 
			
			// 에러가 없었으면 회원등록 진행 
			int cnt = userService.register(user);
			model.addAttribute("result",cnt); 
			return "/User/registerOk";
		}
		
		
		//delete
		@GetMapping("/delete")
		public String userDelete(Long id, Model model) {
			System.out.println("#####&&&&####");
			int result = userService.userDelete(id);
			 
			System.out.println(result);
			model.addAttribute("lectures",lectureService.listLecture());
			model.addAttribute("list",userService.userList());
			model.addAttribute("authorities",userService.authorityList());
//			return "/User/info";
			return "/User/admin";
		}
		//detail
		@GetMapping("/detail")
		public String detail(Long id, Model model) {
			User user = userService.userSelect(id);
			model.addAttribute("user",user);
			return "User/detail";
		}
		@GetMapping("/update")
		public String update(Long id, Model model) {
			System.out.println("#######################");
			User user = userService.userSelect(id);
//			int result = userService.userUpdate(user);
//			System.out.println(id);
			
			model.addAttribute("authorities",userService.authorityList()); 
			model.addAttribute("user",user);
			return "/User/update";
		}
		@PostMapping("/updateOk")
		public String updateOk(Long userid, String userauthorities,Model model) {
//			System.out.println("############!!!!!!!!!!!!");
//			System.out.println(userauthorities);
			User user = userService.userSelect(userid);
			List<String> userauth = userService.stringToList(userauthorities);	// 분리가 안되었음. 
			List<Authority> authorities = userService.selectAuthorityByList(userauth);
			int result = userService.updateLecAndAuthAndPass(user.getLectures(),authorities,user);
			List<User> list = new ArrayList<>();
			model.addAttribute("authorities",userService.authorityList());
			model.addAttribute("lectures",lectureService.listLecture());
			model.addAttribute("list", userService.userList());
			return "/User/admin";
		}
//		//addlecture
//		@GetMapping("/addlecture")
//		public String addLecture(String lecid, Model model) {
//			System.out.println(lecid);
//			return "/User/info";
//		}
		@GetMapping("/login")
		public String login() {
			return "/User/login";
		}
		
		@PostMapping("/login")
		public String loginOk() {
			
			return "/User/login";
		}
		@GetMapping("/register_person")
		public String registerPerson() {
			return "/User/register";
		}
		@RequestMapping("/rejectAuth")
		public String rejectAuth() {
			return "common/rejectAuth";
		}
//		@RequestMapping("/test")
//		public String test() {
//			System.out.println(userService.findByUsername("user1"));
//			System.out.println(userService.findByUsername("user1").getLectures());
//			return "home";
//		}
		@GetMapping("/homework")
		public String homeworkSubmission( ) {
			
			return "/User/homework";
		}
		
		@GetMapping("/admin")
		public String admin(Model model) {
			List<User> list = new ArrayList<>();
			model.addAttribute("authorities",userService.authorityList());
			model.addAttribute("lectures",lectureService.listLecture());
			model.addAttribute("list", userService.userList());
			System.out.println("##########################");
			System.out.println(userService.authorityList());
			System.out.println("##########################");
			System.out.println(lectureService.listLecture());
			System.out.println("##########################");
			System.out.println(userService.userList());
			return "/User/admin";
		}
		 
		 
}
