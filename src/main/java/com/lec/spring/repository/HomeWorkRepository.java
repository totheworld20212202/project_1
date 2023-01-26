package com.lec.spring.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.lec.spring.domain.HomeWork;

public interface HomeWorkRepository extends JpaRepository<HomeWork, Long> {

	 

}
