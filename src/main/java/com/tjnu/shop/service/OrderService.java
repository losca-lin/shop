package com.tjnu.shop.service;

import com.github.pagehelper.PageInfo;
import com.tjnu.shop.VO.ResponseVO;
import com.tjnu.shop.bean.Order;

/**
 * ClassName: OrderService
 * date: 2021/6/22/022
 *
 * @author zlk
 */
public interface OrderService {
    PageInfo listAll(Integer pageNum,Integer pageSize);
    ResponseVO delOrder(Integer[] ids);
    ResponseVO addOrder(Order order);
}
