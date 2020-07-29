package com.controller;

import com.pojo.Permission;
import com.pojo.Role;
import com.pojo.RolePermission;
import com.service.IPermissionService;
import com.service.IRolePermissionService;
import com.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/role")
public class RoleController {

    @Autowired
    private IRoleService roleService;
    @Autowired
    private IRolePermissionService rolePermissionService;
    @Autowired
    private IPermissionService permissionService;


    //角色列表
    @RequestMapping("/list")
    public String list(Model model){
        List<Role> roles = roleService.findAll();

        //给每个角色添加permission属性
        for(Role r:roles){

            List<Permission> permissionList = new ArrayList<>();
            List<RolePermission> rolePermissions = rolePermissionService.findByRid(r.getId());
            for(RolePermission rp:rolePermissions){
                Permission permission = permissionService.findById(rp.getPid());
                permissionList.add(permission);
            }
            r.setPermissions(permissionList);
        }

        model.addAttribute("roles",roles);

        return "syspage/admin-role";
    }

    //添加角色界面
    @RequestMapping("/addRoleUI")
    public String addRoleUI(){
        return "syspage/admin-role-add";
    }

    //添加角色
    @RequestMapping("/addRole")
    public String addRole(Role role){
        roleService.save(role);
        return "redirect:list";
    }

    //编辑角色界面
    @RequestMapping("/editRoleUI")
    public String editRoleUI(Model model, @RequestParam("id") long id){
        //获取当前角色
        Role role = roleService.findById(id);
        //获取所有权限
        List<Permission> permissions = permissionService.findAll();
        //获取当前角色的权限
        List<Permission> permissionList = new ArrayList<>();
        List<RolePermission> rolePermissions = rolePermissionService.findByRid(role.getId());
        for(RolePermission rp:rolePermissions){
            Permission permission = permissionService.findById(rp.getPid());
            permissionList.add(permission);
        }

        model.addAttribute("currentPermissions",permissionList);
        model.addAttribute("role",role);
        model.addAttribute("permissions",permissions);
        return "syspage/admin-role-edit";
    }

    //更新角色信息
    @RequestMapping("/updateRole")
    public String updateRole(Role role,long[] permissionIds){
        //给角色设置权限
        roleService.setPermissions(role,permissionIds);
        roleService.update(role);
        return "redirect:list";
    }

    //删除角色
    @RequestMapping("/deleteRole")
    public String deleteRole(@RequestParam("id")long id){
        roleService.delete(id);
        return "redirect:list";
    }

}
