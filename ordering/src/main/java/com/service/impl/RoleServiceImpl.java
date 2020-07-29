package com.service.impl;

import com.dao.RoleMapper;
import com.dao.RolePermissionMapper;
import com.pojo.Role;
import com.pojo.RolePermission;
import com.pojo.RolePermissionExample;
import com.service.IReviewService;
import com.service.IRolePermissionService;
import com.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleServiceImpl implements IRoleService {

    @Autowired
    private RoleMapper roleMapper;
    @Autowired
    private RolePermissionMapper rolePermissionMapper;
    @Autowired
    private IRolePermissionService rolePermissionService;

    @Override
    public String findName(long id) {
        String name = roleMapper.selectByPrimaryKey(id).getName();
        return name;
    }

    @Override
    public List<Role> findAll() {
        return roleMapper.selectByExample(null);
    }

    @Override
    public Role findById(long id) {
        return roleMapper.selectByPrimaryKey(id);
    }

    @Override
    public void save(Role role) {
        roleMapper.insert(role);
    }

    @Override
    public void update(Role role) {
        roleMapper.updateByPrimaryKeySelective(role);
    }

    @Override
    public void setPermissions(Role role, long[] permissionIds) {
        //删除当前角色的所有权限
        RolePermissionExample example = new RolePermissionExample();
        example.createCriteria().andRidEqualTo(role.getId());
        List<RolePermission> rolePermissions = rolePermissionMapper.selectByExample(example);
        for (RolePermission r:rolePermissions){
            rolePermissionMapper.deleteByPrimaryKey(r.getId());
        }

        //设置新的权限
        if(permissionIds != null){
            for(long pid :permissionIds){
                RolePermission rolePermission = new RolePermission();
                rolePermission.setPid(pid);
                rolePermission.setRid(role.getId());
                rolePermissionMapper.insert(rolePermission);
            }
        }
    }

    @Override
    public void delete(long id) {
        roleMapper.deleteByPrimaryKey(id);

        //删除role-permission表中的相关信息
        RolePermissionExample example = new RolePermissionExample();
        example.createCriteria().andRidEqualTo(id);
        List<RolePermission> rolePermissions = rolePermissionMapper.selectByExample(example);
        for(RolePermission r:rolePermissions){
            rolePermissionService.deleteByRid(r.getRid());
        }

    }
}
