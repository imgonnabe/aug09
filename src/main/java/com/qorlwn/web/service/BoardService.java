package com.qorlwn.web.service;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qorlwn.web.dao.BoardDAO;
import com.qorlwn.web.dto.BoardDTO;
import com.qorlwn.web.util.Util;

@Service
public class BoardService {
	@Autowired
	private BoardDAO boardDAO;
	
	@Autowired
	private Util util;

	public List<BoardDTO> boardList() {
		return boardDAO.boardList();
	}

	public BoardDTO detail(int bno) {
		boardDAO.readUp(bno);
		return boardDAO.detail(bno);
	}

	public int write(BoardDTO dto) {
		// ip
		dto.setBip(util.getIp());
		// uuid
		dto.setBuuid(UUID.randomUUID().toString());
		return boardDAO.write(dto);
	}

}
