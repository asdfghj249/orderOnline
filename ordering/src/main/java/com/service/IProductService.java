package com.service;

import com.pojo.Product;
import com.pojo.ProductVO;
import com.pojo.User;

import java.util.List;

public interface IProductService {

    //查询所有商品
    public List<Product> findAll();

    //根据bid查询商品
    public List<Product> findByBid(long id);

    //
    public void setCateAndUser(List<Product> products);

    //增加商品
    public void save(Product product);

    //更新商品
    public void update(Product product);

    //删除商品
    public void del(int id);

    //设置商品图片保存位置
    public void setImageURL(ProductVO vo);

    //搜索商品
    public List<Product> findByName(String pname);

    //根据cid查找菜品
    public  List<Product> findByCid(int cid);

    //根据id查询菜品信息
    public Product findByid(int id);

    //根据bid获得商家信息
    public User getUserByBid(long id);

    //随机获得五条商品
    public List<Product> getFivePro();

    //根据cid查询菜品
    public List<Product> findProByCid(int id);

    //商品上线
    public void startStatus(int id);

    //商品下线
    public void stopStatus(int id);

    //判断分类下是否有商品
    public boolean findProductByCid(int id);

}
