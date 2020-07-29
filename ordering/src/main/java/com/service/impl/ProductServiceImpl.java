package com.service.impl;

import com.dao.ProductMapper;
import com.dao.UserMapper;
import com.pojo.*;
import com.service.ICategoryService;
import com.service.IProductService;
import com.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class ProductServiceImpl implements IProductService {

    @Autowired
    private ProductMapper productMapper;
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private ICategoryService categoryService;
    @Autowired
    private IUserService userService;

    @Override
    public List<Product> findAll() {
       return productMapper.selectByExample(null);
    }

    @Override
    public List<Product> findByBid(long id) {
        ProductExample example = new ProductExample();
        example.createCriteria().andBidEqualTo(id);
        List<Product> products = productMapper.selectByExample(example);
        return products;
    }

    @Override
    public void setCateAndUser(List<Product> products) {
        for(Product p:products){
            Category category = categoryService.findById(p.getCid());
            User user = userService.findById(p.getBid());
            p.setCategory(category);
            p.setUser(user);
        }
    }

    @Override
    public void save(Product product) {
        product.setStatus(1);
        productMapper.insert(product);
    }

    @Override
    public void update(Product product) {
        productMapper.updateByPrimaryKeySelective(product);
    }

    @Override
    public void del(int id) {
        productMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void setImageURL(ProductVO vo) {
        productMapper.setImageUrl(vo);
    }

    @Override
    public List<Product> findByName(String pname) {
        ProductExample example = new ProductExample();
        example.createCriteria().andNameLike("%"+pname+"%");
        List<Product> products = productMapper.selectByExample(example);
        return products;
    }

    @Override
    public List<Product> findByCid(int cid) {
        ProductExample example = new ProductExample();
        example.createCriteria().andCidEqualTo(cid);
        List<Product> products = productMapper.selectByExample(example);
        return products;
    }

    @Override
    public Product findByid(int id) {
        Product product = productMapper.selectByPrimaryKey(id);
        return product;
    }

    @Override
    public User getUserByBid(long id) {
        return userMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Product> getFivePro() {
        List<Product> fivePro = productMapper.getFivePro();
        return fivePro;
    }

    @Override
    public List<Product> findProByCid(int id) {
        ProductExample example = new ProductExample();
        example.createCriteria().andCidEqualTo(id);
        List<Product> products = productMapper.selectByExample(example);
        return products;
    }

    @Override
    public void startStatus(int id) {
        productMapper.startStatus(id);
    }

    @Override
    public void stopStatus(int id) {
        productMapper.stopStatus(id);
    }

    @Override
    public boolean findProductByCid(int id) {

        List<Product> products = findProByCid(id);

        return products.size()>0?true:false;
    }


}
