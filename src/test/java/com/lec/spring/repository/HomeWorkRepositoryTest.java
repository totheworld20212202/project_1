package com.lec.spring.repository;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import com.lec.spring.domain.HomeWork;
import com.lec.spring.domain.Lecture;
import com.lec.spring.domain.User;
import com.lec.spring.domain.Write;
import com.lec.spring.service.LectureService;
import com.lec.spring.service.UserService;

@SpringBootTest
class HomeWorkRepositoryTest {

	LectureService lectureService;
	UserService userService;
	HomeWorkRepository homeWorkRepository; 
	@Autowired
	public void setHomeWorkRepository(HomeWorkRepository homeWorkRepository) {
		this.homeWorkRepository = homeWorkRepository;
	}


	@Autowired
	public void setUserService(UserService userService) {
		this.userService = userService;
	}


	@Autowired
	public void setLectureService(LectureService lectureService) {
		this.lectureService = lectureService;
	}
	

//	@Test
	@Transactional
	void HomeWorkSavetest() {
//		User user1 = userService.findById((long)7);
//		System.out.println("user1은" +user1);
//		Lecture lecture1 = Lecture.builder()
//				.subject("물리학1")
//				.textbook("완자")
//				.startdate("3월4일")
//				.enddate("9월6일")
//				.teacher("저자")
//				.build();
//		lectureService.saveLecture(lecture1);
//		
//		HomeWork homework1 = HomeWork.builder()
//				.lecture(lecture1.getId())
//				.name("FirstAssign")
//				.content("odd numbers")
//				.deadline("3월19일")
//				.build();
//		System.out.println("Homework은 다음과 같다 : " + homework1);
//		int result = lectureService.saveHomeWorks(homework1);
//		System.out.println("숙제저장결과는 다음과 같습니다 : " + result);
//		lecture1.addHomeWork(homework1);
//		//lecture1.addUser(null);
//		lectureService.saveLecture(lecture1); 
//		lecture1.addUser(user1); 
//		System.out.println("수업1에 저장된 숙제는 : " +lecture1.getHomeworks());  
//		System.out.println("수업1을 수강하는 학생들은 : " +lecture1.getUsers());  
//		System.out.println("회원1이 수강하는 강의는 : " +user1.getLectures());   
		
		
//		Lecture lecture2 = lectureService.findById((long)1);
//		System.out.println("lecture2id는 다음과 같다. : "+lecture2.getId());
//		HomeWork homework2 = HomeWork.builder()
//				.name("FirstAssign")
//				.content("odd numbers")
//				.deadline("3월30일")
//				.lecture(lecture2.getId())	// lecture2.getId()가 이상하게 저장됨. 
//				.build();
//		System.out.println("homework2는 다음과 같다 : "+homework2);
//		lectureService.saveHomeWorks(homework2);	// save가 안됨. 
//		lecture2.addHomeWork(homework2);
//		lectureService.saveLecture(lecture2); 
//		System.out.println("수업2에 저장된 숙제는 : " +lecture2.getHomeworks());  
//		User user1 = userService.findById((long)7);
//		user1.addLecture(lecture2);
//		userService.userSave(user1); 
//		System.out.println("user1정보 : "+ user1.getLectures().get(0).getHomeworks());
		HomeWork homework3 = HomeWork.builder()
				.name("SecondAssign")
				.content("even numbers")
				.deadline("3월31일")
				.lecture((long)1)	// lecture2.getId()가 이상하게 저장됨. 
				.build();
		lectureService.saveHomeWorks(homework3);
		
	}
	
	
	
	
	
	
	
	
	
	@Transactional
//	@Test					//위에 test는 dbeaver에 저장이 안되었는데 밑에다가 다시 testcase만드니까 저장이되더라. transactional있을때 너무 많이 시도하면 문제가 생기는것 같다. 
	void test2() {
		Lecture lecture3 = lectureService.findById((long)2);
		System.out.println("lecture2id는 다음과 같다. : "+lecture3.getId());
		HomeWork homework3 = HomeWork.builder()
				.name("3번째숙제")
				.content("짝수번")
				.deadline("4월25일")
				.lecture(lecture3.getId())	// lecture2.getId()가 이상하게 저장됨. 
				.build();
		System.out.println("homework2는 다음과 같다 : "+homework3);
		lectureService.saveHomeWorks(homework3);	// save가 안됨. 
		lecture3.addHomeWork(homework3);
		lectureService.saveLecture(lecture3); 
		System.out.println("수업2에 저장된 숙제는 : " +lecture3.getHomeworks());  
		User user4 = userService.findById((long)12);
		user4.addLecture(lecture3);
		userService.userSave(user4); 
		System.out.println("user1정보 : "+ user4.getLectures().get(0).getHomeworks());
//		Lecture lecture2 = lectureService.findById((long)1);
//		System.out.println("lecture2id는 다음과 같다. : "+lecture2.getId());
//		HomeWork homework2 = HomeWork.builder()
//				.name("FirstAssign")
//				.content("odd numbers")
//				.deadline("3월30일")
//				.lecture(lecture2.getId())	// lecture2.getId()가 이상하게 저장됨. 
//				.build();
//		System.out.println("homework2는 다음과 같다 : "+homework2);
//		lectureService.saveHomeWorks(homework2);	// save가 안됨. 
//		lecture2.addHomeWork(homework2);
//		lectureService.saveLecture(lecture2); 
//		System.out.println("수업2에 저장된 숙제는 : " +lecture2.getHomeworks());  
//		User user1 = userService.findById((long)7);
//		user1.addLecture(lecture2);
//		userService.userSave(user1); 
//		System.out.println("user1정보 : "+ user1.getLectures().get(0).getHomeworks());
		
		
	}
	 
	@Test
	@Transactional
	void test3() {	//위에 test는 dbeaver에 저장이 안되었는데 밑에다가 다시 testcase만드니까 저장이되더라. transactional있을때 너무 많이 시도하면 문제가 생기는것 같다. 
					// test3를 컴파일 해주어야한다. 	
		Lecture lecture3 = lectureService.findById((long)2);
		System.out.println("lecture2id는 다음과 같다. : "+lecture3.getId());
		HomeWork homework3 = HomeWork.builder()
				.name("3번째숙제")
				.content("짝수번")
				.deadline("4월25일")
				.lecture(lecture3.getId())	// lecture2.getId()가 이상하게 저장됨. 
				.build();
		System.out.println("homework2는 다음과 같다 : "+homework3);
		lectureService.saveHomeWorks(homework3);	// save가 안됨. 
		lecture3.addHomeWork(homework3);
		lectureService.saveLecture(lecture3); 
		System.out.println("수업2에 저장된 숙제는 : " +lecture3.getHomeworks());  
		User user4 = userService.findById((long)12);
		user4.addLecture(lecture3);
		userService.userSave(user4); 
		System.out.println("user1정보 : "+ user4.getLectures().get(0).getHomeworks());
		
	}
}
