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
    <title>订单列表</title>
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
                    订单列表
                </div>
                <div class="layui-card-body">
                    <table class="layui-hide" id="order" lay-filter="order"></table>
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
            elem: '#order',
            height: 450,
            url: '${pageContext.request.contextPath}/order/listOrder', //数据接口
            page: true, //开启分页
            toolbar: "default",
            cols: [[ //表头
                {
                    type: "checkbox"
                },
                {field: 'orderNo', title: '订单号'},
                {title: '用户名称',templet:"<div>{{d.user.username}}</div>"},
                {field: 'payment', title: '付款金额'},
                {field: 'createTime', title: '创建时间'},
                {field: 'updateTime', title: '更新时间'},
            ]],
        });


        /*为表格头部工具栏绑定事件*/
        table.on('toolbar(order)', function (obj) {
            // var checkStatus = table.checkStatus(obj.config.id);
            switch (obj.event) {
                case 'add':
                    top.layui.index.openTabsPage('${pageContext.request.contextPath}/order/addOrderPage', '订单生成');
                    break;
                case 'delete':
                    var checkStatus = table.checkStatus('order');
                    if (checkStatus.data.length == 0) {
                        layer.msg("请选择至少一个订单再进行操作");
                        return;
                    }
                    //询问框
                    layer.confirm('您确定删除吗？', {
                        btn: ['确定', '取消'] //按钮
                    }, function (index) {
                        var url = "${pageContext.request.contextPath}/order/delOrder?";
                        for (var i = 0; i < checkStatus.data.length; i++) {
                            var item = checkStatus.data[i];
                            url += "ids=" + item.id + "&";

                        }
                        url = url.substring(0, url.length - 1);
                        axios.get(url).then(function (res) {
                            if (res.data.code == 0) {
                                layer.msg("成功", {icon: 1});
                                table.reload("order");
                            } else {
                                layer.msg(res.data.msg);
                            }
                            layer.close(index);
                        })
                    }, function () {
                    });
                    break;
                case 'update':
                    layer.msg("订单不可编辑", {icon: 2})
                    break;
            }
        })


    });
</script>
</body>
</html>
