package com.lec.spring.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import javax.persistence.PreRemove;
import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.lec.spring.domain.FileDTO;
import com.lec.spring.domain.HWSubmittedByStud;
import com.lec.spring.domain.HomeWork;
import com.lec.spring.domain.Lecture;
import com.lec.spring.domain.User;
import com.lec.spring.repository.FileRepository;
import com.lec.spring.repository.HWSubmittedByStudRepository;
import com.lec.spring.repository.HomeWorkRepository;
import com.lec.spring.repository.LectureRepository;
import com.lec.spring.repository.UserRepository;

@Service
public class LectureService {

	UserRepository userRepository; 
	LectureRepository lectureRepository;
	HomeWorkRepository homeWorkRepository;
	FileRepository fileRepository;
	UserService userService;
	HWSubmittedByStudRepository hwSubmittedByStudRepository;
	
	@Autowired
	public void setHwSubmittedByStudRepository(HWSubmittedByStudRepository hwSubmittedByStudRepository) {
		this.hwSubmittedByStudRepository = hwSubmittedByStudRepository;
	}
	@Autowired
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	@Autowired
	public void setHomeWorkRepository(HomeWorkRepository homeWorkRepository) {
		this.homeWorkRepository = homeWorkRepository;
	}
	@Autowired
	public void setUserRepository(UserRepository userRepository) {
		this.userRepository = userRepository;
	}
	@Autowired
	public void setLectureRepository(LectureRepository lectureRepository) {
		this.lectureRepository = lectureRepository;
	}
	@Autowired
	public void setFileRepository(FileRepository fileRepository) {
		this.fileRepository = fileRepository;
	}

	@Value("${app.hwupload.path}")
	private String hwuploadDir;
	@Autowired
	ServletContext context;
	
	 
	
			public void saveUser() {
				// User 생성
				User user1 = User.builder()
							.username("USER1")
							.password("1234")	//나중에 Security 적용하면 PasswordEncoder사용해야함. 
//							.password(passwordEncoder.encode("1234"))
							.name("회원1")
//							.userType(TEACHER)
							.build(); 
				User user2 = User.builder()
						.username("USER2")
						.password("4321")	//나중에 Security 적용하면 PasswordEncoder사용해야함. 
//						.password(passwordEncoder.encode("1234"))
						.name("회원2")
//						.userType(TEACHER)
						.build(); 
				userRepository.save(user1);
				userRepository.save(user2);
				 
				 
				List<User> list = new ArrayList<>();
				list.add(user1);
				list.add(user2);
				Lecture lecture1 = Lecture.builder()
						.subject("물리학1")
						.textbook("완자")
						.teacher("hhk")
//						.startdate(LocalDateTime.now())
//						.enddate(LocalDateTime.now())
						.users(list)
						.build(); 
			lectureRepository.save(lecture1);
			Lecture lecture2 = lectureRepository.findById((long)1).orElse(null);
			User user3 = userRepository.findById(+lecture2.getUsers().get(0).getId()).orElse(null);
			System.out.println(user3);
			}
			
			
			public List<Lecture> listLecture() {
				List<Lecture> list = new ArrayList<>();
				List<Lecture> updatedlist = new ArrayList<>();
				list = lectureRepository.findAll();
//				System.out.println("CheckCheck");
//				System.out.println(list);
				if(list==null) {
					return list;
				}else {
				for(Lecture e:list) {
//					System.out.println(list);
//					System.out.println(e.getStatus());
					if(e==null) {
						return list;
					}else {
						if(e.getStatus()) {	//e.getStatus()!=true null-pointer exception
							 
							updatedlist.add(e);
							System.out.println("Hello");
						}
					}
					
					
				}
				System.out.println(updatedlist); 
//				return updatedlist;
				return list;
				}
			}
			
			public Integer saveLecture(Lecture lecture) {
				if(lecture != null)	{
				lecture.setStatus(true);
				lecture = lectureRepository.save(lecture);
				System.out.println(lecture);
					return 1;
				} else {
					return 0;
				}
				
			}
			public int deleteLecture(Long id) {
				Lecture lecture = lectureRepository.findById(id).orElse(null);
				System.out.println("&&&&&&&&&&&&&&");
				 
				lecture.setStatus(false);
				if(lecture.getStatus() != true) {
					 
					System.out.println("@@@@@@@@@#########");
					List<User> users= userRepository.findAll();
					for(User u : users) {
						
						for(int i=0 ; i < u.getLectures().size(); i++) {
							if(u.getLectures().get(i)==lecture) {
								lecture.addUser(u);	// 아래 lecture에서 user가 저장이 안되어 있었다. 
							}						// nullpointer exception
						}
						
					}
					List<User> list = lecture.getUsers();	// 처음에 list가 null이 나왔다. 회원등록하고 수강신청시에 lecture에 회원이 등록이 안되어서 그랬다. 
					System.out.println(list);				// 그결과 @manytomany에 의한 삭제가 안되더라. 
					for(User user:list) {
//						user.setLectures(null);
						System.out.println("Hellok");
						user.getLectures().remove(lecture);
						userRepository.save(user);
						System.out.println(user.getLectures());
					}
					lecture.setUsers(null);
					lecture.setStatus(false);
					System.out.println("########@@@@@@@@@@@");
					lectureRepository.save(lecture);
					System.out.println(lecture);
					System.out.println(lecture.getUsers()); 
					lectureRepository.delete(lecture);
					return 1;
				}else {
					
					return 0; 
				}
				
				 
			}
			public Lecture selectLecture(Long id) {
				Lecture lecture = lectureRepository.findById(id).orElse(null);
				return lecture;
			}
			 
