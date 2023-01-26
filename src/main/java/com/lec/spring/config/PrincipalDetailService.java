package com.lec.spring.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lec.spring.domain.User;
import com.lec.spring.service.LectureService;
import com.lec.spring.service.UserService;
//UserDetailsService
//컨테이너에 등록한다.
//시큐리티 설정에서 loginProcessingUrl(url) 을 설정해 놓았기에
//로그인시 위 url 로 요청이 오면 자동으로 UserDetailsService 타입으로 IoC 되어 있는
//loadUserByUsername() 가 실행되고
//인증성공하면 결과를 UserDetails 로 리턴
//보안에서 principal은 접근주체를 의미 
@Service	// 컨테이너 등록 
//@Transactional
public class PrincipalDetailService implements UserDetailsService{

	 
	UserService userService;
//	LectureService lectureService;
//	@Autowired
//	public void setLectureService(LectureService lectureService) {
//		this.lectureService = lectureService;
//	}
	@Autowired
	public void setUserService(UserService userService) {
		this.userService = userService;
	}


	@Override
	@Transactional	//@Transactional 이 여기에 없으니까 밑에서 user.getLectures()를 실행하지못하더라. lazily initialize lectures. 
					//원천적으로 밑에 findByUsername에서 lecture를 찾지 못하더라. 그래서 여기에 영속성을 유지시켜야한다. 
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

		System.out.println("loadUserByUsername(" + username + ")");
		
		User user = userService.findByUsername(username);	// DB조회 
		System.out.println("loadUserByUsername은 다음과 같다 : "+user.getLectures());
		// @Transactional있으면 위에 호출부분 필수!!
		// 호출안하면 lecture lazy여서 proxy로 principalDetails로 넘어가서 에러생김 
		
		
		
		// 해당 username의 User가 DB에 있다면 
		// UserDetails를 생성하여 리턴 
		if(user != null) {
			PrincipalDetails userDetails = new PrincipalDetails(user);
			userDetails.setUserService(userService);
			return userDetails;
		
		}
		
		// 해당 username의 user가 없다면!
		// UsernameNotFoundException을 throw 해주도록 한다. 
		throw new UsernameNotFoundException(username);
		
		// 여기서 null 리턴하면 예외 발생 
//		return null;
	}

}
