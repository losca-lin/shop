<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2021/6/7/007
  Time: 16:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>忘记密码</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/style/admin.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/style/login.css" media="all">
</head>
<body>

<div class="layadmin-user-login layadmin-user-display-show" id="LAY-user-login" style="display: none;">

    <div class="layadmin-user-login-main">
        <div class="layadmin-user-login-box layadmin-user-login-header">
            <h2>睿乐购</h2>
            <p>losca出品</p>
        </div>
        <div class="layadmin-user-login-box layadmin-user-login-body layui-form">

            <div class="layui-form-item">
                <label class="layadmin-user-login-icon layui-icon layui-icon-cellphone" for="LAY-user-login-email"></label>
                <input type="text" name="email" id="LAY-user-login-email" lay-verify="email" placeholder="请输入注册时的邮箱" class="layui-input">
            </div>

            <div class="layui-form-item">
                <div class="layui-row">
                    <div class="layui-col-xs7">
                        <label class="layadmin-user-login-icon layui-icon layui-icon-vercode"
                               for="LAY-user-login-vercode"></label>
                        <input type="text" name="vercode" id="LAY-user-login-vercode" lay-verify="required"
                               placeholder="图形验证码" class="layui-input">
                    </div>
                    <div class="layui-col-xs5">
                        <div style="margin-left: 10px;">
                            <img src="${pageContext.request.contextPath}/Kaptcha"
                                 id="vercode" style="width: 128px;height: 38px"
                                 onclick="changeVerifyCode(this)">
                        </div>
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <button class="layui-btn layui-btn-fluid" lay-submit lay-filter="LAY-user-login-submit" id="sendMail">发送验证码</button>
            </div>
        </div>
    </div>

    <div class="layui-trans layadmin-user-login-footer">

        <p>© 2021 losca</p>
    </div>


</div>

<script>
    function changeVerifyCode(img) {
        img.src = "${pageContext.request.contextPath}/Kaptcha?" + Math.floor(Math.random() * 100);
    }
</script>


<script src="${pageContext.request.contextPath}/layuiadmin/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/static/js/axios.min.js"></script>
<script>
    layui.config({
        base: '${pageContext.request.contextPath}/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'user', 'layer'], function () {
        var $ = layui.$;
        var setter = layui.setter;
        var admin = layui.admin;
        var form = layui.form;
        var router = layui.router();
        var search = router.search;
        var layer = layui.layer;


        //提交
        form.on('submit(LAY-user-login-submit)', function (obj) {
            layer.msg("发送中......",{icon:0});
            var field = obj.field;
            var param = {
                email:field.email,
                vercode:field.vercode
            }
            axios.post("${pageContext.request.contextPath}/user/mail",param).then(function (res){
                if (res.data.code == 0){
                    $("#vercode").click();
                    layer.msg("发送成功",{icon: 1});
                    setTimeout(function (){
                        location.href = "${pageContext.request.contextPath}/user/forgetPage"
                    },300)
                }else {
                    layer.msg(res.data.msg,{icon:2});
                }
            })


        });


    });
</script>
</body>
</html>
