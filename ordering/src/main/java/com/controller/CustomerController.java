package com.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.pojo.Customer;
import com.service.ICustomerService;
import com.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/customer")
public class CustomerController {

    @Autowired
    private ICustomerService customerService;


    //用户列表
    @RequestMapping("/list")
    public String list(Model model, Page page){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<Customer> customers = customerService.findAll();
        int total = (int) new PageInfo<>(customers).getTotal();
        int begin = page.getBeginandEnd(page).get(0);
        int end = page.getBeginandEnd(page).get(1);


        model.addAttribute("customers",customers);
        model.addAttribute("total",total);
        model.addAttribute("end",end);
        model.addAttribute("begin",begin);
        return "cstpage/cst-list";
    }

    //设置会员
    @RequestMapping("/shezhihuiyuan")
    @ResponseBody
    public String shezhihuiyuan(int id){
        customerService.shezhihuiyuan(id);
        return "success";
    }

    //取消会员
    @RequestMapping("/quxiaohuiyuan")
    @ResponseBody
    public String quxiaohuiyuan(int id){
        customerService.quxiaohuiyuan(id);
        return "success";
    }

    //删除用户
    @RequestMapping("/del")
    public String delCustomer(int id){
        customerService.del(id);
        return "redirect:list";
    }

}
