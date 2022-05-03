package com.tjnu.shop.mapper;

import com.tjnu.shop.bean.Product;

import java.util.List;

/**
 * ClassName: ProductMapper
 * date: 2021/5/19/019
 *
 * @author zlk
 */
public interface ProductMapper {
    List<Product> ProductList();
    List<Product> P_CList(Integer categoryId);
    int updateProductById(Product product);
    int addProduct(Product product);
    List<Product> selectBySearch(String name);
    int delProduct(Integer[] ids);
    Integer countProduct(String cname);
}
