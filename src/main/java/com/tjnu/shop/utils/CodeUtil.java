package com.tjnu.shop.utils;

import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;

/**
 * ClassName: CodeUtil
 * date: 2021/6/9/009
 *
 * @author zlk
 */
public class CodeUtil {
    public static boolean checkVerifyCode(HttpServletRequest request,String code){
        //实际的验证码
        String verifyCodeExcepted = (String)request.getSession().getAttribute(
                com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);

       if (StringUtils.isEmpty(code) || !code.equals(verifyCodeExcepted) ){
           return false;
       }
        return true;
    }

}
