package com.service;

import com.pojo.Role;

import java.util.List;

public interface IRoleService {

    //根据id查询name
    public String findName(long id);

    //查询所有
    public List<Role> findAll();

    //根据id查询
    public Role findById(long id);

    //增加角色
    public void save(Role role);

    //更新角色信息
    public void update(Role role);

    //给角色设置权限
    public void setPermissions(Role role,long[] permissionIds);

    //删除角色
    public void delete(long id);
}
