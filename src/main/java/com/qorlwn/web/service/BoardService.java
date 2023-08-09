package com.qorlwn.web.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qorlwn.web.dao.BoardDAO;
import com.qorlwn.web.dto.BoardDTO;

@Service
public class BoardService {
	@Autowired
	private BoardDAO boardDAO;

	public List<BoardDTO> boardList() {
		return boardDAO.boardList();
	}
}
