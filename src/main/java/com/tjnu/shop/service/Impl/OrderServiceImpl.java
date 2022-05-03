package com.tjnu.shop.service.Impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.tjnu.shop.VO.ResponseVO;
import com.tjnu.shop.bean.Order;
import com.tjnu.shop.mapper.OrderMapper;
import com.tjnu.shop.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.UUID;

/**
 * ClassName: OrderServiceImpl
 * date: 2021/6/22/022
 *
 * @author zlk
 */
@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderMapper orderMapper;

    @Override
    public PageInfo listAll(Integer pageNum,Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        PageInfo<Order> pageInfo = PageInfo.of(orderMapper.listAllInUsername());
        return pageInfo;
    }

    @Override
    public ResponseVO delOrder(Integer[] ids) {
        int i = orderMapper.delOrder(ids);
        if (i == 0){
            return ResponseVO.failed(1100,"删除失败");
        }
        return ResponseVO.success();
    }

    @Override
    public ResponseVO addOrder(Order order) {
        /*生成订单号*/
        Long orderNo = System.currentTimeMillis();
        order.setOrderNo(orderNo);
        /*生成创建时间*/
        Date date = new Date();
        order.setCreateTime(date);
        if (orderMapper.addOrder(order) == 0){
            return ResponseVO.failed(1701,"生成失败");
        }
        return ResponseVO.success();
    }
}