			public int updateLecture(Lecture lecture) {
				if(lecture != null) {
					lecture.setStatus(true);
//					List<User> users= userRepository.findAll();
//					for(User u : users) {
//						
//						for(int i=0 ; i < u.getLectures().size(); i++) {
//							if(u.getLectures().get(i)==lecture) {
//								lecture.addUser(u);	// 아래 lecture에서 user가 저장이 안되어 있었다. 
//							}						// nullpointer exception
//						}
//						
//					}
					lectureRepository.save(lecture);
					return 1;
				}
				 
				return 0;
			}
			@Transactional
			public List<Lecture> selectLectureByList(List<String> prelecs) {
				List<Lecture> lectures = new ArrayList<>();
//				prelecs.forEach(el -> System.out.println(el));
				if(prelecs != null) {
					for(String el : prelecs) {
//						System.out.println("형변환된 아이디는 " + Long.parseLong(el));
//						System.out.println("lectures는 다음과 같습니다."+lectureRepository.findById(Long.parseLong(el)).orElse(null));
						lectures.add(lectureRepository.findById(Long.parseLong(el)).orElse(null));	
						}
					
					return lectures;	
				}else {
					return null; 
				}
				
			}
			public Lecture[] transformListToArray(List<Lecture> lectures) {
				if(lectures!=null) {
					Lecture[] longArray = new Lecture[lectures.size()];
					
					return longArray = lectures.toArray(longArray);
				}else {
					return null;
				}
				 
			}
			public int saveHomeWorks(HomeWork homework) {
//				System.out.println("넘어온 hw은 다음과 같다 : "+ homework);
//				if(homework!=null) {
//					System.out.println("homework은 null이 아니다. " );
//					homeWorkRepository.save(homework);
//					return 1;
//				}
				System.out.println("homework은 다음과 같다 : "+ homework);
				homeWorkRepository.saveAndFlush(homework);
				System.out.println("homework은 다음과 같다 : "+ homework);
				return 1; 
			}
			 
