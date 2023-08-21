package com.qorlwn.web.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.qorlwn.web.service.AdminService;
import com.qorlwn.web.util.Util;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private AdminService adminService;

	@Autowired
	private Util util;
	
	@GetMapping("/")
	public String adminIndex2() {
		return "forward:/admin/admin";// url경로명을 유지하고 화면내용만 갱신
	}

	@GetMapping("/admin")
	public String adminIndex() {
		return "admin/index";
	}

	@PostMapping("/login")
	public String adminLogin(@RequestParam Map<String, Object> map, HttpSession session) {
		// System.out.println(map);// {id=pororo, pw=1234567}
		Map<String, Object> result = adminService.login(map);
		// System.out.println(result);// {m_grade=5, m_name=뽀로로, count=1}

		if (util.objToInt(result.get("count")) == 1 && util.objToInt(result.get("m_grade")) > 5) {// object는 부등호 불가능
			// 세션 올리기
			session.setAttribute("m_id", map.get("id"));
			session.setAttribute("m_name", result.get("m_name"));
			session.setAttribute("m_grade", result.get("m_grade"));
			// 메인으로 이동
			return "redirect:/admin/main";
		} else {
			return "redirect:/admin/admin?error=login";
		}
	}
	
	@GetMapping("/main")
	public String main() {
		return "admin/main";
	}

}
