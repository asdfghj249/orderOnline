package com.service;

import com.pojo.User;
import com.pojo.UserRole;

import java.util.List;

public interface IUserRoleService {

    //根据uid查询
    public List<UserRole> findByUid(long id);

    //增加role-permission相应的信息
    public void setRoles(User user,long[] id);
}
