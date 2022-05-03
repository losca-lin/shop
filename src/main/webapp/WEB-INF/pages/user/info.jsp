<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2021/6/9/009
  Time: 9:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>设置我的资料</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/style/admin.css" media="all">
</head>
<body>

<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-header">设置我的资料</div>
                <div class="layui-card-body" pad15>

                    <form class="layui-form" lay-filter="userForm">
                        <input type="hidden" name="id" value="${sessionScope.user.id}">
                        <div class="layui-form-item">
                            <label class="layui-form-label">用户名</label>
                            <div class="layui-input-inline">
                                <input type="text" name="username" value="${sessionScope.user.username}" readonly
                                       class="layui-input">
                            </div>
                            <div class="layui-form-mid layui-word-aux">不可修改。一般用于后台登入名</div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">手机</label>
                            <div class="layui-input-inline">
                                <input type="text" name="phone" value="${sessionScope.user.phone}"
                                       lay-verify="phone" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">邮箱</label>
                            <div class="layui-input-inline">
                                <input type="text" name="email" value="${sessionScope.user.email}" lay-verify="email"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-input-block">
                                <button class="layui-btn" lay-submit lay-filter="setmyinfo">确认修改</button>
                                <button type="reset" class="layui-btn layui-btn-primary">重新填写</button>
                            </div>
                        </div>
                    </form>

                </div>
            </div>
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
    }).use(['index', 'set', 'form'], function () {
        var form = layui.form;
        /*获取表单值*/
        var data = form.val("userForm");
        delete data.username;
        console.log(data);
        form.on('submit(setmyinfo)', function (obj) {
            //请求接口
            var param = {
                id: obj.field.id,
                phone: obj.field.phone,
                email: obj.field.email
            }
            if (JSON.stringify(data) == JSON.stringify(param)) {
                layer.msg("请修改后再操作");
            } else {
                axios.post("${pageContext.request.contextPath}/user/infoUpdate", param).then(function (res) {
                    if (res.data.code == 0) {
                        layer.msg("修改成功,请重新登录", {icon: 1});
                        setTimeout(function (){
                            parent.location.href = "${pageContext.request.contextPath}/user/logout"
                        },300);
                    } else {
                        layer.msg(res.data.msg, {icon: 5});
                    }

                })
            }
            return false;
        });
    });
</script>
</body>
</html>