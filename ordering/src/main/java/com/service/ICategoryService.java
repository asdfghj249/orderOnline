package com.service;

import com.pojo.Category;

import java.util.List;

public interface ICategoryService {

    //查询所有菜品种类
    public List<Category> findAll();

    //增加分类
    public void save(Category category);

    //更新分类信息
    public void update(Category category);

    //删除分类
    public void  del(int id);

    //查找4个菜品种类
    public List<Category> findFour();

    //根据主键查询
    public Category findById(int id);

    //根据pid查询
    public Category findByPid(int id);
}
