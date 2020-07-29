package com.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.pojo.Customer;
import com.pojo.Product;
import com.pojo.Review;
import com.service.ICustomerService;
import com.service.IProductService;
import com.service.IReviewService;
import com.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/review")
public class ReviewController {

    @Autowired
    private IReviewService reviewService;
    @Autowired
    private ICustomerService customerService;
    @Autowired
    private IProductService productService;

    //评论列表
    @RequestMapping("/list")
    public String list(Model model, Page page){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<Review> reviews = reviewService.findAll();
        int total = (int) new PageInfo<>(reviews).getTotal();
        page.setTotal(total);
        int begin = page.getBeginandEnd(page).get(0);
        int end = page.getBeginandEnd(page).get(1);

        //给评论绑定customer和product属性
        for(Review r:reviews){
            Product product = productService.findByid(r.getPid());
            Customer customer = customerService.findByid(r.getCstid());
            r.setCustomer(customer);
            r.setProduct(product);
        }


        model.addAttribute("reviews",reviews);
        model.addAttribute("total",total);
        model.addAttribute("page",page);
        model.addAttribute("begin",begin);
        model.addAttribute("end",end);
        return "pinglunpage/pinglun";
    }

    //删除评论
    @RequestMapping("/del")
    public String del(@RequestParam("id")int id){
        reviewService.delete(id);
        return "redirect:list";
    }

}
