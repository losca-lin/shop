package com.tjnu.shop.form;

import lombok.Data;

import javax.validation.constraints.NotBlank;

/**
 * ClassName: ForgetForm
 * date: 2021/6/20/020
 *
 * @author zlk
 */
@Data
public class ForgetForm {
    @NotBlank(message = "邮箱不能为空")
    private String email;
    /*图形验证码*/
    @NotBlank(message = "图片验证码不能为空")
    private String vercode;
}
