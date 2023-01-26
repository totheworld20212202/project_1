package com.lec.spring.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.lec.spring.domain.Write;
import com.lec.spring.service.WriteService;
import com.lec.spring.util.U;

@Controller
@RequestMapping("/board")
public class WriteController {

	WriteService writeService;
	
	@Autowired
	public void setWriteService(WriteService writeService) {
		this.writeService = writeService;
	}



	// select board 
	@GetMapping("/list")
	public void boardList(Integer page, Model model) {
//		List<Write> list = new ArrayList<>(); 
//		list = writeService.select();
//		System.out.println("작성자 list는 " + list + "입니다"); 
//		model.addAttribute("list", list);
		writeService.list(page,model);
	}
	
	// write
	@GetMapping("/write")
	public void boardWrite() {
		
	}
	// writeOk
	@PostMapping("/write")
	public String boardWriteOk(@ModelAttribute("dto") Write write,
			@RequestParam Map<String, MultipartFile> files
			, Model model) {
//		System.out.println(write); 
		model.addAttribute("result",writeService.write(write,files)); 
//		int result = writeService.save(write);
//		System.out.println(write);
//		model.addAttribute("result", result);
//		model.addAttribute("dto", write);
		return "/board/writeOk";
	}
	@GetMapping("/detail")
	public void boardDetail(Long id, Model model) {
		Write write = writeService.detail(id);
		System.out.println(write);
		model.addAttribute("write", write);
	}
	// update
	@GetMapping("/update")
	public void boardUpdate(Long id, Model model) {
		Write write = writeService.findById(id);
		model.addAttribute(write);
	}
	// updateOk
	@PostMapping("/update")
	public String boardUpdateOk(@ModelAttribute("dto") Write write, Model model) {
//		System.out.println("Hello");
		model.addAttribute("result", writeService.update(write));
		return "/board/updateOk";
	}
	// delete 
	@GetMapping("/delete")
	public String boardDelete(Long id,Model model) {
		
		model.addAttribute("result", writeService.deleteById(id));
		return "/board/deleteOk";
	}
	
	// 페이징 
	// pageRows 변경시 동작 
	@PostMapping("/pageRows")
	public String pageRows(Integer page, Integer pageRows) {
		U.getSession().setAttribute("pageRows", pageRows);
		return "redirect:/board/list?page=" + page;
	}
			
}
