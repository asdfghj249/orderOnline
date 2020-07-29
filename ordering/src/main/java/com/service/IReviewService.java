package com.service;

import com.pojo.Review;

import java.util.List;

public interface IReviewService {

    //查询所有
    public List<Review> findAll();

    //根据pid获得评论
    public List<Review> getReviewListByPid(int id);

    //增加评论
    public  void save(Review review);

    //删除评论
    public void delete(int id);
}
