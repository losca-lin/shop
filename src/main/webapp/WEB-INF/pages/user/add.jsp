<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2021/5/31/031
  Time: 17:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>用户增加</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/style/admin.css" media="all">
</head>
<body>

<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-card-header">用户增加</div>
        <div class="layui-card-body" style="padding: 15px;">
            <form class="layui-form" action="" lay-filter="component-form-group">

                <div class="layui-form-item">
                    <label class="layui-form-label">用户名</label>
                    <div class="layui-input-block">
                        <input type="text" name="username" placeholder="请输入用户名" lay-verify="required"
                               class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">密码</label>
                    <div class="layui-input-block">
                        <input type="text" name="password" lay-verify="required" placeholder="请输入密码"
                               class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">邮箱</label>
                    <div class="layui-input-block">
                        <input type="text" name="email" lay-verify="email" placeholder="请输入邮箱" class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">手机</label>
                    <div class="layui-input-block">
                        <input type="text" name="phone" lay-verify="phone" placeholder="请输入手机号" class="layui-input">
                    </div>
                </div>


                <div class="layui-form-item layui-layout-admin">
                    <div class="layui-input-block">
                        <div class="layui-footer" style="left: 0;">
                            <button class="layui-btn" lay-submit="" lay-filter="user_submit">立即提交</button>
                            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/layuiadmin/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/static/js/axios.min.js"></script>
<script>
    layui.config({
        base: '${pageContext.request.contextPath}/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'form', 'layer'], function () {
        var $ = layui.$;
        var admin = layui.admin;
        var element = layui.element;
        var layer = layui.layer;
        var form = layui.form;


        //监控提交按钮
        form.on('submit(user_submit)', function (data) {
            var data = data.field;
            var param = {
                username:data.username,
                password:data.password,
                email:data.email,
                phone:data.phone
            }
            axios.post("${pageContext.request.contextPath}/user/addUser",param).then(function (res){
                if (res.data.code == 0){
                    layer.msg("添加成功",{icon:1});
                    /*0.3秒之后跳转*/
                    setTimeout(function (){
                        top.layui.index.openTabsPage('${pageContext.request.contextPath}/user/userListPage', '用户列表');
                    },300)
                }else {
                    layer.msg(res.data.msg,{icon: 2});
                }
            })
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        });

    })


</script>
</body>
</html>
