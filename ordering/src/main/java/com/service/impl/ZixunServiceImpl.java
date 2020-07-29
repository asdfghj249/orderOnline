package com.service.impl;

import com.dao.CustomerMapper;
import com.dao.ZiXunMapper;
import com.pojo.Customer;
import com.pojo.ZiXun;
import com.pojo.ZiXunExample;
import com.service.IZixunService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class ZixunServiceImpl implements IZixunService {

    @Autowired
    private ZiXunMapper ziXunMapper;
    @Autowired
    private CustomerMapper customerMapper;

    @Override
    public List<ZiXun> findAll() {
        ZiXunExample example = new ZiXunExample();
        example.createCriteria().andStatusEqualTo(1);
        List<ZiXun> ziXuns = ziXunMapper.selectByExample(example);
        for(ZiXun z:ziXuns){
            Customer customer = customerMapper.selectByPrimaryKey(z.getCstid());
            z.setCustomer(customer);
        }
        return ziXuns;
    }

    @Override
    public void save(ZiXun ziXun) {
        ziXunMapper.insert(ziXun);
    }

    @Override
    public List<ZiXun> find() {
        ZiXunExample example = new ZiXunExample();
        List<ZiXun> ziXuns = ziXunMapper.selectByExample(example);
        return ziXuns;
    }

    @Override
    public void delete(int id) {
        ziXunMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void zixunshenhe(int id) {
        ziXunMapper.zixunshenhe(id);
    }
}
