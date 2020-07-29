package com.service.impl;

import com.dao.ProductMapper;
import com.dao.RolePermissionMapper;
import com.dao.UserMapper;
import com.dao.UserRoleMapper;
import com.pojo.*;
import com.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements IUserService {
    
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private ProductMapper productMapper;
    @Autowired
    private UserRoleMapper userRoleMapper;

    @Override
    public List<User> findAll() {
        return userMapper.selectByExample(null);
    }

    @Override
    public void save(User user) {
        userMapper.insertSelective(user);
    }

    @Override
    public void delete(long id) {
        userMapper.deleteByPrimaryKey(id);

        //删除user-role表中的相关信息
        UserRoleExample example = new UserRoleExample();
        example.createCriteria().andUidEqualTo(id);
        List<UserRole> userRoles = userRoleMapper.selectByExample(example);
        for (UserRole userRole:userRoles){
            userRoleMapper.deleteByPrimaryKey(userRole.getId());
        }
    }

    @Override
    public void update(User user) {
        userMapper.updateByPrimaryKeySelective(user);
    }

    @Override
    public User login(User user) {
        UserExample example = new UserExample();
        example.createCriteria().andNameEqualTo(user.getName()).andPasswordEqualTo(user.getPassword());
        List<User> users = userMapper.selectByExample(example);
        return users.size() > 0 ? users.get(0) : null;
    }

    @Override
    public User findById(long id) {
        return userMapper.selectByPrimaryKey(id);
    }

    @Override
    public User findByName(String name) {
        UserExample example = new UserExample();
        example.createCriteria().andNameEqualTo(name);
        List<User> users = userMapper.selectByExample(example);
        return users.size() > 0 ? users.get(0) : null;
    }

    @Override
    public User findByPid(int id) {
        Product product = productMapper.selectByPrimaryKey(id);
        User user = userMapper.selectByPrimaryKey(product.getBid());
        return user;
    }

    @Override
    public void startStatus(long id) {
        userMapper.startStatus(id);
    }

    @Override
    public void stopStatus(long id) {
        userMapper.stopStatus(id);
    }
}
