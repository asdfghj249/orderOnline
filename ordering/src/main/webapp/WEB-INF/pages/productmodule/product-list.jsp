<%@ page contentType="text/html;charset=UTF-8" language="java"  isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@include file="../../include/publicMeta.jsp"%>
<%@include file="../../include/publicHeader.jsp"%>
<%@include file="../../include/publicMenu.jsp"%>
<body>
<section class="Hui-article-box">
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页
        <span class="c-gray en">&gt;</span>
        商品管理
        <span class="c-gray en">&gt;</span>
        商品列表 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a> </nav>
    <div class="Hui-article">
        <article class="cl pd-20">
            <div class="cl pd-5 bg-1 bk-gray mt-20">
                <span class="l">
                    <a href="javascript:;" onclick="admin_add('添加商品','productAddUI','800','500')" class="btn btn-primary radius">
                        <i class="Hui-iconfont">&#xe600;</i> 添加商品
                    </a>
                </span>
                <span class="r">共有数据：<strong>${total}</strong> 条</span>
            </div>
            <table class="table table-border table-bordered table-bg" id="mytable">
                <thead>
                <tr>
                    <th scope="col" colspan="12">商品列表</th>
                </tr>
                <tr class="text-c">
                    <th width="25"><input type="checkbox" name="" value=""></th>
                    <th width="">ID</th>
                    <th width="">商品名</th>
                    <th width="">单价</th>
                    <th width="">人气</th>
                    <th width="">销量</th>
                    <th width="">商品描述</th>
                    <th width="">分类</th>
                    <th width="">所属商家</th>
                    <th width="">图片</th>
                    <th width="">是否已上线</th>
                    <th width="100">操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${products}" var="product" varStatus="list">
                    <tr class="text-c">
                        <td><input type="checkbox" value="1" name=""></td>
                        <td>${list.count + (page.currentPage - 1) * page.count}</td>
                        <td>${product.name}</td>
                        <td>${product.price}</td>
                        <td>${product.zan}</td>
                        <td>${product.number}</td>
                        <td>${fn:substring(product.miaoshu, 0, 5)}...</td>
                        <td>${product.category.name}</td>
                        <td>${product.user.name}</td>
                        <td>
                            <img src="${pageContext.request.contextPath}/${product.imageurl}" width="100px" height="50px">
                            
                        </td>
                        <td class="td-status">
                            <c:if test="${product.status==1}">
                                <span class="label label-success radius">已上线</span>
                            </c:if>
                            <c:if test="${product.status==0}">
                                <span class="label radius">已下线</span>
                            </c:if>

                        </td>

                            <td class="td-manage" >
                                <c:if test="${product.status==0}">
                                    <a  title="是否上线" style="text-decoration:none" onclick="start(this,${product.id})" href="javascript:;">
                                        <i class="Hui-iconfont">
                                            &#xe631;
                                        </i>
                                    </a>
                                </c:if>
                                <c:if test="${product.status==1}">
                                    <a  title="是否下线" style="text-decoration:none" onclick="stop(this,${product.id})" href="javascript:;">
                                        <i class="Hui-iconfont">
                                            &#xe615;
                                        </i>
                                    </a>
                                </c:if>
                                <a title="编辑" href="javascript:;" onclick="admin_edit('商品编辑','editProduct?id=${product.id}','1','800','500')" class="ml-5" style="text-decoration:none">
                                    <i class="Hui-iconfont">&#xe6df;</i>
                                </a>
                                <a deleteLink="true" title="删除" href="javascript:deleteProduct(${product.id})"  class="ml-5" style="text-decoration:none">
                                    <i class="Hui-iconfont">&#xe6e2;</i>
                                </a>
                            </td>


                    </tr>
                </c:forEach>
                </tbody>
            </table>

        </article>
        <article class="cl pd-20">
            <%@include file="../adminPage.jsp"%>
        </article>
    </div>
</section>


<%@include file="../../include/publicFooter.jsp"%>

<script type="text/javascript">

    function deleteProduct(id) {
       if(confirm("确定要删除吗？")){
           location.href="${pageContext.request.contextPath}/product/deleteProduct?id="+id;
       }
   }

    function admin_add(title,url,w,h){
        layer_show(title,url,w,h);
    }


    function admin_edit(title,url,id,w,h){
        layer_show(title,url,w,h);
    }

    //上线
    function start(obj,id) {

        layer.confirm("确定要上线吗？",function () {
            $.get(
              "startStatus",
                {id:id},
                function (result) {
                    if (result == "success"){
                        layer.msg("商品已上线!",{icon: 6,time:3000});
                        location.reload();
                    }
                }

            );
        })

    }
    //下线
    function stop(obj,id) {
        layer.confirm("确定要下线商品？",function () {
            $.get(
                "stopStatus",
                {id:id},
                function (result) {
                    if (result == "success"){
                        layer.msg("商品已下线!",{icon: 6,time:3000});
                        location.reload();
                    }
                }

            );
        })
    }




</script>

</body>

