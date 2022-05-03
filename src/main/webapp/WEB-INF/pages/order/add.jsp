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
    <title>订单生成</title>
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
        <div class="layui-card-header">订单生成</div>
        <div class="layui-card-body" style="padding: 15px;">
            <form class="layui-form" action="" lay-filter="component-form-group">

                <div class="layui-form-item">
                    <label class="layui-form-label">用户</label>
                    <div class="layui-input-block">
                        <select name="userId" lay-verify="required">
                            <option value=""></option>
                            <c:forEach items="${userList}" var="user">
                                <option value="${user.id}">${user.username}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">金额</label>
                    <div class="layui-input-block">
                        <input type="text" name="payment" lay-verify="price" placeholder="请输入金额"
                               class="layui-input">
                    </div>
                </div>



                <div class="layui-form-item layui-layout-admin">
                    <div class="layui-input-block">
                        <div class="layui-footer" style="left: 0;">
                            <button class="layui-btn" lay-submit="" lay-filter="order_submit">立即提交</button>
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

        form.verify({
            price: [
                /(^[1-9][0-9]{0,7}$)|(^((0\.0[1-9]$)|(^0\.[1-9]\d?)$)|(^[1-9][0-9]{0,7}\.\d{1,2})$)/,
                "请输入合法的价格值"
            ]
        })


        //监控提交按钮
        form.on('submit(order_submit)', function (data) {
            console.log(data);
            var data = data.field;
            var param = {
                userId:data.userId,
                payment:data.payment

            }
            axios.post("${pageContext.request.contextPath}/order/addOrder",param).then(function (res){
                if (res.data.code == 0){
                    layer.msg("订单创建成功",{icon:1});
                    /*0.3秒之后跳转*/
                    setTimeout(function (){
                        top.layui.index.openTabsPage('${pageContext.request.contextPath}/order/listOrderPage', '订单列表');
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
