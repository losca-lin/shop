<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2021/6/18/018
  Time: 11:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>类别图表</title>
</head>
<body>
<!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
<div id="main" style="width: 600px;height:400px;"></div>
<script src="${pageContext.request.contextPath}/static/js/echarts.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/axios.min.js"></script>
<script src="${pageContext.request.contextPath}/layuiadmin/layui/layui.js"></script>
<script>
    layui.use("layer",function (){
        var layer = layui.layer;

        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));
        myChart.showLoading();
        // 指定图表的配置项和数据
        axios.get("${pageContext.request.contextPath}/category/categoryShow").then(function (res) {
            myChart.hideLoading();
            var option = {
                title: {
                    text: '睿乐购商城'
                },
                tooltip: {},
                legend: {
                    data: ['总数']
                },
                xAxis: {
                    /*x轴显示太多将字体竖立显示*/
                    axisLabel: {
                        interval: 0,
                        formatter:function(value){
                            return value.split("").join("\n");}
                    },
                    data: res.data.xaxisData
                },
                yAxis: {},
                series: [{
                    name: '总数',
                    type: 'bar',
                    data: res.data.detailData
                }]
            };

            // 使用刚指定的配置项和数据显示图表。
            myChart.setOption(option);
            myChart.on('dblclick', function (params) {
                // 控制台打印数据的名称
                console.log(params.name);
                /*双击跳转到商品列表界面*/
                layer.alert("点击确定跳转到商品列表页", {icon: 0, title: '注意啦'},function (index){
                    top.layui.index.openTabsPage('${pageContext.request.contextPath}/product/productListPage','商品列表');
                    layer.close(index);
                });

            });
        })
    })


</script>


</body>
</html>
