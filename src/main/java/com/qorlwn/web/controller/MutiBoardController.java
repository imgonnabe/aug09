package com.qorlwn.web.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.qorlwn.web.service.MultiBoardService;

@Controller
public class MutiBoardController {

	@Autowired
	private MultiBoardService mbService;

	@GetMapping("/multiboard") // multiboard?board=1
	public String multiboard(@RequestParam(value = "board", defaultValue = "1", required = false) int board,
			Model model) {
		// 화면에 보여줄 게시판 목록 만들기
		List<Map<String, Object>> boardlist = mbService.boardlist();
		model.addAttribute("boardlist", boardlist);
		
		List<Map<String, Object>> list = mbService.list(board);
		model.addAttribute("list", list);
		System.out.println(list);
		return "multiboard";
	}

	@GetMapping("/mbwrite")
	public String mbwrite(@RequestParam(value = "board", defaultValue = "1", required = false) int board, Model model,
			HttpSession session) {
		System.out.println("보드번호 : " + board);
		if(session.getAttribute("m_id") != null) {
			model.addAttribute("board", board);
			return "mbwrite";
		} else {
			return "redirect:/login?error=login";
		}
	}
	
	@PostMapping("/mbwrite")
	public String mbwrite(@RequestParam Map<String, Object> map, HttpSession session) {
		System.out.println(map);
		// {title=제목, content=글씨가 작다, files=, board=1}
		if(session.getAttribute("m_id") != null) {
			map.put("m_id", session.getAttribute("m_id"));
			mbService.mbWrite(map);// selectKey
			System.out.println(map);
			// {title=mbno는 map에, content=<p>mbno는 map에서 뽑아 써야돼욤ㅁ</p>, files=, board=1, m_id=pororo, mbno=7}
			// <selectKey>가 없으면
			// {title=공지, content=<p>공지</p>, files=, board=3, m_id=pororo}
			return "redirect:/mbdetail?board=" + map.get("board") + "&mbno=" + map.get("mbno");
		} else {
			return "redirect:/login?error=login";
		}
	}
	
	@GetMapping("/mbdetail")
	public String mbdetail(@RequestParam(value = "mbno", required = true) int mbno, Model model) {
		// System.out.println(mbno);
		Map<String, Object> detail = mbService.mbdetail(mbno);
		model.addAttribute("detail", detail);
		return "mbdetail";
	}

}
