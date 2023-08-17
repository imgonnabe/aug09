package com.qorlwn.web.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.qorlwn.web.service.MultiBoardService;

@Controller
public class MutiBoardController {
	
	@Autowired
	private MultiBoardService mbService;
	
	@GetMapping("/multiboard")// multiboard?board=1
	public String multiboard(@RequestParam(value="board", defaultValue = "1", required = false) int board, Model model) {
		List<Map<String, Object>> list = mbService.list(board);
		model.addAttribute("list", list);
		System.out.println(list);
		return "multiboard";
	}
	
}
