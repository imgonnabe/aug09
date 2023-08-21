package com.qorlwn.web.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AdminDAO {

	Map<String, Object> login(Map<String, Object> map);

	List<Map<String, Object>> notice();

	void noticeWrite(Map<String, Object> map);

}
