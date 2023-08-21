package com.qorlwn.web.controller;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

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
	
	@GetMapping("/notice")
	public String notice(Model model) {
		List<Map<String, Object>> list = adminService.notice();
		// |nno |ntitle |ncontent |ndate |m_id |ndel |norifile |nrealfile
		model.addAttribute("notice", list);
		return "admin/notice";
	}
	
	@PostMapping("/noticeWrite")
	public String noticeWrite(@RequestParam("file") MultipartFile file, @RequestParam Map<String, Object> map) {
		if (file.getSize() > 0) {// !file.isEmpty()
			// 저장할 경로 뽑기
			HttpServletRequest request = 
					((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
			String path = request.getServletContext().getRealPath("/upload");
			System.out.println("실제 경로 : " + path);
			// 실제 경로 : C:\eGovFrameDev-4.1.0-64bit\workspace\aug09\src\main\webapp\ upload
			
			// file정보 보기
			System.out.println(file.getOriginalFilename());// robot.png
			System.out.println(file.getSize());// 17719
			System.out.println(file.getContentType());// image/png
			// 파일 업로드(경로 + 저장할 파일명)
			File newFileName = new File(file.getOriginalFilename());
		}
		
		
		map.put("m_no", 8);
		
		// adminService.noticeWrite(map);
		return "redirect:/admin/notice";
	}

}
