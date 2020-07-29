package com.service.impl;

import com.dao.OrderMapper;
import com.pojo.Customer;
import com.pojo.Order;
import com.pojo.OrderExample;
import com.pojo.OrderItem;
import com.service.IOrderItemService;
import com.service.IOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderServiceImpl implements IOrderService {

    @Autowired
    private OrderMapper orderMapper;
    @Autowired
    private IOrderItemService orderItemService;


    @Override
    public List<Order> findAll() {
       return orderMapper.selectByExample(null);
    }

    @Override
    public float add(Order o, List<OrderItem> ois, Customer customer) {
        float total = 0;
        //新增订单
        orderMapper.insert(o);
        //给订单项设置订单ID
        for(OrderItem oi :ois){
            oi.setOid(o.getId());
            orderItemService.update(oi);
            if(customer.getStatus() == 1){
                total += (oi.getNumber() * oi.getProduct().getPrice()) * 0.8;

            }else {
                total += oi.getNumber() * oi.getProduct().getPrice() ;
            }

        }
        total = total + 10;
        return total;
    }

    @Override
    public void update(Order order) {
        orderMapper.updateByPrimaryKey(order);
    }

    @Override
    public Order get(int id) {
        Order order = orderMapper.selectByPrimaryKey(id);
        return order;
    }

    @Override
    public List<Order> findByCstid(int id) {
        OrderExample example = new OrderExample();
        example.createCriteria().andCstidEqualTo(id);
        List<Order> orders = orderMapper.selectByExample(example);
        return orders;
    }
}
