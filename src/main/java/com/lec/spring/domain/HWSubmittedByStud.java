package com.lec.spring.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Transient;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString(callSuper = true)
@Entity(name="Pp01_HWSubmittedByStud")
public class HWSubmittedByStud {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id; 
	
	@Column(name = "lec_id")	//mapped by일때는 반드시해주어야한다. 
	private Long lec;			//mapped by일때는 반드시해주어야한다. 
	
	
	@Column(nullable = false)
	private String source;	// 원본파일명 
	@Column(nullable = false)
	private String file; 	// 저장된 파일명 (rename된 파일명)
	@Transient	// 데이타베이스에는 저장 안함. 
	private boolean isImage;	//이미지 여부 
}
