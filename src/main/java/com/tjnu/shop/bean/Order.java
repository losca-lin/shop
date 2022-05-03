package com.tjnu.shop.bean;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * ClassName: Order
 * date: 2021/6/21/021
 *
 * @author zlk
 */
@Data
public class Order {
    /** 订单id */
    private Integer id;
    /** 订单号 */
    private Long orderNo;
    /** 用户id */
    private Integer userId;
    /** 实际付款金额，单位元，保留两位小数 */
    private BigDecimal payment;
    /** 创建时间 */
    @JsonFormat(pattern="yyyy-MM-dd HH:mm",timezone="GMT+8")
    private Date createTime;
    /** 更新时间 */
    private Date updateTime;

    private User user;
}
