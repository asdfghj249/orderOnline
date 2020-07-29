package com.service.impl;

import com.dao.RolePermissionMapper;
import com.pojo.RolePermission;
import com.pojo.RolePermissionExample;
import com.service.IRolePermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RolePermissionServiceImpl implements IRolePermissionService {

    @Autowired
    private RolePermissionMapper rolePermissionMapper;


    @Override
    public List<RolePermission> findByRid(long id) {
        RolePermissionExample example = new RolePermissionExample();
        example.createCriteria().andRidEqualTo(id);
        List<RolePermission> rolePermissions = rolePermissionMapper.selectByExample(example);
        return rolePermissions;
    }

    @Override
    public void deleteByRid(long id) {
        RolePermissionExample example = new RolePermissionExample();
        example.createCriteria().andRidEqualTo(id);
        rolePermissionMapper.deleteByExample(example);
    }

}
