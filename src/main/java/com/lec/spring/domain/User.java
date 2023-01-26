package com.lec.spring.domain;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Transient;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
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
@Entity(name="Pp01_User")
 
public class User extends BaseEntity  {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id; 			// PK
	@Column(unique = true, nullable = false)
	private String username; 	// 회원아이디
	@Column(nullable = false)
	private String password;	// 비밀번호
	@Transient	// javax.persistence : DB에는 반영안하는 필드 
	@ToString.Exclude
	private String re_password;	// 바인딩 하기위한 필드
	@Column(nullable = false)
	private String name; 		// 회원이름
	@Column
	private String registerDate; 	// 회원가입날짜
	@Column
	private String leaveDate;	// 회원탈퇴날짜
	@Enumerated(value = EnumType.STRING)
	private UserType userType;		// 회원종류 : 학생 or 학부모 or 강사 
	@Column
	private Boolean status;
	@ManyToMany 
	@ToString.Exclude
	@Builder.Default
	private List<Lecture> lectures = new ArrayList<>();
	public void addLecture(Lecture... lectures) {
		if(lectures != null) {
			Collections.addAll(this.lectures, lectures);
		}
	}
	
	@ManyToMany(fetch = FetchType.EAGER) 	//user로딩시 authority도 같이 로딩 
	// user가 몇개의 authority갖는지가 알필요있어서 manytomany를 user에만 걸었다. 
	@ToString.Exclude
	@Builder.Default	// builder에서 default를 쓰세요 ; new ArrayList<>()
	private List<Authority> authorities = new ArrayList<>();	// NPE 방지
	
	public void addAuthority(Authority... authorities) {
		if(authorities != null) {
			Collections.addAll(this.authorities, authorities);	// authorities(array)를 this.authorities에 담는것 
		}
	}
}
