package com.qorlwn.web.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface MultiBoardDAO {

	List<Map<String, Object>> list(int board);

}
