package com.service.impl;

import com.dao.PermissionMapper;
import com.pojo.Permission;
import com.service.IPermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PermissionServiceImpl implements IPermissionService {
    
    @Autowired
    private PermissionMapper permissionMapper;
    

    @Override
    public Permission findById(long id) {
        Permission permission = permissionMapper.selectByPrimaryKey(id);
        return permission;
    }

    @Override
    public List<Permission> findAll() {
        return permissionMapper.selectByExample(null);
    }

    @Override
    public void save(Permission permission) {
        permissionMapper.insertSelective(permission);
    }

    @Override
    public void update(Permission permission) {
        permissionMapper.updateByPrimaryKeySelective(permission);
    }

    @Override
    public void delete(long id) {
        permissionMapper.deleteByPrimaryKey(id);
    }
}
