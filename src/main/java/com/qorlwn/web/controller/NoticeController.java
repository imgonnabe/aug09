package com.qorlwn.web.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qorlwn.web.service.NoticeService;
import com.qorlwn.web.util.Util;

@Controller
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;
	
	@Autowired
	private Util util;
	
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
	
	@ResponseBody
	@GetMapping("/download@{fileName}")
	public void download(@PathVariable("fileName") String fileName, HttpServletResponse response) {
		System.out.println(fileName);// 20230822145017f6facb5b-f9ba-48fb-8323-dc1246a6a96bSQLD 기출문제.txt
		String path = util.uploadPath();
		System.out.println(path);// C:\eGovFrameDev-4.1.0-64bit\workspace\aug09\src\main\webapp\ upload
		String oriFileName = noticeService.getOriFileName(fileName);
		File serverSideFile = new File(path, fileName);
		try {
			byte[] fileByte = FileCopyUtils.copyToByteArray(serverSideFile);
			response.setContentType("application/octet-stream");
			response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(oriFileName, "UTF-8")+"\";");
			System.out.println("attachment; fileName=\"" + URLEncoder.encode(oriFileName, "UTF-8")+"\";");
			// attachment; fileName="SQLD+%EA%B8%B0%EC%B6%9C%EB%AC%B8%EC%A0%9C.txt";
	        // inline : Web Page로, 혹은 Web Page 내에서 표시 (기본값)
			// attachment : 로컬에 다운로드 & 저장 (대부분의 브라우저에서는 바로 다운로드가 되거나, “Save As” 다이얼로그가 표시됨)
			// filename : 파일 이름을 지정할 수 있음
			response.setHeader("Content-Transfer-Encoding", "binary");
			response.getOutputStream().write(fileByte);
			response.getOutputStream().flush();
			response.getOutputStream().close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
