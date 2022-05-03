package com.tjnu.shop.bean;

import lombok.Data;

import java.util.Date;

/**
 * ClassName: User
 * date: 2021/6/7/007
 *
 * @author zlk
 */
@Data
public class User {
    private Integer id;
    private String username;
    private String password;
    private String email;
    private String phone;
    private Date createTime;
    private Date updateTime;
}
