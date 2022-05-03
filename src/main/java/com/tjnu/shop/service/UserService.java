package com.tjnu.shop.service;

import com.tjnu.shop.VO.LayUiVO;
import com.tjnu.shop.VO.ResponseVO;
import com.tjnu.shop.bean.User;
import com.tjnu.shop.form.ForgetForm;
import com.tjnu.shop.form.UserForm;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * ClassName: UserService
 * date: 2021/6/7/007
 *
 * @author zlk
 */
public interface UserService {
    User selectById(Integer userId);
    ResponseVO login(UserForm userForm);
    ResponseVO regist(UserForm userForm);
    ResponseVO infoUpdate(User user);
    LayUiVO selectAll(Integer pageNum,Integer pageSize);
    ResponseVO addUser(User user);

    ResponseVO passUpdate(User user);

    ResponseVO mailVerification(ForgetForm form, HttpServletRequest request);
}
