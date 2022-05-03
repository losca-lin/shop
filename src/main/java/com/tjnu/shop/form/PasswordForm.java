package com.tjnu.shop.form;

import lombok.Data;

/**
 * ClassName: PasswordForm
 * date: 2021/6/9/009
 *
 * @author zlk
 */
@Data
public class PasswordForm {
    private Integer id;
    /*旧密码*/
    private String oldPassword;
    /*新密码*/
    private String password;
}
