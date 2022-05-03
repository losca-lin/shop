package com.tjnu.shop.test;

import com.tjnu.shop.mapper.ProductMapper;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;


/**
 * ClassName: ProductMapperTest
 * date: 2021/6/18/018
 *
 * @author zlk
 */
public class ProductMapperTest {

    @Autowired
    ProductMapper productMapper;

   @Test
    public void list(){
       System.out.println(productMapper.countProduct("手机"));
   }
}