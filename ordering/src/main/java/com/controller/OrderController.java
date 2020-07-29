package com.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.pojo.Category;
import com.pojo.Customer;
import com.pojo.Order;
import com.pojo.OrderItem;
import com.service.ICustomerService;
import com.service.IOrderItemService;
import com.service.IOrderService;
import com.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private IOrderItemService orderItemService;
    @Autowired
    private IOrderService orderService;
    @Autowired
    private ICustomerService customerService;

    //订单列表
    @RequestMapping("/list")
    public String list(Model model, Page page){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<Order> orders = orderService.findAll();
        int total = (int) new PageInfo<>(orders).getTotal();
        page.setTotal(total);
        int begin = page.getBeginandEnd(page).get(0);
        int end = page.getBeginandEnd(page).get(1);

        for(Order order:orders){
            Customer customer = customerService.findByid(order.getCstid());
            orderItemService.setOrder(order,customer);
            order.setCustomer(customer);
        }

        model.addAttribute("orders",orders);
        model.addAttribute("total",total);
        model.addAttribute("page",page);
        model.addAttribute("begin",begin);
        model.addAttribute("end",end);
        return "ordermodule/order-list";
    }

    //查看当前订单的订单项
    @RequestMapping("/seeOrderItem")
    public String seeOrderItemUI(Model model, @RequestParam("oid")int oid){
        Order order = orderService.get(oid);
        Customer customer = customerService.findByid(order.getCstid());
        orderItemService.setOrder(order,customer);

        model.addAttribute("customer",customer);
        model.addAttribute("orderItems", order.getOrderItems());
        model.addAttribute("totalPrice",order.getTotal());
        model.addAttribute("total", order.getOrderItems().size());

        return "ordermodule/orderItem-list";
    }


    //发货
    @RequestMapping("/orderDelivery")
    public String orderDelivery(@RequestParam("id")int id){
        Order order = orderService.get(id);
        order.setStatus(2);
        orderService.update(order);
        return "redirect:list";
    }
}
