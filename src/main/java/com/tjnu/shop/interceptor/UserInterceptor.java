package com.tjnu.shop.interceptor;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tjnu.shop.VO.ResponseVO;
import com.tjnu.shop.bean.User;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.lang.reflect.Method;

/**
 * ClassName: UserInterceptor
 * date: 2021/6/7/007
 *
 * @author zlk
 */
public class UserInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        /*没有登录跳转回登录页*/
        if (user == null){
            /*获取调用的方法注解*/
            HandlerMethod handlerMethod = (HandlerMethod) handler;
            Method method = handlerMethod.getMethod();
            ResponseBody responseBody = method.getDeclaredAnnotation(ResponseBody.class);
            if (responseBody != null){
                /*设置响应头为json格式*/
                response.setContentType("application/json;charset=utf-8");
                /*拦截ajax返回vo*/
                ResponseVO responseVO = ResponseVO.failed(403,"请先登录再操作");
                /*将vo转换为json格式*/
                ObjectMapper objectMapper = new ObjectMapper();
                String s = objectMapper.writeValueAsString(responseVO);
                PrintWriter writer = response.getWriter();
                writer.print(s);
                writer.close();

            }else {
                /*拦截页面跳转回登录页*/
                response.sendRedirect(request.getServletContext().getContextPath()+"/user/loginPage");
            }
            return false;
        }
        return true;
    }
}
