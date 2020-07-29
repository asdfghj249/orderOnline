package com.dao;

import com.pojo.ZiXun;
import com.pojo.ZiXunExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ZiXunMapper {
    int countByExample(ZiXunExample example);

    int deleteByExample(ZiXunExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(ZiXun record);

    int insertSelective(ZiXun record);

    List<ZiXun> selectByExample(ZiXunExample example);

    ZiXun selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") ZiXun record, @Param("example") ZiXunExample example);

    int updateByExample(@Param("record") ZiXun record, @Param("example") ZiXunExample example);

    int updateByPrimaryKeySelective(ZiXun record);

    int updateByPrimaryKey(ZiXun record);

    //审核
    void zixunshenhe(int id);
}