package com.qorlwn.web.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	public String noticeWrite(@RequestParam("file") MultipartFile file, @RequestParam Map<String, Object> map, HttpSession session) {
		System.out.println(file);// org.springframework.web.multipart.support.StandardMultipartHttpServletRequest$StandardMultipartFile@69c2f465
		System.out.println(map);// {title=ㅛ, content=ㅛ}, file은 없음
		if (session.getAttribute("m_id") != null && util.objToInt(session.getAttribute("m_grade")) > 5) {
			if (file.getSize() > 0) {// !file.isEmpty()
				// 저장할 경로 뽑기
				String path = util.uploadPath();
				System.out.println("실제 경로 : " + path);
				// 실제 경로 : C:\eGovFrameDev-4.1.0-64bit\workspace\aug09\src\main\webapp\ upload

				// file정보 보기
				System.out.println(file.getOriginalFilename());// robot.png
				System.out.println(file.getSize());// 17719
				System.out.println(file.getContentType());// image/png

				// 중복피하기 위해 날짜+UUID+파일명.파일확장자
				// UUID 뽑기
				UUID uuid = UUID.randomUUID();

				// 날짜 뽑기
				LocalDateTime ldt = LocalDateTime.now();
				String format = ldt.format(DateTimeFormatter.ofPattern("YYYYMMddHHmmss"));// -, _ 빼야된다.
				String realFileName = format + uuid.toString() + file.getOriginalFilename();

				// 경로 + 저장할 파일명
				// File filePath = new File(path);// String 타입의 경로를 file 형태로 바꾼다.
				// File newFileName = new File(filePath + "/" + file.getOriginalFilename()); "/" == "\\"
				File newFileName = new File(path, realFileName);

				// 파일 업로드
				// 1. transfer
				// try {
				// 		file.transferTo(newFileName);// 파일을 내 서버로 복사
				// } catch (Exception e) {
				// 		e.printStackTrace();
				// }

				// 2. FileCopyUtils을 사용하기 위해서는 오리지널 파일을 byte[]로 만들어야 한다.
				try {
					FileCopyUtils.copy(file.getBytes(), newFileName);
				} catch (IOException e) {
					e.printStackTrace();
				}
				map.put("norifile", file.getOriginalFilename());
				map.put("nrealfile", realFileName);
			}
			map.put("m_id", session.getAttribute("m_id"));
			System.out.println(map);
			adminService.noticeWrite(map);
			return "redirect:/admin/notice";
		} else {
			return "redirect:/admin/admin?error=login";
		}

	}
	
	@GetMapping("/mail")
	public String mail() {
		return "admin/mail";
	}

}
