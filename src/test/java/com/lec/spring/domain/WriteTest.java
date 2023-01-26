package com.lec.spring.domain;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.lec.spring.service.WriteService;

@SpringBootTest
class WriteTest {

	WriteService writeService;
	@Autowired
	public void setWriteService(WriteService writeService) {
		this.writeService = writeService;
	}

	@Test
	void test() {
		System.out.println("Hello");
		Write write = Write.builder()
				.name("user1")
				.subject("제목1")
				.content("내용1")
				.build();
		int a =  writeService.save(write);
		if(a==1) {
			System.out.println("작성된 글은 성공적으로 저장되었습니다.");
		}else {
			System.out.println("작성된 글은 저장에 실패하였습니다.");
		}
		 
		
	}

}
