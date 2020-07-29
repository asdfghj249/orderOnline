package com.realm;

import com.pojo.Customer;
import com.pojo.User;
import com.service.ICustomerService;
import com.service.IUserService;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import javax.annotation.Resource;

public class CustomerRealm extends AuthorizingRealm {

    @Resource
    private ICustomerService customerService;


    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        return null;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        /*String name=authenticationToken.getPrincipal().toString();
        String password=authenticationToken.getCredentials().toString();
        Customer customer = customerService.findByName(name);
        //拿到数据库中的用户信息，放入token凭证中，用于controler进行对比
        AuthenticationInfo info=new SimpleAuthenticationInfo(
                customer.getName(),
                customer.getPassword(),
                ByteSource.Util.bytes(customer.getSalt()),
                this.getName()
        );
        return info;
    }*/
        Customer customer = null;
        // 1. 把AuthenticationToken转换为CustomizedToken
        CustomizedToken customizedToken = (CustomizedToken) token;
        // 2. 从CustomizedToken中获取name
        String name = customizedToken.getUsername();
        // 3. 若用户不存在，抛出UnknownAccountException异常
        customer = customerService.findByName(name);
        if (customer == null)
            throw new UnknownAccountException("用户不存在！");

        SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(
                customer.getName(), customer.getPassword(), ByteSource.Util.bytes(customer.getSalt()),
                this.getName());
        return info;
    }
}
