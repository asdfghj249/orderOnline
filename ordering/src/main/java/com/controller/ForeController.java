package com.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.pojo.*;
import com.realm.CustomizedToken;
import com.realm.LoginType;
import com.service.*;
import com.util.Page;
import com.util.PasswordHelper;
import org.apache.commons.lang.math.RandomUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/*
前台所有控制
 */

@Controller
@RequestMapping("/fore")
public class ForeController {
    @Autowired
    private ICustomerService customerService;
    @Autowired
    private ICategoryService categoryService;
    @Autowired
    private IZixunService zixunService;
    @Autowired
    private IProductService productService;
    @Autowired
    private IReviewService reviewService;
    @Autowired
    private IOrderItemService oderItemService;
    @Autowired
    private IOrderService orderService;

    private String PNAME=null;

    private static final String CUSTOMER_LOGIN_TYPE = LoginType.CUSTOMER.toString();
    
    //前台首页
    @RequestMapping("/foreIndex")
    public String index(HttpSession session,Model model){
        List<Category> categories1 = categoryService.findAll();
        List<Category> categories = categoryService.findFour();
        for(Category c:categories){
            List<Product> products = productService.findByCid(c.getId());
            //显示五个菜品给前端
            if(products.size() > 5){
                List<Product> products1 = new ArrayList<>();
                for(int i = 0;i < 5;i++){
                    products1.add(products.get(i));
                }
                c.setProduct(products1);
            }else {
                c.setProduct(products);
            }
        }

        session.setAttribute("categories1",categories1);
        model.addAttribute("categories",categories);
        return "forepage/index2";
    }


    //跳转注册界面
    @RequestMapping("/foreRegisterUI")
    public String foreRegisterUI(){
        return "forepage/foreRegister";
    }

    //用户注册
    @RequestMapping("/foreRegister")
    public String foreRegister(Customer customer,Model model){
        String salt= PasswordHelper.createSalt();
        String credentials = PasswordHelper.createCredentials(customer.getPassword(), salt);
        customer.setStatus(0);
        customer.setSalt(salt);
        customer.setPassword(credentials);
        String flag = customerService.save(customer);
        if ("true".equals(flag)){
            return "forepage/registerSuccess";
        }else {
            model.addAttribute("error","true");
            return "forepage/foreRegister";
        }

    }

    //跳转登录界面
    @RequestMapping("/foreLoginUI")
    public String foreLoginUI(){
        return "forepage/forelogin";
    }

    //ajax判断是否登录
    @RequestMapping("/foreIsLogin")
    @ResponseBody
    public String IsLogin(HttpSession session){
        Customer cst = (Customer) session.getAttribute("cst");
        return cst == null ? "false":"true";
    }

    //用户窗口登录验证
    @RequestMapping("/foreMtLogin")
    @ResponseBody
    public String foreIsLogin(Customer customer,HttpSession session){
        Subject subject = SecurityUtils.getSubject();
        CustomizedToken customizedToken = new CustomizedToken(customer.getName(), customer.getPassword(), CUSTOMER_LOGIN_TYPE);

        try {
            subject.login(customizedToken);
            Customer cst = customerService.findByName(customer.getName());
            session.setAttribute("cst", cst);
            return "true";
        }catch (Exception e){
            return "false";
        }

    }

    //用户登录
    @RequestMapping("/foreLogin")
    public String foreLogin(HttpSession session, Customer customer,Model model){
        Subject subject = SecurityUtils.getSubject();
        CustomizedToken customizedToken = new CustomizedToken(customer.getName(), customer.getPassword(), CUSTOMER_LOGIN_TYPE);
        try {
            //这里会跳转CustomerRealm中的认证方法
            subject.login(customizedToken);
            Customer cst = customerService.findByName(customer.getName());
            session.setAttribute("cst" ,cst);
            return "redirect:foreIndex";

            } catch (Exception e){
            model.addAttribute("msg","false");
            return "forepage/forelogin";
        }
    }

    //用户退出
    @RequestMapping("/foreCstLoginOut")
    public String foreCstLoginOut(HttpSession session){
        session.setAttribute("cst",null);
        return "redirect:foreIndex";
    }

    //显示分类下的商品
    @RequestMapping("/foreFindCategory")
    public String foreFindCategory(Model model,Page page,@RequestParam("id") int cid){
        PageHelper.offsetPage(page.getStart(),page.getCount());

        List<Product> products = productService.findProByCid(cid);
        Category category = categoryService.findById(cid);

        int total = (int) new PageInfo<>(products).getTotal();
        page.setTotal(total);
        List<Integer> beginandEnd = page.getBeginandEnd(page);
        int begin = beginandEnd.get(0);
        int end = beginandEnd.get(1);

        model.addAttribute("products",products);
        model.addAttribute("category",category);
        model.addAttribute("page",page);
        model.addAttribute("begin",begin);
        model.addAttribute("end",end);
        model.addAttribute("total",total);

        return "forepage/proCategorySeach";
    }



