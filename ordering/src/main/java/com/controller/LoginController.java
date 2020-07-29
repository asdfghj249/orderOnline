package com.controller;

import com.pojo.Customer;
import com.pojo.User;
import com.pojo.UserRole;
import com.realm.CustomizedToken;
import com.realm.LoginType;
import com.service.IRoleService;
import com.service.IUserRoleService;
import com.service.IUserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * 后台登录
 */
@Controller
@RequestMapping("")
public class LoginController {

    @Autowired
    private IUserService userService;
    @Autowired
    private IUserRoleService userRoleService;
    @Autowired
    private IRoleService roleService;

    private static final String USER_LOGIN_TYPE = LoginType.USER.toString();

    //后台首页
    @RequestMapping("index")
    public String index(){
        return "index";
    }

    //跳转后台登录界面
    @RequestMapping("/loginUI")
    public String loginUI(){
        return "login";
    }

    //后台登录
    @RequestMapping("/login")
    public String login(HttpSession session,Model model,User user){
        Subject subject = SecurityUtils.getSubject();
        CustomizedToken customizedToken = new CustomizedToken(user.getName(), user.getPassword(), USER_LOGIN_TYPE);

        try{
            //这里会跳转UserRealm中的认证方法
            subject.login(customizedToken);
            User loginUser = userService.findByName(user.getName());

            List<String> names = new ArrayList<>();
            List<UserRole> userRoles = userRoleService.findByUid(loginUser.getId());

            for (UserRole u:userRoles){
                String name = roleService.findName(u.getRid());
                names.add(name);
            }
            boolean b = names.contains("admin");

            if (loginUser.getStatus() == 1){
                session.setAttribute("b",b);
                session.setAttribute("user",loginUser);
                return "redirect:index";

            }else {
                model.addAttribute("error","账号已停用！");
                return "login";
            }

        }catch (Exception e){
            model.addAttribute("error","账号或密码错误！");
            return "login";
        }
    }



    //退出
    @RequestMapping("/logOut")
    public String logOut(HttpSession session){
        session.setAttribute("user",null);
        return "redirect:loginUI";
    }



}
