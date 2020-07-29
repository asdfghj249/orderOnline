package com.service;

import com.pojo.Customer;
import com.pojo.Order;
import com.pojo.OrderItem;

import java.util.List;

public interface IOrderItemService {

    //根据cstid查询订单项
    public List<OrderItem> findItemByCstid(int id);

    //保存订单项
    public void save(OrderItem orderItem);

    //更新订单项
    public void update(OrderItem orderItem);

    //获得订单项
    public OrderItem get(int id);

    //删除订单项
    public void deleteById(int id);

    //给所有订单设置 oderitem 属性
    public void setOI(List<Order> order, Customer customer);

    //给单个订单设置 oderitem 属性
    public void setOrder(Order order,Customer customer);
}
