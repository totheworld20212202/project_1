package com.lec.spring.controller;

import java.io.File;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.lec.spring.domain.HomeWork;
import com.lec.spring.domain.Lecture;
import com.lec.spring.domain.User;
import com.lec.spring.service.LectureService;
import com.lec.spring.service.UserService;

@Controller 
@RequestMapping("/")
public class LectureController {

	LectureService lectureService;
	UserService userService;
	
	@Autowired
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	@Autowired
	public void setLectureService(LectureService lectureService) {
		this.lectureService = lectureService;
	}
	 
	//List
	@GetMapping("/atpresent")
	public String atPresent(Model model) {
		model.addAttribute("list",lectureService.listLecture());
		return "/Class/atpresent";
	}
	//save
	@PostMapping("/atpresentpost")
	public String atPresent(Lecture lecture, Model model) {
		
		Integer result = lectureService.saveLecture(lecture);
//		System.out.println(lecture);
		System.out.println(result);
		 
		List<User> list = new ArrayList<>();
		model.addAttribute("authorities",userService.authorityList());
		model.addAttribute("lectures",lectureService.listLecture());
		model.addAttribute("list", userService.userList());
//		return "/Class/atpresent";
		return "/User/admin";
	}
	//delete
	@GetMapping("/delete")
	public String delete(Long id, Model model) {
		int result = lectureService.deleteLecture(id);
		System.out.println(result);
		 
		List<User> list = new ArrayList<>();
		model.addAttribute("authorities",userService.authorityList());
		model.addAttribute("lectures",lectureService.listLecture());
		model.addAttribute("list", userService.userList());
//		return "/Class/atpresent";
		return "/User/admin";
	}
	//detail
	@GetMapping("/detail")
	public String detail(Long id, Model model) {
		Lecture lecture = lectureService.selectLecture(id);
		model.addAttribute("lecture",lecture);
		return "Class/detail";
	}
	//update
	@GetMapping("/update")
	public String update(Long id, Model model) {
		Lecture lecture = lectureService.selectLecture(id);
		model.addAttribute("lecture",lecture);
		System.out.println("????????????????????? "+ lecture + "?????????."); 
		return "/Class/update";
		 
	}
	//updateOk
	@PostMapping("/updateOk")
	public String updateOk(Lecture lecture, Model model) {
		System.out.println(lecture);
		int result = lectureService.updateLecture(lecture);
		if(result == 1) {
			System.out.println(lecture);
			System.out.println("??? ????????? ????????? ?????????????????????.");
		}else {
			System.out.println(lecture);
			System.out.println("??? ????????? ????????? ?????????????????????.");
		}
		List<User> list = new ArrayList<>();
		model.addAttribute("authorities",userService.authorityList());
		 
		model.addAttribute("list", userService.userList()); 
		
		model.addAttribute("lectures",lectureService.listLecture());
		
//		return "/Class/atpresent";
		return "/User/admin";
	}
	@PostMapping("/hwSelected")
	public String hwSelected(int hwSelected, Long userid, String lectureid, Model model) {
			System.out.println("?????????   : "+ hwSelected);
			System.out.println("Lectureid??? : "+ lectureid);
			System.out.println("userid??? : "+ userid);
			long lecid = Long.parseLong(lectureid);
			List<HomeWork> homeworks = lectureService.findHwByHwSelectedAndId( hwSelected, userid);
			model.addAttribute("homeworks",homeworks);
			model.addAttribute("LectureID",lecid);
			System.out.println("homeworks??? "+ homeworks);
		return "/User/homework";
	}
	
