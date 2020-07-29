package com.realm;

import com.pojo.Customer;
import com.pojo.User;
import com.service.IUserService;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import javax.annotation.Resource;


public class UserRealm extends AuthorizingRealm {

    @Resource
    private IUserService userService;

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        return null;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        User user = null;
        // 1. 把AuthenticationToken转换为CustomizedToken
        CustomizedToken customizedToken = (CustomizedToken) token;
        // 2. 从CustomizedToken中获取name
        String name = customizedToken.getUsername();
        // 3. 若用户不存在，抛出UnknownAccountException异常
        user = userService.findByName(name);
        if (user == null)
            throw new UnknownAccountException("用户不存在！");

        SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(
                user.getName(), user.getPassword(), ByteSource.Util.bytes(user.getSalt()),
                this.getName());
        return info;

    }
}
