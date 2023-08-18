package com.qorlwn.web.service;

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
}
