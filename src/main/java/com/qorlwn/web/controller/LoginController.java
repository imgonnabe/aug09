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
	
	@GetMapping("/login.qorlwn")
	public String index() {
		return "login";
	}
	
	@PostMapping("/login.qorlwn")
	public String login(@RequestParam Map<String, String> map, HttpSession session) {
		// System.out.println(map);
		Map<String, Object> result = loginService.login(map);
		System.out.println(result);
		return "";
	}
}
