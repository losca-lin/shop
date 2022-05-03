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
    <title>商品列表</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/style/admin.css" media="all">
    <style>
        .layui-dropdown {
            height: 300px;
            overflow: auto;
        }
    </style>
</head>
<body>

<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-header">
                    <button class="layui-btn" id="category_list">
                        商品类别
                        <i class="layui-icon layui-icon-down layui-font-12"
                           style="position: relative;right: 0px;top: -30%"></i>
                    </button>
                    <div class="layui-form">
                        <div class="layui-input-inline" style="position: absolute; right: 80px;top: 2px">
                            <input type="text" name="name" placeholder="输入商品名" class="layui-input"
                                   style="border-radius: 30px;z-index: 50">
                        </div>
                        <i lay-submit lay-filter="search"
                           class="layui-btn layui-btn-radius layui-btn-primary layui-icon layui-icon-search"
                           style="position: absolute;right: 80px;top:9px;font-size: 30px;z-index: 100"></i>
                    </div>
                </div>
                <div class="layui-card-body">
                    <table class="layui-hide" id="product" lay-filter="product"></table>
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
        var dropdown = layui.dropdown;
        table.render({
            elem: '#product',
            height: 650,
            url: '${pageContext.request.contextPath}/product/allProduct', //数据接口
            page: true, //开启分页
            toolbar: "default",
            cols: [[ //表头
                {
                    type: "checkbox"
                },
                {
                    title: '类别',
                    templet: '<div>{{d.category.name}}</div>',
                    width: 90
                },
                {field: 'name', title: '商品名',},
                {field: 'subtitle', title: '简介',},
                {field: 'price', title: '价格', edit: "text", width: 80, sort: true},
                {field: 'stock', title: '库存', width: 80, sort: true},
                {
                    title: '状态',
                    width: 90,
                    templet: function (d) {
                        if (d.status == 1) {
                            return '<input type="checkbox" lay-filter="status" product_id="' + d.id + '" lay-skin="switch" lay-text="在售|下架" checked>';
                        } else {
                            return '<input type="checkbox" lay-filter="status" product_id="' + d.id + '" lay-skin="switch" lay-text="在售|下架">';
                        }

                    }

                },
            ]],
        });
        form.on('switch(status)', function (data) {
            var updateStatus = data.elem.checked ? 1 : 2;
            var productId = data.elem.getAttribute("product_id");
            var param = {
                id: productId,
                status: updateStatus
            }
            axios.post("${pageContext.request.contextPath}/product/updateProductById", param).then(function (res) {
                layer.alert(res.data.msg, {icon: 1, title: '注意啦'});
            })
        })
        table.on('edit(product)', function (obj) {
            console.log(obj)
            var reg = /(^[1-9][0-9]{0,7}$)|(^((0\.0[1-9]$)|(^0\.[1-9]\d?)$)|(^[1-9][0-9]{0,7}\.\d{1,2})$)/;
            if (reg.test(obj.value)) {
                var param = {
                    id: obj.data.id,
                    price: obj.value
                }
                axios.post("${pageContext.request.contextPath}/product/updateProductById", param).then(function (res) {
                    layer.alert(res.data.msg, {icon: 1, title: '注意啦'});
                })
            } else {
                // 不合法重新加载表格
                layer.alert("输入的值不合法", {icon: 5, title: '注意啦'}, function (index) {
                    table.reload("product");
                    layer.close(index);
                });

            }
        })

        axios.get("${pageContext.request.contextPath}/category/listLeafCategory").then(function (res) {
            var categoryList = [];
            categoryList.push(
                {
                    title: "全部类别",
                    id: -1
                }
            )
            for (var i = 0; i < res.data.data.length; i++) {
                var category = res.data.data[i];
                categoryList.push({
                        title: category.name,
                        id: category.id
                    }
                )

            }
            /*下拉选择类别事件*/
            dropdown.render({
                elem: "#category_list",
                data: categoryList,
                trigger: "hover",
                click: function (obj) {
                    table.reload('product', {
                        url: '${pageContext.request.contextPath}/product/allProduct',
                        where: {
                            categoryId: obj.id
                        } //设定异步数据接口的额外参数
                    });
                }

            })
        })
        /*为表格头部工具栏绑定事件*/
        table.on('toolbar(product)', function (obj) {
            // var checkStatus = table.checkStatus(obj.config.id);
            var data = obj.data;
            switch (obj.event) {
                case 'add':
                    top.layui.index.openTabsPage('${pageContext.request.contextPath}/product/addProductPage', '商品增加');
                    break;
                case 'delete':
                    var checkStatus = table.checkStatus('product');
                    if (checkStatus.data.length == 0) {
                        layer.msg("请选择至少一个商品再进行操作");
                        return;
                    }
                    //询问框
                    layer.confirm('您确定删除吗？', {
                        btn: ['确定', '取消'] //按钮
                    }, function (index) {
                        var url = "${pageContext.request.contextPath}/product/delProduct?";
                        for (var i = 0; i < checkStatus.data.length; i++) {
                            var item = checkStatus.data[i];
                            url += "ids=" + item.id + "&";

                        }
                        url = url.substring(0, url.length - 1);
                        axios.get(url).then(function (res) {
                            if (res.data.code == 0) {
                                layer.msg("成功", {icon: 1});
                                table.reload("product");
                            } else {
                                layer.msg(res.data.msg);
                            }
                            layer.close(index);
                        })
                    }, function () {
                    });

                    break;
                case 'update':
                    var data = table.checkStatus('product').data;
                    if (data.length == 1) {
                        layer.prompt({
                                formType: 2,
                                title: '修改商品简介',
                                value: data[0].subtitle
                            }, function (value, index) {
                                layer.close(index);
                                //获取id和简介
                                var param = {
                                    id: data[0].id,
                                    subtitle: value

                                }
                                axios.post("${pageContext.request.contextPath}/product/updateProductById", param).then(function (res) {
                                    console.log(res)
                                    if (res.data.code == 0) {
                                        table.reload("product");
                                        /*停止0.3秒加载弹窗*/
                                        setTimeout(function () {
                                            layer.msg("修改成功", {icon: 1})
                                        }, 300)
                                    } else {
                                        layer.msg(res.data.msg);
                                    }
                                })

                            }
                        );
                    } else {
                        layer.msg("请选择一个进行编辑");
                    }

                    break;
            }
        })
        form.on('submit(search)', function (data) {
            table.reload('product', {
                url: '${pageContext.request.contextPath}/product/searchProduct',
                where: {
                    name: data.field.name.trim()
                }
            })
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        });

    });
</script>
</body>
</html>
