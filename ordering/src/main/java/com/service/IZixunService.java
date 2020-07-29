package com.service;

import com.pojo.ZiXun;

import java.util.List;

public interface IZixunService {

    //查看所有审核的资讯
    public List<ZiXun> findAll();

    //添加资讯
    public void save(ZiXun ziXun);

    //查询所有
    public List<ZiXun> find();

    //删除
    public void delete(int id);

    //审核
    public void zixunshenhe(int id);
}