			public List<HomeWork> findHwByHwSelectedAndId( int hwSelected, Long userid) {
				List<HomeWork> homeworks = new ArrayList<>();
				User user = userRepository.findById(userid).orElse(null);
//				User user1 = userService.findById((long)7);
//				System.out.println("user1은 다음과 같다 : " +user1.getLectures().get(0).getHomeworks());
//				System.out.println("hwSelected는 "+ hwSelected);
//				System.out.println("userid는 "+ user.getId());
//				System.out.println("user는 "+ user);
//				System.out.println("lecture "+ user.getLectures());
//				System.out.println("lecture "+ user.getLectures().get(hwSelected));
				 
				homeworks = user.getLectures().get(hwSelected).getHomeworks();
				System.out.println("user에 속한 lectures들은 : " + user.getLectures());
				System.out.println("homeworks는 : " + homeworks);
				return homeworks;
			}
			public Lecture findById(long id) {
				if(Objects.isNull(id)) {
					return null; 
				}else {
					Lecture lecture = lectureRepository.findById(id).orElse(null);
					return lecture;
				}
				 
			}
			public void saveHWSubmittedByStudents(long LectureID, long userid, Map<String, MultipartFile> files) {
					User user =userService.findById(userid);
//					System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%");
//					System.out.println("user는 다음과 같다:" + user);
					for(Map.Entry<String, MultipartFile> e : files.entrySet()) {
						System.out.println("숙제업로드파일 : " + e.getKey());
						System.out.println("숙제업로드파일 : " + e.getValue());
						HWSubmittedByStud file = upload(e.getValue(),e.getKey(),userid, LectureID);	// 물리적 숙제저장 
						
						if(file !=null) {
							file.setLec(LectureID);
							file= hwSubmittedByStudRepository.save(file);
						}
					}
					
			}
			private HWSubmittedByStud upload(MultipartFile multipartFile, String hwname, long userid, long LectureID) {
				HWSubmittedByStud attachment = null; 
				User user = userService.findById(userid);
				String username = user.getName()+"(id("+user.getId()+"))";	//user.getName하니까 한글이있어서 오류가 생기더라 
				Lecture lecture = lectureRepository.findById(LectureID).orElse(null);
				String lectureName = lecture.getSubject();
				String originalFilename = multipartFile.getOriginalFilename();
				if(originalFilename == null || originalFilename.length() ==0) return null; 
				
				//원본파일명
				String sourceName = StringUtils.cleanPath(multipartFile.getOriginalFilename());
				//저장될 파일명 
				String fileName = sourceName; 
				
				File userDirectory1 = new File(context.getRealPath(hwuploadDir) + File.separator + username);
				if(!userDirectory1.exists()) {
					System.out.println(userDirectory1 + "-> userDirectory not found");
					userDirectory1.mkdir();
					System.out.println("create a new folder -> "+ userDirectory1.getAbsolutePath());
				}
				File userDirectory2 = new File(context.getRealPath(hwuploadDir) + File.separator + username + File.separator + lectureName);
				if(!userDirectory2.exists()) {
					System.out.println(userDirectory2 + "-> userDirectory not found");
					userDirectory2.mkdir();
					System.out.println("create a new folder -> "+ userDirectory2.getAbsolutePath());
				}
				File userDirectory3 = new File(context.getRealPath(hwuploadDir) + File.separator + username+File.separator + lectureName + File.separator + hwname);
				if(!userDirectory3.exists()) {
					System.out.println(userDirectory3 + "-> userDirectory not found");
					userDirectory3.mkdir();
					System.out.println("create a new folder -> "+ userDirectory3.getAbsolutePath());
				}
				
				File file = new File(context.getRealPath(hwuploadDir)+ File.separator+ username +File.separator + lectureName + File.separator + hwname + File.separator + sourceName);
				if(file.exists()) {
					int pos = fileName.lastIndexOf(".");
					if (pos > -1) {
						String name = fileName.substring(0,pos);
						String ext = fileName.substring(pos+1);
						
						fileName = name+"_"+System.currentTimeMillis()+"."+ext;
					}else {
						fileName+="_"+System.currentTimeMillis();
					}
					
				}
				System.out.println("fileName: "+ fileName);
				
				Path copyOfLocation = Paths.get(context.getRealPath(hwuploadDir)+ File.separator+ username +File.separator + lectureName + File.separator + hwname + File.separator + sourceName);
				System.out.println("location은 : " + copyOfLocation);
				try {
					Files.copy(
							multipartFile.getInputStream(),
							copyOfLocation,
							StandardCopyOption.REPLACE_EXISTING
							);	//기존에 존재하면 덮어쓰기 
					
				}catch (IOException e) {
					e.printStackTrace(); 
				}
				
				attachment = HWSubmittedByStud.builder()
						.file(fileName)
						.source(sourceName)
						.build()
						;
				
				
				return attachment;
			}
			public HomeWork saveHomeWork(long userid,String lectureid, int hwSelected, String name, String content, String deadline) {
				long lecId = Long.parseLong(lectureid);
				
				HomeWork homework = HomeWork.builder()
						.name(name)
						.content(content)
						.deadline(deadline)
						.lecture(lecId)
//						.lecture((long)(hwSelected+1))	// hwSelected잘못된것 같음 
						.build(); 
				// 그냥 homework.setName하니까 nullpointer exception생기더라 
				// [중요!!!]여기서 저장할때, 자동으로 homework 뿐만아니라, lecture에도 업데이트 저장된다. 
				homework = homeWorkRepository.save(homework);
				return homework;
			}
			public List<HomeWork> addHomeWork(HomeWork homework, long userid, int hwSelected) {
				User user = userService.findById(userid);
				System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
				System.out.println(user.getLectures().get(hwSelected).getHomeworks());
				//여기서, 위에 saveHomeWork method()에서 저장 할때, 이미, lecture에 homework이 저장되었다. 
				// 그런데, 밑에 그걸 한번더 저장하는게 되어 버려 두번 저장되는것 
//				user.getLectures().get(hwSelected).addHomeWork(homework);
				System.out.println("%%%%%%%%%%%%%%%%%");
//				System.out.println(user.getLectures().get(hwSelected).getHomeworks());
				Lecture lecture = Lecture.builder()
						.id(user.getLectures().get(hwSelected).getId())
						.subject(user.getLectures().get(hwSelected).getSubject())
						.textbook(user.getLectures().get(hwSelected).getTextbook())
						.startdate(user.getLectures().get(hwSelected).getStartdate())
						.enddate(user.getLectures().get(hwSelected).getEnddate())
						.homeworks(user.getLectures().get(hwSelected).getHomeworks())
						.teacher(user.getLectures().get(hwSelected).getTeacher())
						.status(user.getLectures().get(hwSelected).getStatus())
						.build();
				System.out.println("%%%%%%%%%%%%%%%%%");
				System.out.println(lecture.getHomeworks());
				lectureRepository.save(lecture);
				System.out.println("%%%%%%%%%%%%%%%%%");
				System.out.println(lecture.getHomeworks());
				System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
				System.out.println(user.getLectures().get(hwSelected).getHomeworks());
				user.getLectures().set(hwSelected,lecture); 
				System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
				System.out.println(user.getLectures().get(hwSelected).getHomeworks());
				// List에서 replace는 list.set(2,"E") : 2번째가 E로 바뀜
				// 이제 user.getLectures()는 hwSelected 요소가 lecture로 바뀜. 그걸 아래에 저장 
//				userService.userSave(user);
				
//				homeworks = user.getLectures().get(hwSelected).getHomeworks();
				User user1 = User.builder()
						.id(user.getId())// .id(userid)라고 했더니 정상저장이 안되더라 
						.username(user.getUsername())
						.password(user.getPassword())
						.name(user.getName())
						.registerDate(user.getRegisterDate())
						.leaveDate(user.getLeaveDate())
						.userType(user.getUserType())
						.lectures(user.getLectures())
						.authorities(user.getAuthorities())
						.status(user.getStatus())
						.build();
				userService.userSave(user1); // update 
				List<HomeWork> homeworks = user1.getLectures().get(hwSelected).getHomeworks();
				System.out.println("%%%%%%%%%%%%%%%%%");
				System.out.println(homeworks);
				return homeworks;
			}
			public User regClass(long userid, long lectureid) {
				
				User user = userService.findById(userid);
				Lecture lecture = lectureRepository.findById(lectureid).orElse(null);
				System.out.println("user는 " + user);
				System.out.println("lecture는 " + lecture);
				user.addLecture(lecture);
				int result = userService.userSave(user);
				lecture.addUser(user);
				lectureRepository.save(lecture);
				if(result == 1) {
					System.out.println("정상적으로 수강신청되었습니다.");
				}else {
					System.out.println("수강신청에 실패하였습니다.");
				}
				return user;
			}
			
