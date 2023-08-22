package com.qorlwn.web.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.qorlwn.web.service.NoticeService;

@Controller
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;
	
	@GetMapping("/notice")
	public String notice(Model model) {
		List<Map<String, Object>> list = noticeService.list();
		model.addAttribute("list", list);
		System.out.println(list);
		// [{ndate=2023-08-18 11:21:10.0, m_no=5, ntitle=공지, ncontent=공지 내용, nno=1, ndel=1}]
		return "notice";
	}
	
	@GetMapping("/noticeDetail")
	public String noticeDetail(@RequestParam("nno") int nno, Model model) {
		Map<String, Object> detail = noticeService.detail(nno);
		model.addAttribute("detail", detail);
		return "noticeDetail";
	}

}
