package com.tjnu.shop.mapper;

/**
 * ClassName: OrderMapper
 * date: 2021/6/21/021
 *
 * @author zlk
 */

import com.tjnu.shop.bean.Order;

import java.util.List;

public interface OrderMapper {

    /**
     * 查询所有记录
     *
     * @return 返回集合，没有返回空List
     */
    List<Order> listAll();

    List<Order> listAllInUsername();


    /**
     * 根据主键查询
     *
     * @param id 主键
     * @return 返回记录，没有返回null
     */
    Order getById(Integer id);


    /**
     * 修改，修改所有字段
     *
     * @param Order 修改的记录
     * @return 返回影响行数
     */
    int update(Order Order);


    /**
     * 删除记录
     *
     * @param ids 待删除的记录
     * @return 返回影响行数
     */
    int delOrder(Integer[] ids);

    int addOrder(Order order);

}

