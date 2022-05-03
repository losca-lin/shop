package com.tjnu.shop.service.Impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.tjnu.shop.VO.ResponseVO;
import com.tjnu.shop.bean.Product;
import com.tjnu.shop.form.ProductForm;
import com.tjnu.shop.mapper.CategoryMapper;
import com.tjnu.shop.mapper.ProductMapper;
import com.tjnu.shop.service.ProductService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * ClassName: ProductServiceImpl
 * date: 2021/5/19/019
 *
 * @author zlk
 */
@Service




public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductMapper productMapper;
    @Autowired
    private CategoryMapper categoryMapper;
    @Override
    public PageInfo<Product> ProductList(Integer pageNum,Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        PageInfo pageInfo = PageInfo.of(productMapper.ProductList());
        return pageInfo;
    }

    @Override
    public PageInfo<Product> P_CList(Integer pageNum, Integer pageSize,Integer categoryId) {
        PageHelper.startPage(pageNum,pageSize);
        if (categoryId == -1) {
            categoryId = null;
        }
        PageInfo pageInfo = PageInfo.of(productMapper.P_CList(categoryId));
        return pageInfo;
    }

    @Override
    public ResponseVO updateProductById(Product product) {
        /*处理修改时间*/
        product.setUpdateTime(new Date());
        int i = productMapper.updateProductById(product);
        return i>0?ResponseVO.success():ResponseVO.failed(404,"修改失败");
    }

    @Override
    public ResponseVO addProduct(ProductForm productForm) {
        /*判断数据库中是否有此类别*/
        if (categoryMapper.categoryById(productForm.getCategoryId()) == null) {
            return ResponseVO.failed(1005,"类别不存在");
        }
        Product product = new Product();
        BeanUtils.copyProperties(productForm,product);
        /*处理两个时间*/
        Date date = new Date();
        product.setCreateTime(date);
        product.setUpdateTime(date);
        productMapper.addProduct(product);
        return ResponseVO.success();
    }

    @Override
    public PageInfo<Product> selectBySearch(Integer pageNum, Integer pageSize,String name) {
        PageHelper.startPage(pageNum,pageSize);
        PageInfo<Product> pageInfo = PageInfo.of(productMapper.selectBySearch(name));
        return pageInfo;
    }

    @Override
    public ResponseVO delProduct(Integer[] ids) {
        int i = productMapper.delProduct(ids);
        if (i == 0){
            return ResponseVO.failed(1100,"删除失败");
        }
        return ResponseVO.success();
    }

    /*根据类型名称查询数量多少*/
    @Override
    public Integer countProduct(String cname) {
        return productMapper.countProduct(cname);
    }


}
