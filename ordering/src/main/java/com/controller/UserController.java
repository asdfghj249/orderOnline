package com.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.pojo.Permission;
import com.pojo.Role;
import com.pojo.User;
import com.pojo.UserRole;
import com.service.IRoleService;
import com.service.IUserRoleService;
import com.service.IUserService;
import com.util.Page;
import com.util.PasswordHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private IUserService userService;
    @Autowired
    private IRoleService roleService;
    @Autowired
    private IUserRoleService userRoleService;


    //管理员列表
    @RequestMapping("/list")
    public String list(Page page, Model model){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<User> users = userService.findAll();
        int total = (int) new PageInfo<>(users).getTotal();
        page.setTotal(total);
        int begin = page.getBeginandEnd(page).get(0);
        int end = page.getBeginandEnd(page).get(1);

        //给管理员设置role属性
        for(User u:users){
            List<Role> roles = new ArrayList<>();
            List<UserRole> userRoles = userRoleService.findByUid(u.getId());
            for(UserRole ur:userRoles){
                Role role = roleService.findById(ur.getRid());
                roles.add(role);
            }
            u.setRoles(roles);
        }
        model.addAttribute("users",users);
        model.addAttribute("page",page);
        model.addAttribute("total",total);
        model.addAttribute("begin",begin);
        model.addAttribute("end",end);
        return "syspage/admin-list";
    }

    //添加管理员界面
    @RequestMapping("/adminAddUI")
    public String adminAddUI(Model model){
        List<Role> roles = roleService.findAll();

        model.addAttribute("roles",roles);
        return "syspage/admin-add";
    }

    //添加管理员
    @RequestMapping("/addUser")
    public String addUser(User user,long[] roleId){
        String salt= PasswordHelper.createSalt();
        String credentials = PasswordHelper.createCredentials(user.getPassword(), salt);

        User u = new User();
        u.setName(user.getName());
        u.setPassword(credentials);
        u.setStatus(1);
        u.setSalt(salt);
        u.setAddress(user.getAddress());
        u.setPhone(user.getPhone());
        userService.save(u);
        //这是role-permission表信息
        userRoleService.setRoles(u,roleId);

        return "redirect:list";
    }

    //修改界面
    @RequestMapping("/editUserUI")
    public String editUserUI(@RequestParam("id")long id,Model model){
        User user = userService.findById(id);
        //当前管理员所拥有的角色
        List<Role> currentRoles = new ArrayList<>();
        List<UserRole> userRoles = userRoleService.findByUid(id);
        for(UserRole ur:userRoles){
            Role role = roleService.findById(ur.getRid());
            currentRoles.add(role);
        }
        //查询所有角色
        List<Role> roles = roleService.findAll();


        model.addAttribute("user",user);
        model.addAttribute("currentRoles",currentRoles);
        model.addAttribute("roles",roles);
        return "syspage/admin-edit";
    }

    //修改信息
    @RequestMapping("/updateUser")
    public String updateUser(User user,long[] roleIds){
        String salt= PasswordHelper.createSalt();
        String credentials = PasswordHelper.createCredentials(user.getPassword(), salt);
        User u = new User();
        user.setSalt(salt);
        user.setPassword(credentials);
        userRoleService.setRoles(user,roleIds);
        userService.update(user);
        return "redirect:list";
    }

    //删除管理员
    @RequestMapping("/deleteUser")
    public String deleteUser(@RequestParam("id")long id){
        userService.delete(id);
        return "redirect:list";
    }


    //启用
    @RequestMapping("/startStatus")
    @ResponseBody
    public String startStatus(long uid){
        userService.startStatus(uid);
        return "success";
    }

    //停用
    @RequestMapping("/stopStatus")
    @ResponseBody
    public String stopStatus(long uid){
        userService.stopStatus(uid);
        return "success";
    }

}
