<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2021/6/20/020
  Time: 16:59
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
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/style/admin.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/style/login.css" media="all">
</head>

<div class="layadmin-user-login layadmin-user-display-show" id="LAY-user-login" style="display: none;">
    <div class="layadmin-user-login-main">
        <div class="layadmin-user-login-box layadmin-user-login-header">
            <h2>睿乐购</h2>
            <p>忘记密码</p>
        </div>
        <div class="layadmin-user-login-box layadmin-user-login-body layui-form">

            <script type="text/html" template>
                {{# if(layui.router().search.type === 'resetpass'){ }}
                <input type="hidden" name="id" value="${user.id}"/>
                <div class="layui-form-item">
                    <label class="layadmin-user-login-icon layui-icon layui-icon-password" for="LAY-user-login-password"></label>
                    <input type="password" name="password" id="LAY-user-login-password" lay-verify="pass" placeholder="新密码" class="layui-input">
                </div>
                <div class="layui-form-item">
                    <label class="layadmin-user-login-icon layui-icon layui-icon-password" for="LAY-user-login-repass"></label>
                    <input type="password" name="repass" id="LAY-user-login-repass" lay-verify="required" placeholder="确认密码" class="layui-input">
                </div>
                <div class="layui-form-item">
                    <button class="layui-btn layui-btn-fluid" lay-submit lay-filter="LAY-user-forget-resetpass">重置新密码</button>
                </div>
                {{# } else { }}
                <div class="layui-form-item">
                    <div class="layui-row">
                        <div class="layui-col-xs7">
                            <label class="layadmin-user-login-icon layui-icon layui-icon-vercode" for="LAY-user-login-smscode"></label>
                            <input type="text" name="code" id="LAY-user-login-smscode" lay-verify="required" placeholder="邮箱验证码" class="layui-input">
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <button class="layui-btn layui-btn-fluid" lay-submit lay-filter="LAY-user-forget-submit">找回密码</button>
                </div>
                {{# } }}
            </script>

        </div>
    </div>

    <div class="layui-trans layadmin-user-login-footer">

        <p>© 2021 losca</p>
    </div>
</div>

<script src="${pageContext.request.contextPath}/layuiadmin/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/static/js/axios.min.js"></script>
<script>
    layui.config({
        base: '${pageContext.request.contextPath}/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'user','layer'], function(){
        var $ = layui.$;
        var setter = layui.setter;
        var admin = layui.admin;
        var form = layui.form;
        var router = layui.router();
        var layer = layui.layer;


        //找回密码下一步
        form.on('submit(LAY-user-forget-submit)', function(obj){
            var code = obj.field.code;
            var url = "${pageContext.request.contextPath}/user/forget/?code=" + code;
            axios.get(url).then(function (res){
                if (res.data.code == 0){
                    layer.msg("成功",{icon: 1});
                    setTimeout(function (){
                        location.hash = '/type=resetpass';
                        location.reload();
                    },300);

                }else {
                    layer.msg(res.data.msg, {icon: 5});
                }
            })

            return false;
        });


        //重置密码
        form.on('submit(LAY-user-forget-resetpass)', function(obj){
            var field = obj.field;

            //确认密码
            if(field.password !== field.repass){
                return layer.msg('两次密码输入不一致');
            }

            //请求接口
            var param = {
                id:field.id,
                password:field.password
            }
            axios.post("${pageContext.request.contextPath}/user/changePass",param).then(function (res){
                if (res.data.code == 0){
                    layer.confirm("密码修改成功,点击重新登录",{icon:1},function (index){
                        location.href = "${pageContext.request.contextPath}/user/loginPage";
                        layer.close(index);
                    })
                }else {
                    layer.msg(res.data.msg,{icon:2});
                }
            })

            return false;
        });

    });
</script>
</body>
</html>
