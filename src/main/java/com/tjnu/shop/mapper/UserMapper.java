package com.tjnu.shop.mapper;

import com.tjnu.shop.bean.User;

import java.util.List;

/**
 * ClassName: UserMapper
 * date: 2021/6/7/007
 *
 * @author zlk
 */
public interface UserMapper {
    User selectById(Integer userId);
    User selectByUsername(String username);
    /*用户注册*/
    int insertUser(User user);
    int updateUser(User user);
    List<User> selectAll();
    /*管理员添加*/
    int addUser(User user);

    User selectByEmail(String email);
}
