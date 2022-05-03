package com.tjnu.shop.form;

import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 * ClassName: ResetPassForm
 * date: 2021/6/21/021
 *
 * @author zlk
 */
@Data
public class ResetPassForm {
    @NotNull(message = "id不能为空")
    private Integer id;
    @NotBlank(message = "要修改的密码不能为空")
    private String password;
}
