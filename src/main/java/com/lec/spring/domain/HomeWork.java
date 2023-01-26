package com.lec.spring.domain;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

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
@ToString(callSuper=true)
@EqualsAndHashCode(callSuper = true)
@Entity(name="Pp01_HomeWork")
public class HomeWork extends BaseEntity{

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id; 					// PK
	@Column(name = "lecture_id")	//mapped by일때는 반드시해주어야한다. 
	private Long lecture;			//mapped by일때는 반드시해주어야한다. 
	@Column(nullable = false)
	private String name; 		//숙제이름
	@Column(nullable = false)	 
	private String content;		//숙제내용 
	@Column(nullable = false)	 
	private String deadline;	//마감일 
}
