package com.qorlwn.web.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qorlwn.web.dao.AdminDAO;

@Service
public class AdminService {
	@Autowired
	private AdminDAO adminDAO;

	public Map<String, Object> login(Map<String, Object> map) {
		return adminDAO.login(map);
	}

	public List<Map<String, Object>> notice() {
		return adminDAO.notice();
	}

	public void noticeWrite(Map<String, Object> map) {
		adminDAO.noticeWrite(map);
	}

	public Map<String, String> noticeDetail(int nno) {
		return adminDAO.noticeDetail(nno);
	}

	public int noticeHideShow(int nno) {
		return adminDAO.noticeHideShow(nno);
	}

	public List<Map<String, Object>> setupboard() {
		return adminDAO.setupboard();
	}

	public void multiboard(Map<String, Object> map) {
		adminDAO.multiboard(map);
	}

	public List<Map<String, Object>> memberList() {
		return adminDAO.memberList();
	}

	public void gradeChange(Map<String, Object> map) {
		adminDAO.gradeChange(map);
	}

	public List<Map<String, Object>> post(Map<String, Object> map) {
		return adminDAO.post(map);
	}

}
