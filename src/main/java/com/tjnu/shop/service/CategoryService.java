package com.tjnu.shop.service;

import com.tjnu.shop.bean.Category;

import java.util.List;

/**
 * ClassName: CategoryService
 * date: 2021/5/31/031
 *
 * @author zlk
 */
public interface CategoryService {
    List<Category> listLeafCategory();
    /*根据id查询类别*/
    Category categoryById(Integer id);

}
