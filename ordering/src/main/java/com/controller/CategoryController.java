package com.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.pojo.Category;
import com.service.ICategoryService;
import com.service.IProductService;
import com.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/category")
public class CategoryController {

    @Autowired
    private ICategoryService categoryService;
    @Autowired
    private IProductService productService;

    //商品种类列表
    @RequestMapping("/list")
    public String list(Model model,Page page){
        page.setCount(7);
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<Category> categories = categoryService.findAll();
        int total = (int) new PageInfo<>(categories).getTotal();
        page.setTotal(total);
        int begin = page.getBeginandEnd(page).get(0);
        int end = page.getBeginandEnd(page).get(1);

        model.addAttribute("categories",categories);
        model.addAttribute("total",total);
        model.addAttribute("page",page);
        model.addAttribute("begin",begin);
        model.addAttribute("end",end);
        return "productmodule/category-list";

    }

    //添加分类
    @RequestMapping("/addCategory")
    @ResponseBody
    public String addCategory(String name){
        Category category = new Category();
        category.setName(name);
        categoryService.save(category);
        return "productmodule/category-list";
    }

    //编辑分类界面
    @RequestMapping("/editCategory")
    public String editCategoryUI(@RequestParam("id")int id,Model model){
        Category category = categoryService.findById(id);

        model.addAttribute("category",category);
        return "productmodule/category-edit";
    }

    //更新分类信息
    @RequestMapping("/updateCategory")
    public String updateCategory(Category category){
        categoryService.update(category);
        return "redirect:list";
    }

    //判断分类是否有商品
    @RequestMapping("/hasproduct")
    @ResponseBody
    public String isHasProduct(int id){
        boolean b = productService.findProductByCid(id);
        if (b){
            return "true";
        }
        return "false";
    }

    //删除分类
    @RequestMapping("/delCategory")
    public String delCategory(@RequestParam("id")int id){
        categoryService.del(id);
        return "redirect:list";
    }

}
