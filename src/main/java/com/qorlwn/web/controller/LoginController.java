package com.qorlwn.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LoginController {
	
	@GetMapping("/login.qorlwn")
	public String index() {
		return "login";
	}
}
