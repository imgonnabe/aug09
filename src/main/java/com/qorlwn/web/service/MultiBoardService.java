package com.qorlwn.web.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qorlwn.web.dao.MultiBoardDAO;

@Service
public class MultiBoardService {
	
	@Autowired
	private MultiBoardDAO mbDAO;

	public List<Map<String, Object>> list(int board) {
		return mbDAO.list(board);
	}
}