			public List<HomeWork> findListOfHomeworksByLectureId(long lid) {
				List<HomeWork> homeworks = new ArrayList<>();
				if(Objects.isNull(lid)) {
					return homeworks; 
				}else {
					Lecture lecture = lectureRepository.findById(lid).orElse(null);
					homeworks = lecture.getHomeworks();
					return homeworks;
				}
				 
			}
			public HomeWork findHomeWorkById(long hid) {
				if(Objects.isNull(hid)) {
					return null;  
				}else {
					HomeWork homework = homeWorkRepository.findById(hid).orElse(null); 
					return homework;
				}
				 
			}
			public List<Boolean> getListOfSubmits(List<User> users, long lid, long hid) {
				List<Boolean> list = new ArrayList<>();
				 
				Lecture lecture = lectureRepository.findById(lid).orElse(null); 
				String lectureName = lecture.getSubject();
				HomeWork homework = homeWorkRepository.findById(hid).orElse(null);
				System.out.println("users는 : " + users);
				for(User user : users) {
					File file = new File(context.getRealPath(hwuploadDir) + File.separator + user.getName() 
								+"(id("+user.getId()+"))" + File.separator + lectureName + File.separator 
								+ "hwid"+homework.getId()+"-"+homework.getName());
					System.out.println("file path는 : " + file.getAbsolutePath());
//					if(file.list().length == 0 || file.list() == null) {
					if(!file.isDirectory()) {
						list.add(false);
						
					}else {
						list.add(true);
						 
						
					}
					
				}
				 
				System.out.println("isSubmit은 : " + list);
				return list;
			}
			public List<File> getListOfPaths(List<User> users, long lid, long hid) {
				List<Boolean> list = new ArrayList<>();
				List<File> listOfPaths = new ArrayList<>();
				Lecture lecture = lectureRepository.findById(lid).orElse(null); 
				String lectureName = lecture.getSubject();
				HomeWork homework = homeWorkRepository.findById(hid).orElse(null);
				System.out.println("users는 : " + users);
				for(User user : users) {
					File file = new File(context.getRealPath(hwuploadDir) + File.separator + user.getName() 
								+"(id("+user.getId()+"))" + File.separator + lectureName + File.separator 
								+ "hwid"+homework.getId()+"-"+homework.getName());
					System.out.println("file path는 : " + file.getAbsolutePath());
//					if(file.list().length == 0 || file.list() == null) {
					if(!file.isDirectory()) {
						listOfPaths.add(null);
						
					}else {
						 
						listOfPaths.add(file);
						
					}
					
				}
				System.out.println("list of Paths는 : " + listOfPaths);
				 
				return listOfPaths;
			}
				
				 
			 
			 
}
