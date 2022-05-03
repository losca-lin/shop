package com.tjnu.shop.mapper;

import com.tjnu.shop.bean.Category;

import java.util.List;

/**
 * ClassName: CategoryMapper
 * date: 2021/5/31/031
 *
 * @author zlk
 */
public interface CategoryMapper {
    List<Category> listLeafCategory();
    Category categoryById(Integer id);
}
