package com.lec.spring.domain;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.Column;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.lec.spring.repository.AuthorityRepository;
import com.lec.spring.repository.LectureRepository;
import com.lec.spring.repository.UserRepository;

@SpringBootTest	// container로 등록되려면 이 어노테이션 필요
class UserTest {

	@Autowired
	private UserRepository userRepository; 
	
	@Autowired
	private LectureRepository lectureRepository;
	
	@Autowired
	private AuthorityRepository authorityRepository;
//	@Autowired
//	public void setUserRepository(UserRepository userRepository) {
//		this.userRepository = userRepository;
//	}
//	@Autowired
//	public void setLectureRepository(LectureRepository lectureRepository) {
//		this.lectureRepository = lectureRepository;
//	}
	@Test
	void authoritytest() {
		Authority auth_member = Authority.builder()
				.name("ROLE_MEMBER")
				.build();
		Authority auth_admin = Authority.builder()
				.name("ROLE_ADMIN")
				.build();
		auth_member = authorityRepository.saveAndFlush(auth_member);
		auth_admin = authorityRepository.saveAndFlush(auth_admin);
	}
//	@Test
	void usertest() {
		System.out.println("Hello");
		Authority auth_member = Authority.builder()
				.name("ROLE_MEMBER")
				.build();
		Authority auth_admin = Authority.builder()
				.name("ROLE_ADMIN")
				.build();
		authorityRepository.saveAndFlush(auth_member);
		authorityRepository.saveAndFlush(auth_admin);
//		auth_member = authorityRepository.saveAndFlush(auth_member);
//		auth_admin = authorityRepository.saveAndFlush(auth_admin);
//		authorityRepository.findAll().forEach(System.out::println);
		
		
// User 생성
		User user1 = User.builder()
				.username("USER1")
				.password("1234")	//나중에 Security 적용하면 PasswordEncoder사용해야함. 
//				.password(passwordEncoder.encode("1234"))
				.name("회원1")
				.build(); 
		
		User user2 = User.builder()
				.username("USER2")
				.password("1234")
				.name("회원2")
				.build();
		
		User admin1 = User.builder()
				.username("ADMIN1")
				.password("1234")
				.name("관리자1")
				.build();
		userRepository.findAll().forEach(System.out::println);
		 
//		user10 = userRepository.save(user10);	// @SpringBootTest	 container로 등록되려면 이 어노테이션 상단에 필요
		
		user1.addAuthority(auth_member);
		admin1.addAuthority(auth_member,auth_admin);
		user1 = userRepository.save(user1);
		user2 = userRepository.save(user2);
		admin1 = userRepository.save(admin1);
		
		userRepository.findAll().forEach(System.out::println);	// user lecture는 양쪽에서 manytomany를 해서 table에 foreign key안생기는것같음 
		
		
	}
//	private long id; 			// PK
//	@Column(unique = true, nullable = false)
//	private String username; 	// 회원아이디
//	@Column(nullable = false)
//	private String password;	// 비밀번호
//	@Column(nullable = false)
//	private String name; 		// 회원이름 
//	private UserType userType;		// 회원종류 : 학생 or 학부모 
	
}
