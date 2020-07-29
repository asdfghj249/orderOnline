package com.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.pojo.Category;
import com.pojo.Product;
import com.pojo.ProductVO;
import com.pojo.User;
import com.service.ICategoryService;
import com.service.IProductService;
import com.service.IUserService;
import com.util.Page;
import com.util.UploadUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private IProductService productService;
    @Autowired
    private ICategoryService categoryService;
    @Autowired
    private IUserService userService;
    
    //商品列表
    @RequestMapping("/list")
    public String list(Model model, Page page){

        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<Product> products = productService.findAll();
        int total = (int) new PageInfo<>(products).getTotal();
        page.setTotal(total);
        int begin = page.getBeginandEnd(page).get(0);
        int end = page.getBeginandEnd(page).get(1);

        //给商品设置种类和商家属性
        productService.setCateAndUser(products);

        model.addAttribute("products",products);
        model.addAttribute("total",total);
        model.addAttribute("begin",begin);
        model.addAttribute("end",end);
        model.addAttribute("page",page);
        return "productmodule/product-list";
    }

    //添加商品界面
    @RequestMapping("/productAddUI")
    public String productAddUI(Model model){
        List<Category> categories = categoryService.findAll();
        List<User> users = userService.findAll();

        model.addAttribute("categories",categories);
        model.addAttribute("users",users);
        return "productmodule/product-add";
    }

    //添加商品
    @RequestMapping("/addProduct")
    public String addProduct(HttpSession session, UploadUtil upload,Product product) throws IOException {
        productService.save(product);
        if (upload != null){
            String imageName = product.getId() + ".jpg";

            File file = new File(session.getServletContext().getRealPath("/images/product"),imageName);
           // System.out.println(session.getServletContext().getRealPath("/images/product"));

            file.getParentFile().mkdirs();
            upload.getImage().transferTo(file);

            ProductVO vo = new ProductVO();
            vo.setId(product.getId());
            vo.setImageUrl("images/product/"+imageName);
            productService.setImageURL(vo);
        }
        return "redirect:list";
    }

    //编辑商品页面
    @RequestMapping("/editProduct")
    public String editProductUI(@RequestParam("id") int id, Model model){
        List<Category> categories = categoryService.findAll();
        List<User> users = userService.findAll();

        Product product = productService.findByid(id);
        //通过pid返回当先商品的user和 category
        User crrentUser = userService.findByPid(id);
        Category crrentCategory = categoryService.findByPid(id);

        model.addAttribute("categories",categories);
        model.addAttribute("users",users);
        model.addAttribute("product",product);
        model.addAttribute("crrentUser",crrentUser);
        model.addAttribute("crrentCategory",crrentCategory);
        return "productmodule/product-edit";
    }

    //更新商品信息
    @RequestMapping("/updateProduct")
    public String updateProduct(HttpSession session,Model model,UploadUtil upload,Product product) throws IOException {
        productService.update(product);
        if (upload != null){
            String imageName = product.getId() + ".jpg";

            File file = new File(session.getServletContext().getRealPath("/images/product"),imageName);
            // System.out.println(session.getServletContext().getRealPath("/images/product"));

            file.getParentFile().mkdirs();
            upload.getImage().transferTo(file);

            ProductVO vo = new ProductVO();
            vo.setId(product.getId());
            vo.setImageUrl("images/product/"+imageName);
            productService.setImageURL(vo);
        }
        return "redirect:list";
    }

    //上线商品
    @RequestMapping("/startStatus")
    @ResponseBody
    public String startStatus(int id){
        productService.startStatus(id);
        return "success";
    }

    //下线商品
    @RequestMapping("/stopStatus")
    @ResponseBody
    public String stopStatus(int id){
        productService.stopStatus(id);
        return "success";
    }

    //删除商品
    @RequestMapping("/deleteProduct")
    public String deleteProduct(@RequestParam("id")int id,HttpSession session){
        productService.del(id);
        String imageName = id+".jpg";
        File file = new File(session.getServletContext().getRealPath("/images/product"),imageName);
        file.delete();
        return "redirect:list";
    }


}
