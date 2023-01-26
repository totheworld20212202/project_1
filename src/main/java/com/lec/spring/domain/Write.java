package com.lec.spring.domain;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import org.hibernate.annotations.ColumnDefault;

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
@Entity(name="Pp01_writeStudent")
public class Write extends BaseEntity{

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id; 
	private String name; 
	@Column(nullable = false)
	private String subject;
	private String content;
	@ColumnDefault(value="0")	//default값을 0으로 
	private int viewCnt;	// 글 조회수 primitive type int인경우 자동으로 notnull로 세팅됨.
	@OneToMany(mappedBy = "write", cascade = CascadeType.ALL)	// mapped by foreign key field를 직접 FileDTO에 만들어주어야한다. 
//	@OneToMany	//joincolumn	알아서, foreign key가 FileDTO에 생긴다. 
//	@JoinColumn(name = "write_id")	//joincolumn
	@ToString.Exclude
	@Builder.Default
	private List<FileDTO> files = new ArrayList<>(); 
	public void addFiles(FileDTO... files) {  // xxxToMany 의 경우 만들어두면 편리
		if(files != null) {
			Collections.addAll(this.files, files);
		}
	}
	@ManyToOne	
	@ToString.Exclude	// 알아서 user_id가 foreign key로 생긴다.  
	private User user; 
	
}
