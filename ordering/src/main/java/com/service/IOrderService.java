package com.service;

import com.pojo.Customer;
import com.pojo.Order;
import com.pojo.OrderItem;

import java.util.List;

public interface IOrderService {

    //查询所有订单
    public List<Order> findAll();

    //生成完整订单并返回总价格
    public float add(Order o, List<OrderItem> ois, Customer customer);

    //更新订单
    public void update(Order order);

    //获得订单
    public Order get(int id);

    //根据cstid查询订单
    public List<Order> findByCstid(int id);


}
