package com.service;

import com.pojo.Permission;
import com.pojo.RolePermission;

import java.util.List;

public interface IPermissionService {

    //根据id查询
    public Permission findById(long id);

    //查询所有
    public List<Permission> findAll();

    //增加
    public void save(Permission permission);

    //更新
    public void update(Permission permission);

    //删除
    public void  delete(long id);

}
