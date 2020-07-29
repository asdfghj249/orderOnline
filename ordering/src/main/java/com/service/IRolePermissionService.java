package com.service;

import com.pojo.RolePermission;

import java.util.List;

public interface IRolePermissionService {

    //根据rid查询
    public List<RolePermission> findByRid(long id);

    //更加rid删除
    public void deleteByRid(long id);

}
