package com.service.impl;

import com.dao.CustomerMapper;
import com.dao.ReviewMapper;
import com.pojo.Customer;
import com.pojo.Review;
import com.pojo.ReviewExample;
import com.service.IReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class ReviewServiceImpl implements IReviewService {

    @Autowired
    private ReviewMapper reviewMapper;
    @Autowired
    private CustomerMapper customerMapper;

    @Override
    public List<Review> findAll() {
       return reviewMapper.selectByExample(null);
    }

    @Override
    public List<Review> getReviewListByPid(int id) {
        ReviewExample example = new ReviewExample();
        example.createCriteria().andPidEqualTo(id);
        List<Review> reviews = reviewMapper.selectByExample(example);

        for(Review r:reviews){
            Customer customer = customerMapper.selectByPrimaryKey(r.getCstid());
            r.setCustomer(customer);
        }
        return reviews;
    }

    @Override
    public void save(Review review) {
        reviewMapper.insert(review);
    }

    @Override
    public void delete(int id) {
        reviewMapper.deleteByPrimaryKey(id);
    }
}
