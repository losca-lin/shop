package com.tjnu.shop.service.Impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.tjnu.shop.VO.LayUiVO;
import com.tjnu.shop.VO.ResponseVO;
import com.tjnu.shop.bean.User;
import com.tjnu.shop.form.ForgetForm;
import com.tjnu.shop.form.UserForm;
import com.tjnu.shop.mapper.UserMapper;
import com.tjnu.shop.service.UserService;
import com.tjnu.shop.utils.CodeUtil;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * ClassName: UserServiceImpl
 * date: 2021/6/7/007
 *
 * @author zlk
 */
@Service

public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;

    @Override
    public User selectById(Integer userId) {
        return userMapper.selectById(userId);
    }

    @Override
    public ResponseVO login(UserForm userForm) {
        User userdata = userMapper.selectByUsername(userForm.getUsername());
        if (userdata == null) {
            return ResponseVO.failed(1113, "没有此用户");
        }
        if (!userdata.getPassword().equals(userForm.getPassword())) {
            return ResponseVO.failed(1114, "密码错误");
        }
        return ResponseVO.success(userdata);
    }

    @Override
    public ResponseVO regist(UserForm userForm) {
        /*验证数据库是否存在用户*/
        if (userMapper.selectByUsername(userForm.getUsername()) != null) {
            return ResponseVO.failed(1202, "用户已存在");
        }
        /*将userForm转换为user对象*/
        User user = new User();
        BeanUtils.copyProperties(userForm, user);
        userMapper.insertUser(user);
        return ResponseVO.success();
    }


    /*管理员修改信息*/
    @Override
    public ResponseVO infoUpdate(User user) {
        List<User> users = userMapper.selectAll();
        for (User user1 : users) {
            if (user.getEmail() != null) {
                if (user.getEmail().equals(user1.getEmail())) {
                    return ResponseVO.failed(1305, "邮箱已经被绑定");
                }
            } else if (user.getPhone() != null) {
                if (user.getPhone().equals(user1.getPhone())) {
                    return ResponseVO.failed(1306, "手机号已经被绑定");
                }
            } else {
                return ResponseVO.failed(1307, "邮箱/手机号不能为空");
            }

        }
        int i = userMapper.updateUser(user);
        if (i == 0) {
            return ResponseVO.failed(1304, "修改失败");
        }
        return ResponseVO.success();
    }

    @Override
    public LayUiVO selectAll(Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        PageInfo pageInfo = PageInfo.of(userMapper.selectAll());
        return LayUiVO.success(pageInfo.getTotal(), pageInfo.getList());
    }

    @Override
    public ResponseVO addUser(User user) {
        /*验证数据合法性,判断用户名、手机号、邮箱是否已经注册*/
        User userdata = userMapper.selectByUsername(user.getUsername());
        if (userdata != null) {
            return ResponseVO.failed(1202, "用户已存在");
        }
        List<User> users = userMapper.selectAll();
        for (User user1 : users) {
            /*null.equals会报空指针异常*/
            if (user.getPhone().equals(user1.getPhone())) {
                return ResponseVO.failed(1306, "该手机已注册");
            }
            if (user.getEmail().equals(user1.getEmail())) {
                return ResponseVO.failed(1307, "该邮箱已注册");
            }
        }
        int i = userMapper.addUser(user);
        if (i == 0) {
            return ResponseVO.failed(1305, "添加失败");
        }
        return ResponseVO.success();
    }

    /*用户修改密码*/
    @Override
    public ResponseVO passUpdate(User user) {
        int i = userMapper.updateUser(user);
        if (i == 0) {
            return ResponseVO.failed(1304, "修改失败");
        }
        return ResponseVO.success();
    }

    /*忘记密码*/
    @Override
    public ResponseVO mailVerification(ForgetForm form, HttpServletRequest request) {
        String email = form.getEmail();
        if (userMapper.selectByEmail(email) == null) {
            return ResponseVO.failed(1500,"该邮箱还没有绑定用户");
        }
        if (!CodeUtil.checkVerifyCode(request,form.getVercode())){
            return ResponseVO.failed(1501,"图片验证码错误");
        }
        return ResponseVO.success(userMapper.selectByEmail(email));
    }
}