    //搜索菜品
    @RequestMapping("/foreNameLike")
    public String foreNameLike(Model model, String pname, Page page){

        PageHelper.offsetPage(page.getStart(),page.getCount());
        if(pname!=null) PNAME = pname;
        List<Product> products = productService.findByName(PNAME);
        int total = (int) new PageInfo<>(products).getTotal();
        page.setTotal(total);

        List<Integer> beginandEnd = page.getBeginandEnd(page);
        int begin = beginandEnd.get(0);
        int end = beginandEnd.get(1);

        model.addAttribute("begin",begin);
        model.addAttribute("end",end);
        model.addAttribute("products",products);
        model.addAttribute("total",total);
        model.addAttribute("page", page);

        return "forepage/proSearch";



    }


    //商品详情跳转
    @RequestMapping("/foreDetailUI")
    public String foreDetailUI(@RequestParam("id") int id,Model model){
        Product product = productService.findByid(id);
        if(product == null){
            return "forepage/noPro";
        }
        User user = productService.getUserByBid(product.getBid());
        List<Product> fivePro = productService.getFivePro();
        List<Review> reviews = reviewService.getReviewListByPid(id);


        model.addAttribute("p",product);
        model.addAttribute("user",user);
        model.addAttribute("fivePro",fivePro);
        model.addAttribute("reviews",reviews);


        return "forepage/proDetail";

    }

    //立即购买
    @RequestMapping("/forebuyone")
    public String forebuyone(HttpSession session,int pid,int number){
        Customer cst = (Customer) session.getAttribute("cst");
        Product product = productService.findByid(pid);

        int oiid = 0;
        boolean find = false;

        List<OrderItem> orderItemList = oderItemService.findItemByCstid(cst.getId());
        for (OrderItem orderItem : orderItemList){
            if(orderItem.getPid().equals(product.getId())){
                orderItem.setNumber(orderItem.getNumber()+number);
                oderItemService.update(orderItem);
                find = true;
                oiid = orderItem.getId();
            }
        }
        if(!find){

            OrderItem oi  = new OrderItem();
            oi.setCstid(cst.getId());
            oi.setPid(product.getId());
            oi.setNumber(number);
            oderItemService.save(oi);
            oiid = oi.getId();
        }

        return "redirect:forebuy?oiid="+oiid;
    }

    //跳转购买界面
    @RequestMapping("/forebuy")
    public String forebuy(Model model,String[] oiid,HttpSession session){
        Customer cst = (Customer) session.getAttribute("cst");
        List<OrderItem> ois = new ArrayList<>();

        float total = 0;
        int number = 0;
        for(String s :oiid){
            int id = Integer.parseInt(s);
            OrderItem orderItem = oderItemService.get(id);
            if(cst.getStatus() == 1){
                total += orderItem.getProduct().getPrice() * 0.8 * orderItem.getNumber();
            }else {
                total += orderItem.getProduct().getPrice() * orderItem.getNumber();
            }
            number += orderItem.getNumber();
            ois.add(orderItem);
        }
        //防止不精确
        BigDecimal b =new BigDecimal(Float.toString(total));

        session.setAttribute("ois",ois);
        model.addAttribute("total", b);
        model.addAttribute("number", number);
        return "forepage/foreBuy";
    }


    //添加购物车
    @RequestMapping("/foreAddCart")
    @ResponseBody
    public String foreAddCart(int pid,int number,HttpSession session){

        Customer cst = (Customer) session.getAttribute("cst");
        if(cst == null){
            return "false";
        }

        Product product = productService.findByid(pid);
        boolean find = false;

        List<OrderItem> orderItemList = oderItemService.findItemByCstid(cst.getId());
        for (OrderItem orderItem : orderItemList){
            if(orderItem.getPid().equals(product.getId())){
                orderItem.setNumber(orderItem.getNumber()+number);
                oderItemService.update(orderItem);
                find = true;
            }
        }
        if(!find){
            OrderItem oi  = new OrderItem();
            oi.setCstid(cst.getId());
            oi.setPid(pid);
            oi.setNumber(number);
            oderItemService.save(oi);
        }
        return "success";
    }

