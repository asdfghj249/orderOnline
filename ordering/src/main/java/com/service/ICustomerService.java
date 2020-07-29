package com.service;

import com.pojo.Customer;

import java.util.List;

public interface ICustomerService {

    //用户登录
    public Customer foreLogin(Customer customer);

    //用户注册
    public String save(Customer customer);

    //查询所有用户
    public List<Customer> findAll();

    //根据name查询
    public Customer findByName(String name);

    //根据id查询
    public Customer findByid(int id);

    //设置会员
    public void shezhihuiyuan(int id);

    //取消会员
    public void quxiaohuiyuan(int id);

    //删除用户
    public void del(int id);
}
