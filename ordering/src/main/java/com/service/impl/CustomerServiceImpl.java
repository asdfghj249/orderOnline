package com.service.impl;

import com.dao.CategoryMapper;
import com.dao.CustomerMapper;
import com.pojo.CategoryExample;
import com.pojo.Customer;
import com.pojo.CustomerExample;
import com.service.ICustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CustomerServiceImpl implements ICustomerService {

    @Autowired
    private CustomerMapper customerMapper;

    @Override
    public Customer foreLogin(Customer customer) {
        CustomerExample example = new CustomerExample();
        example.createCriteria().andNameEqualTo(customer.getName()).andPasswordEqualTo(customer.getPassword());
        List<Customer> customers = customerMapper.selectByExample(example);
        return customers.size()>0?customers.get(0):null;
    }

    @Override
    public String save(Customer customer) {
        CustomerExample example = new CustomerExample();
        example.createCriteria().andNameEqualTo(customer.getName());
        List<Customer> customers = customerMapper.selectByExample(example);
        if (customers.size() == 0){
            customerMapper.insert(customer);
            return "true";
        }else {
            return "false";
        }

    }

    @Override
    public List<Customer> findAll() {
       return customerMapper.selectByExample(null);
    }

    @Override
    public Customer findByName(String name) {
        CustomerExample example = new CustomerExample();
        example.createCriteria().andNameEqualTo(name);
        List<Customer> customers = customerMapper.selectByExample(example);
        return customers.size()>0?customers.get(0):null;
    }

    @Override
    public Customer findByid(int id) {
        return customerMapper.selectByPrimaryKey(id);
    }

    @Override
    public void shezhihuiyuan(int id) {
        customerMapper.shezhihuiyuan(id);
    }

    @Override
    public void quxiaohuiyuan(int id) {
        customerMapper.quxiaohuiyuan(id);
    }

    @Override
    public void del(int id) {
        customerMapper.deleteByPrimaryKey(id);
    }
}