    //更新购物车中的数量
    @RequestMapping("/changeCartNum")
    public String changeCartNum(@RequestParam("number")int num,@RequestParam("oiid")int oiid){
        OrderItem orderItem = oderItemService.get(oiid);
        //如果数量小于0则删除订单项
        if(num <= 0){
            oderItemService.deleteById(oiid);
            return "redirect:forecart";
        }else {
            orderItem.setNumber(num);
            oderItemService.update(orderItem);
            return "redirect:forecart";
        }

    }

    //查看购物车
    @RequestMapping("/forecart")
    public String forecart(HttpSession session,Model model){
        //获取顾客信息
        Customer cst = (Customer) session.getAttribute("cst");
        //查看顾客的订单项
        List<OrderItem> orderItemList = oderItemService.findItemByCstid(cst.getId());
        //跳转没有订单项界面
        if(orderItemList == null || orderItemList.size() == 0){
            return "forepage/cart_noPro";
        }

        int totalProductNumber = 0;//商品总数量
        float totalPrice = 0;   //商品总价格

        for (OrderItem oi:orderItemList){
            totalProductNumber += oi.getNumber();
            if(cst.getStatus() == 1){
                totalPrice += oi.getProduct().getPrice() * 0.8 * oi.getNumber();
            }else {
                totalPrice += oi.getProduct().getPrice() * oi.getNumber();
            }
        }

        model.addAttribute("ois",orderItemList);
        model.addAttribute("totalProductNumber",totalProductNumber);
        model.addAttribute("totalPrice",totalPrice);

        return "forepage/foreCart";
    }

    //删除订单项
    @RequestMapping("/foreDelOrderItem")
    @ResponseBody
    public String foreDelOrderItem(int oiid,HttpSession session){
        Customer cst = (Customer) session.getAttribute("cst");
        if (cst == null){
            return "false";
        }
        oderItemService.deleteById(oiid);
        return "success";
    }

    //提交订单
    @RequestMapping("/foreCreateOrder")
    public String foreCreateOrder(String address,HttpSession session){
        Customer cst = (Customer) session.getAttribute("cst");
        String ordercode = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + RandomUtils.nextInt(10000);

        // 给订单设置code，客户id，支付状态和地址
        Order order = new Order();
        order.setCstid(cst.getId());
        order.setCode(ordercode);
        order.setAddress(address);
        order.setStatus(0);

        //给每个订单项设置订单ID
        List<OrderItem> ois = (List<OrderItem>) session.getAttribute("ois");
        float totalPrice = orderService.add(order, ois,cst);

        return "redirect:forePayed?oid="+order.getId() +"&total="+totalPrice;
    }

    //支付成功跳转
    @RequestMapping("/forePayed")
    public String forePayed(Model model,float total,int oid){
        Order order = orderService.get(oid);
        order.setStatus(1);
        orderService.update(order);

        model.addAttribute("total",total);

        return "forepage/forePayed";
    }

    //查看订单
    @RequestMapping("/forebought")
    public String forebought(Model model,HttpSession session){
        Customer cst = (Customer) session.getAttribute("cst");
        List<Order> orders = orderService.findByCstid(cst.getId());
        //给订单设置了orderItem属性
        oderItemService.setOI(orders,cst);
        model.addAttribute("os",orders);
        return "forepage/foreBought";
    }


    //查看过审核的资讯
    @RequestMapping("/foreZixuns")
    public String foreZixuns(Model model){
        List<ZiXun> list = zixunService.findAll();
        model.addAttribute("list",list);
        return "forepage/foreZixun";
    }

    //发布资讯
    @RequestMapping("/foreZixunadd")
    @ResponseBody
    public String foreZixunadd(HttpSession session,String content){
        Customer cst = (Customer) session.getAttribute("cst");
        ZiXun ziXun = new ZiXun();
        ziXun.setContent(content);
        ziXun.setCstid(cst.getId());
        ziXun.setFabudate(new Date());
        ziXun.setStatus(0);
        zixunService.save(ziXun);
        return "success";
    }


    //faq
    @RequestMapping("/faq")
    public String faq(){
        return "forepage/faq";
    }


    //商品评论
    @RequestMapping("/cstPinglun")
    @ResponseBody
    public String cstPinglun(int pid,String content,HttpSession session){
        Customer cst = (Customer) session.getAttribute("cst");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String format = sdf.format(new Date());
        //String 转 Date
        ParsePosition parsePosition = new ParsePosition(0);
        Date date = sdf.parse(format, parsePosition);

        Review review = new Review();
        review.setContent(content);
        review.setCstid(cst.getId());
        review.setPid(pid);
        review.setCreatetime(date);

        reviewService.save(review);

        return "success";
    }
}