	@PostMapping("/hwupload")
	public String hwUpload(long LectureID, long userid, 
			@RequestParam Map<String, MultipartFile> files, 
			Model model
			) {
			System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
		
//			for(Map.Entry<String, MultipartFile> e : files.entrySet()) {
//				System.out.println("????????????????????? : " + e.getKey());
//				System.out.println("????????????????????? : " + e.getValue());
//			}
			lectureService.saveHWSubmittedByStudents(LectureID, userid, files); 
			
			
			return "/User/homework";
	}
	@GetMapping("/hwlistupload")
	public String hwlistupload(){
		
		
		return "/User/hwlistupload"; 
	}
	@PostMapping("/hwlistuplaod")
	public String hwListUpload(int hwSelected, String lectureid, Long userid, Model model) {
			 
			System.out.println("?????????   : "+ hwSelected);
			System.out.println("userid??? : "+ userid);
			System.out.println("lectureid??? : " + lectureid); 
			List<HomeWork> homeworks = lectureService.findHwByHwSelectedAndId(hwSelected, userid);
			model.addAttribute("homeworks",homeworks);
			System.out.println("homeworks??? "+ homeworks);
			model.addAttribute("hwnumber",hwSelected); 
			model.addAttribute("lectureid",lectureid);
		return "/User/hwlistupload"; 
				
	}
	@PostMapping("/newhwupload")
	public String hwListUpload(Model model, String lectureid, int hwSelected, long userid,  
			String name, String content, String deadline) {
			System.out.println("lectureid??? "+lectureid); 
			System.out.println("????????? ????????? : "+ name+","+content+","+deadline);
			System.out.println("??????????????? : "+hwSelected);
			System.out.println("?????????????????? : "+ userid);
			HomeWork homework = lectureService.saveHomeWork(userid,lectureid, hwSelected,name,content,deadline);//lecture_id??? ?????????. 
			System.out.println("?????????: " +homework);
			List<HomeWork> homeworks = lectureService.addHomeWork(homework, userid, hwSelected);
			model.addAttribute("hwnumber",hwSelected); 
			model.addAttribute("lectureid",lectureid); 
			model.addAttribute("homeworks",homeworks);
			System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
			System.out.println("homeworks??? "+ homeworks);
		return "/User/hwlistupload"; 
				
	}
	@PostMapping("/regClass")
	public String regClass(long lectureid, Model model) {
		
		System.out.println("###############");
		System.out.println("lectureid : "+ lectureid  );
		Lecture lecture = lectureService.findById(lectureid);
		model.addAttribute("lecture", lecture );
		
		return "/Class/regClass";
	}
 
	@PostMapping("/regClassOk")
	public String regClassOk(long lectureid, Model model) {
		
		//TODO
		return "/Class/regClass";
	}
	@PostMapping("/payment")
	public String payment(long userid, long lectureid, Model model) {
		model.addAttribute("lectureid", lectureid);
		model.addAttribute("userid", userid);
		return "/User/payment";
	}
	@PostMapping("/paymentOk")
	public String paymentOk(long userid, long lectureid, Model model) {
		// payment in action 
		// record the personal data in db
		//TODO
		System.out.println("userid : "+ userid + " lectureid : " + lectureid);
		User user = lectureService.regClass(userid, lectureid);
		model.addAttribute("userid",user.getId());
		model.addAttribute("lectureid",lectureid); 
		return "/User/paymentOk";
	}
	@GetMapping("/mcq")
	public String homeworkMcq() {
		return "/Class/homework_mcq";
	}
	
	 
	@GetMapping("/hwBySubject")
	public String hwBySubject(long lid, Model model) {
		System.out.println("lecture id??? " + lid);
		//System.out.println("user id??? " + uid);
		Lecture lecture = lectureService.findById(lid);
		List<HomeWork> homeworks = lectureService.findListOfHomeworksByLectureId(lid);
		System.out.println("????????? homeworks??? " + homeworks);
		model.addAttribute("lid_homeworks", homeworks);
		model.addAttribute("lec_name", lecture.getSubject());
		model.addAttribute("lec_id", lecture.getId());
		return "/User/hwlistupload"; 
	}
	
	@GetMapping("/usersByHwAndLec")
	public String usersByHwAndLec(long hid, long lid, long uid, Model model) {
		System.out.println("homework id??? : " + hid);
		System.out.println("lecture id??? : " + lid);
//		System.out.println("user id??? : " + uid);
//		User user = userService.findById(uid);
		Lecture lecture = lectureService.findById(lid);
		HomeWork homework = lectureService.findHomeWorkById(hid);
		List<HomeWork> homeworks = lectureService.findListOfHomeworksByLectureId(lid);
		//System.out.println("????????? homeworks??? " + homeworks);
		List<User> users = lecture.getUsers();
		// Check whether homeworks have been submitted by students taking this class 
		List<Boolean> isSubmit = lectureService.getListOfSubmits(users, lid, hid);
		List<File> listOfPaths = lectureService.getListOfPaths(users,lid,hid);
		System.out.println("????????? ????????? : " + lecture);
		System.out.println("????????? ????????? : " + homework);
		System.out.println("???????????? ???????????? : " + users);
		model.addAttribute("usersByLecture", users); 
		model.addAttribute("lid_homeworks", homeworks);
		model.addAttribute("lec_name", lecture.getSubject());
		model.addAttribute("lec_id", lecture.getId());
		model.addAttribute("hw_name", homework.getName());
		model.addAttribute("isSubmit", isSubmit);
		model.addAttribute("listOfPaths", listOfPaths);
		System.out.println("%%%%"+listOfPaths);
		return "/User/hwlistupload"; 
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
