package com.tjnu.shop.service.Impl;

import com.tjnu.shop.bean.Category;
import com.tjnu.shop.mapper.CategoryMapper;
import com.tjnu.shop.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * ClassName: CategoryServiceImpl
 * date: 2021/5/31/031
 *
 * @author zlk
 */
@Service

public class CategoryServiceImpl implements CategoryService {
    @Autowired
    private CategoryMapper categoryMapper;
    @Override
    public List<Category> listLeafCategory() {
        return categoryMapper.listLeafCategory();
    }

    @Override
    public Category categoryById(Integer id) {
        return categoryMapper.categoryById(id);
    }
}
