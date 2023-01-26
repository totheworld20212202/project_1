package com.lec.spring.domain;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.PreRemove;

import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@Entity(name="Pp01_Lecture")
public class Lecture extends BaseEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id; 					// PK
	@Column(nullable= false)
	private String subject;				// 강의과목
	@Column(nullable= false)
	private String textbook;			// 교재
	@Column
	private Boolean status; 	// 대문자로 해야 get.Status()생긴다.
//	@Column(nullable= false)
	private String startdate;	// 강의시작일자
//	@Column(nullable= false)
	private String enddate;		// 강의종료일자 
	@Column(nullable= false)
	private String teacher; 			// 강사이름 
	
	 
	
	@ManyToMany(fetch = FetchType.EAGER )//, cascade= {CascadeType.PERSIST, CascadeType.MERGE}
	@ToString.Exclude
	@Builder.Default
	private List<User> users = new ArrayList<>();
	public void addUser(User... users) {
		if(users != null) {
			Collections.addAll(this.users, users);
		}
	}
//	@PreRemove
//	private void removeUsersFromLecture() {
//		getUsers().clear();
//	}
	@OneToMany(mappedBy = "lecture", cascade = CascadeType.ALL)
	@ToString.Exclude
	@Builder.Default
	private List<HomeWork> homeworks = new ArrayList<>();
	public void addHomeWork(HomeWork... homeworks) {
		if( homeworks != null) {
			Collections.addAll(this.homeworks, homeworks);
		}
	}
	@OneToMany(mappedBy = "lec", cascade = CascadeType.ALL)
	@ToString.Exclude
	@Builder.Default
	private List<HWSubmittedByStud> hwsubmits = new ArrayList<>();
	public void addHWSubmittedByStud(HWSubmittedByStud... hwsubmits) {
		if( hwsubmits != null) {
			Collections.addAll(this.hwsubmits, hwsubmits);
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
