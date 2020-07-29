package com.service.impl;

import com.dao.OrderItemMapper;
import com.pojo.*;
import com.service.IOrderItemService;
import com.service.IProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderItemServiceImpl implements IOrderItemService {

    @Autowired
    private OrderItemMapper orderItemMapper;
    @Autowired
    private IProductService productService;

    @Override
    public List<OrderItem> findItemByCstid(int id) {
        OrderItemExample example = new OrderItemExample();
        example.createCriteria().andCstidEqualTo(id).andOidIsNull();
        List<OrderItem> orderItems = orderItemMapper.selectByExample(example);

        //给订单项设置商品
        for (OrderItem oi :orderItems){
            Product product = productService.findByid(oi.getPid());
            oi.setProduct(product);
        }

        return orderItems;
    }

    @Override
    public void save(OrderItem orderItem) {
        orderItemMapper.insert(orderItem);
    }

    @Override
    public void update(OrderItem orderItem) {
        orderItemMapper.updateByPrimaryKey(orderItem);
    }

    @Override
    public OrderItem get(int id) {
        OrderItem orderItem = orderItemMapper.selectByPrimaryKey(id);
        Product product = productService.findByid(orderItem.getPid());
        orderItem.setProduct(product);
        return orderItem;
    }

    @Override
    public void deleteById(int id) {
        orderItemMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void setOI(List<Order> order, Customer customer) {
        for(Order o:order){
            OrderItemExample example = new OrderItemExample();
            example.createCriteria().andOidEqualTo(o.getId());
            List<OrderItem> orderItemList = orderItemMapper.selectByExample(example);
            for (OrderItem oi:orderItemList){
                Product product = productService.findByid(oi.getPid());
                oi.setProduct(product);
            }
            float total = 0;
            int totalNumber = 0;
            for(OrderItem orderItem : orderItemList){
                if (customer.getStatus() == 1){
                    total += orderItem.getNumber() * orderItem.getProduct().getPrice() * 0.8;
                    totalNumber += orderItem.getNumber();
                }else {
                    total += orderItem.getNumber() * orderItem.getProduct().getPrice();
                    totalNumber += orderItem.getNumber();
                }
            }
            total = total + 10;
            o.setTotal(total);
            o.setTotalNumber(totalNumber);
            o.setOrderItems(orderItemList);
        }
    }

    @Override
    public void setOrder(Order order, Customer customer) {
        OrderItemExample example = new OrderItemExample();
        example.createCriteria().andOidEqualTo(order.getId());
        List<OrderItem> orderItemList = orderItemMapper.selectByExample(example);
        for (OrderItem oi:orderItemList){
            Product product = productService.findByid(oi.getPid());
            oi.setProduct(product);
        }

        float total = 0;
        int totalNumber = 0;
        for(OrderItem orderItem : orderItemList){
            if (customer.getStatus() == 1){
                total += orderItem.getNumber() * orderItem.getProduct().getPrice() * 0.8;
                totalNumber += orderItem.getNumber();
            }else {
                total += orderItem.getNumber() * orderItem.getProduct().getPrice();
                totalNumber += orderItem.getNumber();
            }
        }
        total = total + 10;
        order.setTotal(total);
        order.setTotalNumber(totalNumber);
        order.setOrderItems(orderItemList);
    }
}
