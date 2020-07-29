package com.service.impl;

import com.dao.UserRoleMapper;
import com.pojo.User;
import com.pojo.UserRole;
import com.pojo.UserRoleExample;
import com.service.IUserRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserRoleServiceImpl implements IUserRoleService {

    @Autowired
    private UserRoleMapper userRoleMapper;


    @Override
    public List<UserRole> findByUid(long id) {
        UserRoleExample example = new UserRoleExample();
        example.createCriteria().andUidEqualTo(id);
        List<UserRole> userRoles = userRoleMapper.selectByExample(example);
        return userRoles;
    }

    @Override
    public void setRoles(User user, long[] id) {
        //删除当前管理员的所有角色关系
        UserRoleExample example = new UserRoleExample();
        example.createCriteria().andUidEqualTo(user.getId());
        List<UserRole> userRoles = userRoleMapper.selectByExample(example);
        for(UserRole ur:userRoles){
            userRoleMapper.deleteByPrimaryKey(ur.getId());
        }

        //增加管理员的角色关系
        if(id != null){
            for(long rid:id){
                UserRole userRole = new UserRole();
                userRole.setRid(rid);
                userRole.setUid(user.getId());
                userRoleMapper.insert(userRole);
            }
        }
    }
}
