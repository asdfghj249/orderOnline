package com.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.pojo.Category;
import com.pojo.Customer;
import com.pojo.ZiXun;
import com.service.ICustomerService;
import com.service.IZixunService;
import com.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import java.util.List;

@Controller
@RequestMapping("/zixun")
public class ZixunController {

    @Autowired
    private IZixunService zixunService;
    @Autowired
    private ICustomerService customerService;


    //资讯列表
    @RequestMapping("/list")
    public String list(Page page, Model model){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<ZiXun> ziXuns = zixunService.find();
        int total = (int) new PageInfo<>(ziXuns).getTotal();
        page.setTotal(total);
        int begin = page.getBeginandEnd(page).get(0);
        int end = page.getBeginandEnd(page).get(1);

        //给资讯设置顾客属性
        for(ZiXun zx:ziXuns){
            Customer customer = customerService.findByid(zx.getCstid());
            zx.setCustomer(customer);
        }

        model.addAttribute("ziXuns",ziXuns);
        model.addAttribute("total",total);
        model.addAttribute("page",page);
        model.addAttribute("begin",begin);
        model.addAttribute("end",end);
        return "zixunpage/zixun-list";
    }

    //审核
    @RequestMapping("/zixunshenhe")
    @ResponseBody
    public String zixunshenhe(int zid){
        zixunService.zixunshenhe(zid);
        return "success";
    }

    //删除
    @RequestMapping("/del")
    public String del(@RequestParam("id")int id){
        zixunService.delete(id);
        return "redirect:list";
    }
}
