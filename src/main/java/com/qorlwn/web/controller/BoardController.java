package com.qorlwn.web.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qorlwn.web.dto.BoardDTO;
import com.qorlwn.web.service.BoardService;

@Controller
public class BoardController {
	@Autowired
	private BoardService boardService;
	
	@GetMapping("/board")
	public String board(Model model) {
		List<BoardDTO> list = boardService.boardList();
		model.addAttribute("list", list);
		return "board";
	}
	
	@ResponseBody
	@PostMapping("/detail")
	public String detail(@RequestParam("bno") int bno) {
		BoardDTO dto = boardService.detail(bno);
		JSONObject json = new JSONObject();
		//JSONObject e = new JSONObject();
		json.put("content", dto.getBcontent());
		json.put("uuid", dto.getBuuid());
		
		//json.put("result", e);// {"result":{"content":"[sdfsdf][sdfsdf]"}}
		System.out.println(json.toString());
		
		return json.toString();
	}
	
	@GetMapping("/write")
	public String write() {
		return "write";
	}
	
	@PostMapping("/write")
	public String write(HttpServletRequest request) {
		// System.out.println(request.getParameter("title"));
		// System.out.println(request.getParameter("content"));
		BoardDTO dto = new BoardDTO();
		dto.setBtitle(request.getParameter("title"));
		dto.setBcontent(request.getParameter("content"));
		dto.setM_id("pororo");
		dto.setBip("0.0.0.0");
		int result = boardService.write(dto);
		return "redirect:/board";
	}
	
	@PostMapping("/delete")
	public String delete(@RequestParam Map<String,Object> map) {
		System.out.println(map);
		return "redirect:/board";
	}
}