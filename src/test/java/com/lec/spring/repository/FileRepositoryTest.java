package com.lec.spring.repository;

import static org.junit.jupiter.api.Assertions.*;

import java.util.ArrayList;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.lec.spring.domain.FileDTO;
import com.lec.spring.domain.Write;
import com.lec.spring.service.WriteService;

@SpringBootTest
class FileRepositoryTest {

	WriteService writeService;
	
	@Autowired
	public void setWriteService(WriteService writeService) {
		this.writeService = writeService;
	}

	
	// mapped by일때 코드 foreignkey를 테이블에 지정해야되고, 저장도 해야된다. 대신에 cascade 가능한것으로 보이는데 
//	@Test 
	void test_mappedby() {	 
		 
		System.out.println("Hello");
		
//		int	b = writeService.filesave(fileDTO);
//		if(b==1) {
//			System.out.println("파일이 성공적으로 저장되었습니다.");
//		}else {
//			System.out.println("파일이 저장에 실패하였습니다.");
//		}
		
		Write write = Write.builder()
				.name("user10")
				.subject("제목10")
				.content("내용10")
				.build();
		 
		writeService.save(write);
//		int a =  writeService.save(write);
//		if(a==1) {
//			System.out.println("작성된 글은 성공적으로 저장되었습니다.");
//		}else {
//			System.out.println("작성된 글은 저장에 실패하였습니다.");
//		}
		FileDTO fileDTO1 = FileDTO.builder()
				.source("file1")
				.file("File1")
				.write(write.getId())	
				.build();
		FileDTO fileDTO2 = FileDTO.builder()
				.source("file2")
				.file("File2")
				.write(write.getId())
				.build();
		writeService.filesave(fileDTO1);
		writeService.filesave(fileDTO2);
		write.addFiles(fileDTO1,fileDTO2);
		writeService.save(write);
		System.out.println("writeID는 "+write.getId());
		FileDTO filedto = writeService.findfileById(write.getId());	// write.getId()는 글 아이디인데 findById는 file 고유아이디로찾는것 
		System.out.println(filedto);
	}
	
	// joinColumn일때 코드 foreignkey를 테이블에 지정안해도 된다. foreign key저장도 필요없다. . 대신에 cascade 안되는것처럼 보인다.  
//	@Test
	void test_joinColumn() {
		 
		System.out.println("Hello");
		
//		int	b = writeService.filesave(fileDTO);
//		if(b==1) {
//			System.out.println("파일이 성공적으로 저장되었습니다.");
//		}else {
//			System.out.println("파일이 저장에 실패하였습니다.");
//		}
		
		Write write = Write.builder()
				.name("user10")
				.subject("제목10")
				.content("내용10")
				.build();
		 
		writeService.save(write);
//		int a =  writeService.save(write);
//		if(a==1) {
//			System.out.println("작성된 글은 성공적으로 저장되었습니다.");
//		}else {
//			System.out.println("작성된 글은 저장에 실패하였습니다.");
//		}
		FileDTO fileDTO1 = FileDTO.builder()
				.source("file1")
				.file("File1")
//				.write(write.getId())
				.build();
		FileDTO fileDTO2 = FileDTO.builder()
				.source("file2")
				.file("File2")
//				.write(write.getId())
				.build();
		writeService.filesave(fileDTO1);
		writeService.filesave(fileDTO2);
		write.addFiles(fileDTO1,fileDTO2);
		writeService.save(write);
		System.out.println("writeID는 "+write.getId());
		FileDTO filedto = writeService.findfileById(write.getId());	// write.getId()는 글 아이디인데 findById는 file 고유아이디로찾는것 
		System.out.println(filedto);
	}
	@Test
	void test_for() {
		List<String> list = new ArrayList<>();
		list.add("h1");
		list.add("h2");
		list.add("h3");
		for(String e : list) {
			System.out.println(e);
		}
		
		
	}

}
