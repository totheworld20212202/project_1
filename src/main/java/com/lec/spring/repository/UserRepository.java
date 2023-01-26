package com.lec.spring.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

import com.lec.spring.domain.Authority;
import com.lec.spring.domain.User;

 
public interface UserRepository extends JpaRepository<User, Long> {

	List<User> findByusername(String username);	//findByFieldname은 Boolean type일수가 없더라. 

	User findByUsername(String username);

	 

	
	 

	
}
