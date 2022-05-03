<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2021/5/26/026
  Time: 10:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>管理员列表</title>
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
                <div class="layui-card-header">
                    管理员列表
                </div>
                <div class="layui-card-body">
                    <table class="layui-hide" id="user" lay-filter="user"></table>
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
    }).use(['index', 'table', 'form', 'layer', 'dropdown'], function () {
        var index = layui.index;
        var table = layui.table;
        var form = layui.form;
        var layer = layui.layer;
        table.render({
            elem: '#user',
            height: 450,
            url: '${pageContext.request.contextPath}/user/userList', //数据接口
            page: true, //开启分页
            toolbar: "default",
            cols: [[ //表头
                {
                    type: "checkbox"
                },

                {field: 'username', title: '用户名'},
                {field: 'email', title: '邮箱', edit: "text"},
                {field: 'phone', title: '手机', edit: "text"},
            ]],
        });


        /*为表格头部工具栏绑定事件*/
        table.on('toolbar(user)', function (obj) {
            // var checkStatus = table.checkStatus(obj.config.id);
            var data = obj.data;
            switch (obj.event) {
                case 'add':
                    top.layui.index.openTabsPage('${pageContext.request.contextPath}/user/addUserPage', '用户增加');
                    break;
                case 'delete':
                    var checkStatus = table.checkStatus('user');
                    console.log(checkStatus);
                    layer.msg("不可删除用户", {icon: 2})
                    break;
                case 'update':
                    layer.msg("请双击单元格进行编辑", {icon: 2})
                    break;
            }
        })

        /*编辑事件*/
        table.on('edit(user)', function (obj) {
            /*编辑事件为email*/
            if (obj.field == "email") {
                var reg = /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,})$/;
                /*trim()去掉空格*/
                if (reg.test(obj.value.trim())) {
                    var param = {
                        id: obj.data.id,
                        email: obj.value.trim()
                    }
                    axios.post("${pageContext.request.contextPath}/user/updateUserById", param).then(function (res) {
                        if (res.data.code == 0){
                            layer.alert("修改成功", {icon: 1, title: '注意啦'});
                        }else {
                            layer.alert(res.data.msg, {icon: 2, title: '注意啦'},function (index){
                                table.reload("user");
                                layer.close(index);
                            });
                        }
                    })
                } else {
                    // 不合法重新加载表格
                    layer.alert("邮箱格式错误", {icon: 5, title: '注意啦'}, function (index) {
                        table.reload("user");
                        layer.close(index);
                    });

                }
            }
            if (obj.field == "phone"){
                var reg = /^1[3456789]\d{9}$/;
                if (reg.test(obj.value.trim())) {
                    var param = {
                        id: obj.data.id,
                        phone: obj.value.trim()
                    }
                    axios.post("${pageContext.request.contextPath}/user/updateUserById", param).then(function (res) {
                        if (res.data.code == 0){
                            layer.alert("修改成功", {icon: 1, title: '注意啦'});
                        }else {
                            layer.alert(res.data.msg, {icon: 2, title: '注意啦'},function (index){
                                table.reload("user");
                                layer.close(index);
                            });
                        }
                    })
                } else {
                    // 不合法重新加载表格
                    layer.alert("手机号格式错误", {icon: 5, title: '注意啦'}, function (index) {
                        table.reload("user");
                        layer.close(index);
                    });

                }

            }

        });

    });
</script>
</body>
</html>
