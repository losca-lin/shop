package com.tjnu.shop.bean;


import lombok.Data;

import java.util.Date;

/**
 * ClassName: Category
 * date: 2021/5/26/026
 *
 * @author zlk
 */
@Data
public class Category {
    private Integer id;
    private Integer parentId;
    private String name;
    private Integer status;
    private Date createTime;
    private Date updateTime;

}
