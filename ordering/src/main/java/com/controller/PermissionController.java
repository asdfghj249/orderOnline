package com.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.pojo.Permission;
import com.service.IPermissionService;
import com.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/permission")
public class PermissionController {

    @Autowired
    private IPermissionService permissionService;


    //权限列表
    @RequestMapping("/list")
    public String list(Page page, Model model){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<Permission> permissions = permissionService.findAll();
        int total = (int) new PageInfo<>(permissions).getTotal();
        page.setTotal(total);
        int begin = page.getBeginandEnd(page).get(0);
        int end = page.getBeginandEnd(page).get(1);

        model.addAttribute("permissions",permissions);
        model.addAttribute("page",page);
        model.addAttribute("total",total);
        model.addAttribute("begin",begin);
        model.addAttribute("end",end);
        return "syspage/admin-permission";
    }

    //添加权限界面
    @RequestMapping("/adminPerAddUI")
    public String adminPerAddUI(){
        return "syspage/admin-permission-add";
    }

    //添加权限
    @RequestMapping("/addPermission")
    public String addPermission(Permission permission){
        permissionService.save(permission);
        return "redirect:list";
    }

    //编辑界面
    @RequestMapping("/editPermissionUI")
    public String editPermissionUI(@RequestParam("id") long id,Model model){
        Permission permission = permissionService.findById(id);

        model.addAttribute("permission",permission);
        return "syspage/admin-permission-edit";
    }


    //更新权限信息
    @RequestMapping("/updatePermission")
    public String updatePermission(Permission permission){
        permissionService.update(permission);
        return "redirect:list";
    }

    //删除权限
    @RequestMapping("/deletePermission")
    public String deletePermission(@RequestParam("id") long id){
        permissionService.delete(id);
        return "redirect:list";
    }

}
