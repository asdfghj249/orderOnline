<%@ page contentType="text/html;charset=UTF-8" language="java"  isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@include file="../../include/publicMeta.jsp"%>
<%@include file="../../include/publicHeader.jsp"%>
<%@include file="../../include/publicMenu.jsp"%>
<body>
<section class="Hui-article-box">
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 商品管理 <span class="c-gray en">&gt;</span> 商品分类管理 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="Hui-article">
        <article class="cl pd-20">
            <div class="cl pd-5 bg-1 bk-gray mt-20">
            <input type="text" class="input-text" style="width:150px" placeholder="输入要添加分类的名称" id="newCateName" name="">
            <button class="btn btn-secondary radius" onclick="admin_category_add()">添加分类</button>
            <font color="red">注意：如果分类无法删除的话，是因为该分类下有商品</font>
            <span class="r">共有数据：<strong>${total}</strong> 条</span> </div>

            <table class="table table-border table-bordered table-bg">
                <thead>
                <tr>
                    <th scope="col" colspan="7">分类列表</th>
                </tr>
                <tr class="text-c">
                    <th width="25"><input type="checkbox" name="" value=""></th>
                    <th width="40">ID</th>
                    <th width="100">分类名称</th>
                    <th width="100">操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${categories}" var="category" varStatus="list">
                    <tr class="text-c">
                        <td><input type="checkbox" value="1" name=""></td>
                        <td>${list.count + (page.currentPage - 1) * page.count}</td>
                        <td>${category.name}</td>
                        <td><a title="编辑" href="javascript:;" onclick="admin_category_edit('分类编辑','editCategory?id=${category.id}','1','','310')" class="ml-5" style="text-decoration:none">
                            <i class="Hui-iconfont">&#xe6df;</i></a> <a  deleteLink="true" title="删除" href="javascript:deleteCategory(${category.id})"  class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a></td>
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

    function deleteCategory(id) {
        if(confirm("确定要删除吗？")){
            $.get(
                "hasproduct",
                {id:id},
                function (result) {
                    if (result == "true"){
                        alert("该分类有商品，不能删除！")
                    }else {
                        location.href="${pageContext.request.contextPath}/category/delCategory?id="+id;
                    }
                }
            );

        }
    }


    function admin_category_add(){
       var name = $("#newCateName").val();
       $.get(
           "addCategory",
           {name:name},
           function (result) {
               location.reload();
           }
       );
    }

    function admin_category_edit(title,url,id,w,h){
        layer_show(title,url,w,h);
    }

</script>

</body>

