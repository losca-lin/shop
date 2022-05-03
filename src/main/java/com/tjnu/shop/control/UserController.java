package com.tjnu.shop.control;

import com.alibaba.druid.sql.visitor.functions.If;
import com.tjnu.shop.VO.LayUiVO;
import com.tjnu.shop.VO.ResponseVO;
import com.tjnu.shop.bean.User;
import com.tjnu.shop.form.ForgetForm;
import com.tjnu.shop.form.PasswordForm;
import com.tjnu.shop.form.ResetPassForm;
import com.tjnu.shop.form.UserForm;
import com.tjnu.shop.service.UserService;
import com.tjnu.shop.utils.CodeUtil;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

/**
 * ClassName: UserController
 * date: 2021/6/7/007
 *
 * @author zlk
 */
@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    private JavaMailSender mailSender;

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("user");
        return "redirect:/user/loginPage";
    }

    @GetMapping("/infoPage")
    public String infoPage() {
        return "user/info";
    }

    @PostMapping("/infoUpdate")
    @ResponseBody
    public ResponseVO infoUpdate(@RequestBody User user) {
        if (StringUtils.isEmpty(user.getId())) {
            return ResponseVO.failed(1302, "用户id不能为空");
        }
        if (StringUtils.isEmpty(user.getEmail())) {
            return ResponseVO.failed(1300, "请输入要更改的邮箱");
        }
        if (StringUtils.isEmpty(user.getPhone())) {
            return ResponseVO.failed(1301, "请输入要更改的电话");
        }
        return userService.infoUpdate(user);
    }

    @GetMapping("/passwordPage")
    public String passwordPage() {
        return "user/password";
    }

    @PostMapping("/passwordUpdate")
    @ResponseBody
    public ResponseVO passwordUpdate(@RequestBody PasswordForm passwordForm) {
        String password = userService.selectById(passwordForm.getId()).getPassword();
        if (!passwordForm.getOldPassword().equals(password)) {
            return ResponseVO.failed(1400, "旧密码错误");
        }
        /*将passform对象转为user对象*/
        User user = new User();
        BeanUtils.copyProperties(passwordForm, user);
        return userService.passUpdate(user);
    }

    @GetMapping("/loginPage")
    public String loginPage() {
        return "user/login";
    }

    @PostMapping("/login")
    @ResponseBody
    public ResponseVO login(@RequestBody UserForm userForm, HttpSession session,
                            HttpServletRequest request) {
        if (StringUtils.isEmpty(userForm.getUsername())) {
            return ResponseVO.failed(1115, "请输入用户名");
        }
        if (StringUtils.isEmpty(userForm.getPassword())) {
            return ResponseVO.failed(1116, "请输入密码");
        }
        if (StringUtils.isEmpty(userForm.getCode())) {
            return ResponseVO.failed(1117, "请输入验证码");
        }
        if (!CodeUtil.checkVerifyCode(request, userForm.getCode())) {
            return ResponseVO.failed(1118, "验证码错误");
        }
        ResponseVO responseVO = userService.login(userForm);
        /*登录成功存入session*/
        if (responseVO.getCode().equals(0)) {
            session.setAttribute("user", responseVO.getData());
        }
        /*响应vo之前删除data*/
        responseVO.setData(null);
        return responseVO;
    }

    @GetMapping("/registPage")
    public String registPage() {
        return "user/reg";
    }

    @PostMapping("/regist")
    @ResponseBody
    public ResponseVO regist(@RequestBody UserForm userForm) {
        if (StringUtils.isEmpty(userForm.getUsername())) {
            return ResponseVO.failed(1200, "请输入用户名");
        }
        if (StringUtils.isEmpty(userForm.getPassword())) {
            return ResponseVO.failed(1201, "请输入用户密码");
        }
        return userService.regist(userForm);
    }

    @GetMapping("/userListPage")
    public String userListPage() {
        return "user/list";
    }

    /*用户列表接口*/
    @GetMapping("/userList")
    @ResponseBody
    public LayUiVO userList(@RequestParam(defaultValue = "1") Integer page,
                            @RequestParam(defaultValue = "10") Integer limit) {
        return userService.selectAll(page, limit);
    }

    @GetMapping("/addUserPage")
    public String addUserPage() {
        return "user/add";
    }

    @PostMapping("/addUser")
    @ResponseBody
    public ResponseVO addUser(@RequestBody User user) {
        if (StringUtils.isEmpty(user.getUsername())) {
            return ResponseVO.failed(1308, "请输入用户名");
        }
        if (StringUtils.isEmpty(user.getPassword())) {
            return ResponseVO.failed(1309, "请输入密码");
        }
        if (StringUtils.isEmpty(user.getPhone())) {
            return ResponseVO.failed(1310, "请输入手机号");
        }
        if (StringUtils.isEmpty(user.getEmail())) {
            return ResponseVO.failed(1311, "请输入邮箱");
        }
        return userService.addUser(user);


    }

    @PostMapping("/updateUserById")
    @ResponseBody
    public ResponseVO updateUserById(@RequestBody User user) {
        if (user.getId() == null) {
            return ResponseVO.failed(1312, "id不能为空");
        }
        return userService.infoUpdate(user);
    }

    @GetMapping("/getCodePage")
    public String getCodePage() {
        return "user/getCode";
    }

    @GetMapping("/forgetPage")
    public String forgetPage(HttpServletRequest request) {
        /*没发送验证码返回到登录页*/
        HttpSession session = request.getSession();
        Object code = session.getAttribute("code");
        if (code == null){
            return "redirect:/user/loginPage";
        }
        return "user/forget";
    }

    @GetMapping("/forget")
    @ResponseBody
    public ResponseVO forget(String code, HttpServletRequest request) {
        HttpSession session = request.getSession();
        /*正确的验证码*/
        String code1 = (String) session.getAttribute("code");
        if (!code1.equals(code)){
            return ResponseVO.failed(1611,"邮箱验证码错误");
        }
        return ResponseVO.success();
    }

    @PostMapping("/mail")
    @ResponseBody
    public ResponseVO mail(@RequestBody ForgetForm form, HttpServletRequest request, BindingResult result) {
        if (result.getErrorCount() > 0) {
            return ResponseVO.failed(1502, result.getAllErrors().get(0).getDefaultMessage());
        }
        ResponseVO responseVO = userService.mailVerification(form, request);
        if (responseVO.getCode() != 0) {
            return responseVO;
        }
        String[] str = new String[]{"1", "2", "3", "4", "5", "6", "7", "8", "9", "0"};
        List<String> list = Arrays.asList(str);
        Collections.shuffle(list);
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < list.size(); i++) {
            sb.append(list.get(i));
        }

        String msg = "验证码为：" + sb.substring(0, 4);

        try {
            MimeMessage mimeMessage = mailSender.createMimeMessage();
            MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage, true, "utf-8");
            messageHelper.setFrom("783840358@qq.com");//发件人
            messageHelper.setTo(form.getEmail());
            messageHelper.setSubject(msg);
            messageHelper.setText("请尽快填写验证码", true);//true代表支持html格式
            mailSender.send(mimeMessage);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseVO.failed(1600, "发送失败");
        }
        HttpSession session = request.getSession();
        session.setAttribute("code", sb.substring(0, 4));
        session.setAttribute("user",responseVO.getData());
        return responseVO;

    }

    @PostMapping("/changePass")
    @ResponseBody
    public ResponseVO changePass(@RequestBody @Valid ResetPassForm passForm, BindingResult result){
        if (result.getErrorCount() > 0){
            return ResponseVO.failed(1620,result.getAllErrors().get(0).getDefaultMessage());
        }
        User user = new User();
        BeanUtils.copyProperties(passForm,user);
        return userService.passUpdate(user);
    }


}
