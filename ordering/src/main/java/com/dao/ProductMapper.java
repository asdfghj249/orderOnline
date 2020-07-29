package com.dao;

import com.pojo.Product;
import com.pojo.ProductExample;
import java.util.List;

import com.pojo.ProductVO;
import org.apache.ibatis.annotations.Param;

public interface ProductMapper {
    int countByExample(ProductExample example);

    int deleteByExample(ProductExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Product record);

    int insertSelective(Product record);

    List<Product> selectByExample(ProductExample example);

    Product selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Product record, @Param("example") ProductExample example);

    int updateByExample(@Param("record") Product record, @Param("example") ProductExample example);

    int updateByPrimaryKeySelective(Product record);

    int updateByPrimaryKey(Product record);

    List<Product> getFivePro();

    //商品上线
    void startStatus(int id);

    //商品下线
    void stopStatus(int id);

    //设置商品图片保存位置
    void setImageUrl(ProductVO vo);
}