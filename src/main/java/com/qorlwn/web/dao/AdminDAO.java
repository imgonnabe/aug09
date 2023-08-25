package com.qorlwn.web.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AdminDAO {

	Map<String, Object> login(Map<String, Object> map);

	List<Map<String, Object>> notice();

	void noticeWrite(Map<String, Object> map);

	Map<String, String> noticeDetail(int nno);

	int noticeHideShow(int nno);

	List<Map<String, Object>> setupboard();

	void multiboard(Map<String, Object> map);

	List<Map<String, Object>> memberList();

	void gradeChange(Map<String, Object> map);

}
