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
    <title>商品增加</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/style/admin.css" media="all">
    <style>
        .layui-upload-img {
            width: 92px;
            height: 92px;
            margin: 0 10px 10px 0;
        }
    </style>
</head>
<body>

<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-card-header">表单组合</div>
        <div class="layui-card-body" style="padding: 15px;">
            <form class="layui-form" action="" lay-filter="component-form-group">
                <div class="layui-form-item">
                    <label class="layui-form-label">商品类别</label>
                    <div class="layui-input-block">
                        <select name="categoryId">
                            <option value=""></option>
                            <c:forEach items="${categoryList}" var="category">
                                <option value="${category.id}">${category.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">商品名称</label>
                    <div class="layui-input-block">
                        <input type="text" name="name" placeholder="请输入商品名称" lay-verify="required" class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">商品副标题</label>
                    <div class="layui-input-block">
                        <input type="text" name="subtitle" lay-verify="required" placeholder="请输入商品副标题"
                               class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">商品价格</label>
                    <div class="layui-input-block">
                        <input type="text" name="price" lay-verify="price" placeholder="请输入商品价格" class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">库存</label>
                    <div class="layui-input-block">
                        <input type="text" name="stock" lay-verify="stock" placeholder="请输入商品库存" class="layui-input">
                    </div>
                </div>


                <div class="layui-form-item">
                    <label class="layui-form-label">商品状态</label>
                    <div class="layui-input-block">
                        <input type="checkbox" checked name="status" lay-skin="switch" lay-text="在售|下架">
                    </div>
                </div>

                <div class="layui-form-item">
                    <div class="layui-card">
                        <div class="layui-card-header">主图</div>
                        <div class="layui-card-body">
                            <div class="layui-upload">
                                <button type="button" class="layui-btn" id="mainImage">上传图片</button>
                                <div class="layui-upload-list">
                                    <img class="layui-upload-img" id="main">
                                    <p id="test-upload-demoText"></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="layui-form-item">
                    <div class="layui-card">
                        <div class="layui-card-header">副图</div>
                        <div class="layui-card-body">
                            <div class="layui-upload">
                                <button type="button" class="layui-btn" id="subImages">多图片上传</button>
                                <blockquote class="layui-elem-quote layui-quote-nm" style="margin-top: 10px;">
                                    预览图：
                                    <div class="layui-upload-list" id="sub"></div>
                                </blockquote>
                            </div>
                        </div>
                    </div>
                </div>


                <div class="layui-form-item">
                    <div class="layui-input-block" id="detail" style="margin-top: 50px">
                    </div>
                </div>

                <div class="layui-form-item layui-layout-admin">
                    <div class="layui-input-block">
                        <div class="layui-footer" style="left: 0;">
                            <button class="layui-btn" lay-submit="" lay-filter="product_submit">立即提交</button>
                            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/static/js/wangEditor.js"></script>
<script src="${pageContext.request.contextPath}/layuiadmin/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/static/js/axios.min.js"></script>
<script>
    layui.config({
        base: '${pageContext.request.contextPath}/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'form', 'upload', 'layer'], function () {
        var $ = layui.$;
        var admin = layui.admin;
        var element = layui.element;
        var layer = layui.layer;
        var form = layui.form;
        var upload = layui.upload;
        var mainImage = '';
        var subImages = '';

        form.verify({
            price: [
                /(^[1-9][0-9]{0,7}$)|(^((0\.0[1-9]$)|(^0\.[1-9]\d?)$)|(^[1-9][0-9]{0,7}\.\d{1,2})$)/,
                "请输入合法的价格值"
            ],
            stock: [
                /^[1-9]\d*$/,
                "请输入正整数"
            ]
        })


        //普通图片上传
        upload.render({
            elem: '#mainImage',
            url: '${pageContext.request.contextPath}/img/layuiImg/',
            before: function (obj) {
                //预读本地文件示例，不支持ie8
                obj.preview(function (index, file, result) {
                    $('#main').attr('src', result); //图片链接（base64）
                });

            },
            done: function (res, index, upload) {
                if (res.code == 0) {
                    mainImage = res.data;
                } else {
                    layer.msg("文件上传失败，请重新上传");
                }
            }

        });

        //多图片上传
        upload.render({
            elem: '#subImages',
            url: '${pageContext.request.contextPath}/img/layuiImg/',
            multiple: true,
            before: function (obj) {
                //预读本地文件示例，不支持ie8
                obj.preview(function (index, file, result) {
                    $('#sub').append('<img src="' + result + '" alt="' + file.name + '" class="layui-upload-img">')
                });
            },
            done: function (res, index, upload) {
                if (res.code == 0) {
                    subImages += res.data + ",";
                } else {
                    layer.msg("文件上传失败，请重新上传");
                }

            }
        });
        /*创建富文本*/
        var E = window.wangEditor;
        var editor = new E("#detail");
        editor.config.uploadImgServer = '${pageContext.request.contextPath}/img/wangImg'
        /*设置接口参数名称*/
        editor.config.uploadFileName = 'files'
        editor.config.height = 500
        editor.config.zIndex = 500
        editor.config.excludeMenus = [
            'video'
        ]
        editor.create();
        //监控提交按钮
        form.on('submit(product_submit)', function (data) {
            var productData = data.field;
            delete productData.file;
            /*layui校验不了的自己校验*/
            if (!productData.categoryId) {
                layer.msg("请选择类别");
                return false;
            }
            /*检验主图*/
            if (!mainImage) {
                layer.msg("主图不能为空");
                return false;
            }
            /*检验副图*/
            if (!subImages) {
                layer.msg("副图不能为空");
                return false;
            }
            /*检验详情*/
            var detail = editor.txt.html();
            console.log(detail)
            if (!detail){
                layer.msg("请填写详情信息");
                return false;
            }
            //校验通过,提交数据
            productData.mainImage = mainImage;
            productData.subImages = subImages.substring(0,subImages.length-1);
            productData.detail = detail;
            productData.status = productData.status == "on"?1:2;
            axios.post("${pageContext.request.contextPath}/product/addProduct",productData).then(function (res){
                if (res.data.code == 0){
                    top.layui.index.openTabsPage('${pageContext.request.contextPath}/product/productListPage','商品列表');
                }else {
                    layer.msg(res.data.msg);
                }
            })

            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        });

    })


</script>
</body>
</html>
