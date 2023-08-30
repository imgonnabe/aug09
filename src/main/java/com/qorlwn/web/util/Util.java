package com.qorlwn.web.util;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.EmailAttachment;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

//Controller Service Repository 
//Component = 객체

@Component
public class Util {
	// 문자열이 들어오면 숫자로 변경하기
	public int strToInt(String str) {
		// 숫자로 바꿀 수 있는 경우 숫자로, 만약 숫자로 못 바꾼다면?
		// "156" -> 156 "156번" -> 156
		int result = 0;

		try {
			result = Integer.parseInt(str);
		} catch (Exception e) {
			// String re = "";// 숫자인것만 모을 스트링입니다.
			StringBuilder sb = new StringBuilder();
			for (int i = 0; i < str.length(); i++) {
				if (Character.isDigit(str.charAt(i))) {// 숫자인지 물어봄
					// re += str.charAt(i);// 숫자만 모아서
					sb.append(str.charAt(i));
				}
			}
			result = Integer.parseInt(sb.toString());// 숫자로 만들어서
		}
		return result;// 되돌려줍니다.
	}

	public String exchange(String str) {
		str = str.replaceAll("<", "&lt;");
		str = str.replaceAll(">", "&gt;");
		return str;
	}

	public String getIp() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
				.getRequest();
		// 상대방 ip가져오기 2023-07-19
		String ip = null; // 192.168.0.0 -> HttpServletRequest가 있어야 합니다.
		ip = request.getHeader("X-Forwarded-For");

		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("X-Real-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("X-RealIP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("REMOTE_ADDR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}

	// 숫자인지 확인하기
	public boolean isNum(Object obj) {
		try {
			Integer.parseInt(String.valueOf(obj));
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	// Object > Integer
	public int objToInt(Object obj) {
		return Integer.parseInt(String.valueOf(obj));
	}

	// 경로 얻어오기
	public HttpServletRequest getCurrentRequest() {
		return ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
	}

	public HttpServletResponse getCurrentResponse() {
		return ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getResponse();
	}

	// 세션 얻어오기
	public HttpSession getSession() {
		return ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest().getSession();
	}

	// 업로드 폴더까지 경로 얻어오기
	public String uploadPath() {
		return getCurrentRequest().getServletContext().getRealPath("/upload");
	}
	
	public void htmlMailSender(Map<String, Object> map) throws EmailException {
		String emailAddr = "";// 보내는 사람
		String passwd = "";
		String name = "스프링에서 보냄";// 보내는 사람 이름
		String hostname = "smtp.office365.com";// smtp주소
		int port = 587;
		
		// 메일 보내기
		// SimpleEmail mail = new SimpleEmail();
		HtmlEmail mail = new HtmlEmail();
		mail.setCharset("utf-8");
		mail.setDebug(true);// 디버깅을 콘솔창에 띄움
		mail.setHostName(hostname);// 고정
		mail.setAuthentication(emailAddr, passwd);// 고정
		mail.setSmtpPort(port);// 고정
		mail.setStartTLSEnabled(true);// 고정 - 이메일 암호화
		mail.setFrom(emailAddr, name);// 고정
		
		mail.addTo((String) map.get("to"));// 받는 사람
		mail.setSubject((String) map.get("title"));// 제목
		// mail.setMsg((String) map.get("content"));// 내용
		// 이미지 경로 잡기
		String path = uploadPath();
		String img = "https://whale.naver.com/img//banner_beta_download_phone_1440.png";
		String file2 = path + "/20230822144859412d2c31-9211-47bf-bd36-ea2861d64ce4SQLD 기출문제.txt";
		
		String html = "<html>";
		html += "<h1>그림을 첨부합니다.</h1>";
		html += "<img alt=\"이미지\" src=\"" + img + "\">";
		html += "<h2>임시 비밀번호를 보내드립니다.</h2>";
		html += "<div>임시 암호 : 123456789";
		html += "</div>";
		html += "<h3>아래 링크를 클릭해서 암호를 변경해주세요.</h3>";
		html += "<a href=\"http://nid.naver.com\">눌러주세요.</a>";
		html += "</html>";
		mail.setHtmlMsg(html);
		
		//첨부파일 보내기
		EmailAttachment file = new EmailAttachment();
		file.setPath(file2);
		mail.attach(file);
		
		String result = mail.send();
		System.out.println("메일 보내기 : " + result);
		// 메일 보내기 : <1695818048.79.1692756794254@DESKTOP-ERR5D88>
	}

}