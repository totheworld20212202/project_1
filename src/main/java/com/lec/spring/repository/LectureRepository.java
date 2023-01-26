package com.lec.spring.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.lec.spring.domain.Lecture;

public interface LectureRepository extends JpaRepository<Lecture, Long> {

	@Query(
			value="SELECT * FROM USER u",
			nativeQuery = true)	 
	void predelete(Long id);

//	@Query("UPDATE pp01_lecture_users SET pp01_lecture_id=3 WHERE pp01_lecture_id= :id")
	 

//	@Query("DROP TABLE pp01_lecture_users CASCADE CONSTRAINTS")
//	void deleteLectureUser();

}
