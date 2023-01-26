package com.lec.spring.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lec.spring.domain.Authority;
import com.lec.spring.domain.Lecture;
import com.lec.spring.domain.User;
import com.lec.spring.domain.Write;
import com.lec.spring.repository.AuthorityRepository;
import com.lec.spring.repository.LectureRepository;
import com.lec.spring.repository.UserRepository;
import com.lec.spring.repository.WriteRepository;
import com.lec.spring.util.U;
 
@Service
public class UserService {

	UserRepository userRepository;
	AuthorityRepository authorityRepository;
	LectureRepository lectureRepository;
	WriteRepository writeRepository;
	//LectureService lectureService;
	 
//	@Autowired
//	public void setLectureService(LectureService lectureService) {
//		this.lectureService = lectureService;
//	}
	
	
	@Autowired
	public void setUserRepository(UserRepository userRepository) {
		this.userRepository = userRepository;
	}
	@Autowired
	public void setWriteRepository(WriteRepository writeRepository) {
		this.writeRepository = writeRepository;
	}
	@Autowired
	public void setLectureRepository(LectureRepository lectureRepository) {
		this.lectureRepository = lectureRepository;
	}
	@Autowired
	public void setAuthority(AuthorityRepository authorityRepository) {
		this.authorityRepository = authorityRepository;
	}
	@Autowired
	private PasswordEncoder passwordEncoder;	// 회원가입등에서 사용
	
	public List<User> userList() {
		List<User> list = new ArrayList<>();
		List<User> updatedlist = new ArrayList<>();
		list = userRepository.findAll();
		if(list==null) {
			return list;
		}else {
		for(User e:list) {
//			System.out.println(list);
//			System.out.println(e.getStatus());
			// 처음에 데이타 다 없애면 e.getStatus가 없어서 에러가생김
			if(e==null) {
				return list;
			}else {
			if(e.getStatus()) {	//e.getStatus()!=true null-pointer exception
				 
				updatedlist.add(e);
			}
			}
			
		}
		 
//		return updatedlist;
		return list;
		}
	}
	 
	public int userSave(User user) {
		if(user !=null) {
			userRepository.save(user);
//			System.out.println("@@@@@@@@@@@@@@");
//			System.out.println(user.getLectures().get(0).getHomeworks());
//			System.out.println(user.getId());
			return 1;
		}else {
			return 0;
		}
		 
	}

	public int userDelete(Long id) {
		User user = userRepository.findById(id).orElse(null);
		if(user != null) {
//			userRepository.delete(user);
			user.setStatus(false);
			List<Lecture> list= user.getLectures();
			 
			for(Lecture e : list) {
				System.out.println("###!!!###!!!");
				System.out.println(e.getUsers()); 
				e.getUsers().remove(user);
				lectureRepository.save(e);
				 
			}
			 
			 
			user.setLectures(null);	 
			user.setAuthorities(null);
				List<Write> writes= writeRepository.findAll();
				for(Write u : writes) {
					if(u.getUser() == user) {
						u.setUser(null);
						writeRepository.save(u);
						writeRepository.delete(u);// 이옵션을주면 관련질문게시판의 글삭제, 
					}										
				}
			userRepository.save(user);
			userRepository.delete(user);
			return 1;
		}else {
			
			return 0; 
		}
	}
	public User userSelect(Long id) {
		User user = userRepository.findById(id).orElse(null);
		return user;
	}

	public List<String> stringToList(String prelectures) {
		List<String> list = new ArrayList<>();
		if(prelectures != null && prelectures.length()!=0) {
			list = Arrays.asList(prelectures.split(","));
			return  list;
		}else {
			list = null;
			return null;
		}
		 
		 
		
		 
	}

