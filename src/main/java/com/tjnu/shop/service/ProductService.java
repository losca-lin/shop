package com.tjnu.shop.service;

import com.github.pagehelper.PageInfo;
import com.tjnu.shop.VO.ResponseVO;
import com.tjnu.shop.bean.Product;
import com.tjnu.shop.form.ProductForm;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * ClassName: ProductService
 * date: 2021/5/19/019
 *
 * @author zlk
 */
public interface ProductService {
    PageInfo<Product> ProductList(Integer pageNum,Integer pageSize);
    PageInfo<Product> P_CList(Integer pageNum,Integer pageSize,Integer categoryId);
    ResponseVO updateProductById(Product product);
    ResponseVO addProduct(ProductForm productForm);
    PageInfo<Product> selectBySearch(Integer pageNum, Integer pageSize,String name);
    ResponseVO delProduct(Integer[] ids);
    Integer countProduct(String cname);
}
