package com.qorlwn.web.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.qorlwn.web.service.LoginService;

@Controller
public class LoginController {

	@Autowired
	private LoginService loginService;

	@GetMapping("/login")
	public String login() {
		return "login";
	}

	@PostMapping("/login")
	public String login(@RequestParam Map<String, String> map, HttpSession session) {
		// System.out.println(map);
		Map<String, Object> result = loginService.login(map);
		// System.out.println(result);// {m_name=뽀로로, count=1}
		// String.valueOf(result.get("count")).equlas("1")
		if (Integer.parseInt(String.valueOf(result.get("count"))) == 1) {
			session.setAttribute("m_name", result.get("m_name"));
			session.setAttribute("m_id", map.get("id"));
			// System.out.println(result.get("m_name"));
			// System.out.println(map.get("id"));// result.get("id") = null
			return "redirect:/";
		} else {
			return "redirect:/login";
		}
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		if(session.getAttribute("m_id") != null) {
			session.removeAttribute("m_id");
		}
		
		if(session.getAttribute("m_name") != null) {
			session.removeAttribute("m_name");
		}
		session.invalidate();
		return "redirect:/";
	}
}