	public Boolean userValidation(User user) {
		
//		if(user.getUsername()==null) {
//			return false;
//		}
		System.out.println("username은 다음과 같습니다." + user.getUsername());
		System.out.println(userRepository.findByusername(user.getUsername()));
		//System.out.println(userRepository.findByusername(user.getUse
		if(!userRepository.findByusername(user.getUsername()).isEmpty() || user.getUsername()=="" || user.getUsername()==null) {// List ername()));mpty는 .isEmpty()로 체크
			return false;
		}else {
			return true;
		}
		 
	}
	public List<Authority> authorityList() {
		List<Authority> list = new ArrayList<>();
		list = authorityRepository.findAll();
		return list;
	}
	@Transactional
	public List<Authority> selectAuthorityByList(List<String> userauth) {
		List<Authority> authorities = new ArrayList<>();
//		prelecs.forEach(el -> System.out.println(el));
		if(userauth != null) {
			for(String el : userauth) {
//				System.out.println("형변환된 아이디는 " + Long.parseLong(el));
//				System.out.println("lectures는 다음과 같습니다."+lectureRepository.findById(Long.parseLong(el)).orElse(null));
				authorities.add(authorityRepository.findById(Long.parseLong(el)).orElse(null));	
				}
			
			return authorities;	
		}else {
			return null; 
		}
	}
//	@Transactional
	public User findByUsername(String username) {
//		System.out.println("Hello");
		User user = userRepository.findByUsername(username); 
//		System.out.println("loadUserByUsername은 다음과 같다 : "+user);
//		System.out.println("loadUserByUsername은 다음과 같다 : "+user.getLectures());
		return user;
	}
	
	public List<Authority> selectAuthoritiesById(long id) {
		User user = userRepository.findById(id).orElse(null); 
		if(user !=null) {
			return user.getAuthorities();
		}
		
		return new ArrayList<>();
	}
					// domain user에서 인터넷 주소에서 homecontroller에 /auth를 request하면 user에서 lecture를 참조하려고 하는데, 
					// many to many관계여서 기본적으로 lazy로 된다. 그래서, 바로 참조 해야되는데 그렇게 세팅이 안되서 바로참조되도록 transactional걸어줌 
	public int saveLecAndAuthAndPass(List<Lecture> lectures, List<Authority> authorities, User user) {
//		user.setId(user.getId());
		user.setAuthorities(authorities);
		user.setPassword(passwordEncoder.encode(user.getPassword()));
		user.setStatus(true);
		userRepository.save(user);
		if(lectures!=null) {
			for(Lecture e : lectures) {
				e.addUser(user);
				lectureRepository.save(e);
			}
			user.setLectures(lectures); 
		} 
		 
		System.out.println("##################");
		System.out.println(user);
		
		if(user !=null) {
			user=userRepository.save(user);
//			Hibernate.initialize(user.getLectures());
			System.out.println("####!!!");
			System.out.println(user);
			
			return 1;
		}else {
			return 0;
		}
		 
	}
	public Authentication getAuthentication() {
		
		return SecurityContextHolder.getContext().getAuthentication();
		
	}
//	public User confirmCurrentUser() {
//		 
//		User user;
//		boolean fact = U.checkLoggedUser();
//		System.out.println("로그인상태 : " + fact);
//		if(fact == false) {
//			return null;
//		}
//		user = U.getLoggedUser();
//		return user;
//	}
//	 
	public User findById(long l) {
		System.out.println("id는"+ l);
		User user = userRepository.findById(l).orElse(null);
		System.out.println("user는 "+ user);
		return user;
	}
	
	//주어진 username의 회원이 존재하는지 확인 (회원가입등에서 활용) 
	public boolean isExist(String username) {
		User user = userRepository.findByUsername(username);
		if(user !=null) return true; 
		return false; 
	}
	
	// 회원등록 
	public int register(User user) {
		user.setUsername(user.getUsername().toUpperCase()); 	//대문자로 저장
		user.setPassword(passwordEncoder.encode(user.getPassword()));	// password는 암호화 
		user = userRepository.save(user);	//저장 
		
		// 신규회원 ROLE_MEMBER 권한 기본적으로 부여하기 
		Authority auth = authorityRepository.findByName("ROLE_MEMBER");
		user.addAuthority(auth);
		user.setStatus(true);
		userRepository.save(user);
	
		return 1;
	}
	public int userUpdate(User user) {
		
		return 1;
	}
	public int updateLecAndAuthAndPass(List<Lecture> lectures, List<Authority> authorities, User user) {
		user.setLectures(lectures);
		user.setAuthorities(authorities);
		System.out.println("####!!!");
		System.out.println(user.getPassword());	
		user.setPassword(user.getPassword());	// 위에서는 encoding하였으나 또하면, 이미 encoding된 passwd가 또 encoding되어 에러생김 
		if(user !=null) {
			user=userRepository.save(user);
//			Hibernate.initialize(user.getLectures());
			System.out.println("####!!!");
			System.out.println(user);
			return 1;
		}else {
			return 0;
		}
		 
	}
	 
}
