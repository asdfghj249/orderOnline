package com.service.impl;

import com.dao.CategoryMapper;
import com.dao.ProductMapper;
import com.pojo.Category;
import com.pojo.CategoryExample;
import com.pojo.Product;
import com.service.ICategoryService;
import com.service.IProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class CategoryServiceImpl implements ICategoryService {

    @Autowired
    private CategoryMapper categoryMapper;
    @Autowired
    private ProductMapper productMapper;
    @Autowired
    private IProductService productService;

    @Override
    public List<Category> findAll() {
        return categoryMapper.selectByExample(null);
    }

    @Override
    public void save(Category category) {
        categoryMapper.insert(category);
    }

    @Override
    public void update(Category category) {
        categoryMapper.updateByPrimaryKeySelective(category);
    }

    @Override
    public void del(int id) {
        categoryMapper.deleteByPrimaryKey(id);
    }

    @Override
    public List<Category> findFour() {
        CategoryExample example = new CategoryExample();
        example.createCriteria().andIdBetween(1,4);
        List<Category> categories = categoryMapper.selectByExample(example);
        return categories;
    }

    @Override
    public Category findById(int id) {
        return categoryMapper.selectByPrimaryKey(id);
    }

    @Override
    public Category findByPid(int id) {
        Product product = productMapper.selectByPrimaryKey(id);
        Category category = categoryMapper.selectByPrimaryKey(product.getCid());
        return category;
    }
}
