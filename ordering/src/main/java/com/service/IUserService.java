package com.service;

import com.pojo.User;

import java.util.List;

public interface IUserService {

    //查询所有
    public List<User> findAll();

    //增加
    public void save(User user);

    //删除
    public void delete(long id);

    //更新
    public void update(User user);

    //管理员登录
    public User login(User user);

    //根据id查询
    public User findById(long id);

    //根据name查询
    public User findByName(String name);

    //根据pid查询
    public User findByPid(int id);

    //启用
    public void startStatus(long id);

    //停用
    public void stopStatus(long id);


}
